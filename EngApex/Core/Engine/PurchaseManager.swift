import StoreKit
import SwiftUI

// MARK: - 完整功能解锁 IAP（StoreKit 2 · 一次性买断，移植自 Apex 家族）
//
// 产品 ID：com.engapex.app.full_unlock（¥22 一次性买断，价格在 App Store Connect 配置）
// 免费档：主线前 3 关（语法填空 / 完形 / 七选五，含其全部题）+ 提分驾驶舱 / 估分器 / 提分雷达 /
//        考点图谱 / 句式库 / 错题本 永久免费（习惯与转化钩子）。
// 解锁后：主线 6 关全开（阅读 / 应用文 / 读后续写）与后续更新内容。
// 本地 UserDefaults 缓存即时呈现，启动时 Transaction.currentEntitlements 核验防破解。

final class PurchaseManager: ObservableObject {
    static let shared = PurchaseManager()

    let productID = "com.engapex.app.full_unlock"

    /// 免费档：主线前 freeLevelCount 关免费，其余付费解锁。
    static let freeLevelCount = 3

    @Published private(set) var isUnlocked: Bool = false
    @Published private(set) var product: Product?
    @Published private(set) var isPurchasing: Bool = false
    @Published private(set) var errorMessage: String?

    private let storageKey = "engapex_full_unlocked"

    private init() {
        isUnlocked = UserDefaults.standard.bool(forKey: storageKey)
        Task {
            await loadProduct()
            await refreshEntitlements()
        }
    }

    // MARK: 免费档判定

    /// 主线关卡是否被付费锁住：前 freeLevelCount 关免费。
    func isLevelLocked(_ level: MainLevel) -> Bool {
        guard !isUnlocked else { return false }
        return level.order > Self.freeLevelCount
    }

    // MARK: StoreKit

    @MainActor
    func loadProduct() async {
        do {
            let products = try await Product.products(for: [productID])
            product = products.first
        } catch {
            // 沙盒未配置时静默失败，价格降级显示
        }
    }

    @MainActor
    func purchase() async {
        guard let product else {
            errorMessage = "获取产品信息失败，请检查网络后重试"
            return
        }
        isPurchasing = true
        errorMessage = nil
        defer { isPurchasing = false }
        do {
            let result = try await product.purchase()
            switch result {
            case .success(let verification):
                let transaction = try checkVerified(verification)
                await transaction.finish()
                unlock()
            case .userCancelled:
                break
            case .pending:
                errorMessage = "购买待处理（可能需要家长确认），完成后将自动解锁"
            @unknown default:
                break
            }
        } catch {
            errorMessage = "购买失败：\(error.localizedDescription)"
        }
    }

    @MainActor
    func restore() async {
        isPurchasing = true
        errorMessage = nil
        defer { isPurchasing = false }
        do {
            try await AppStore.sync()
            await refreshEntitlements()
            if !isUnlocked { errorMessage = "未找到购买记录" }
        } catch {
            errorMessage = "恢复失败：\(error.localizedDescription)"
        }
    }

    func refreshEntitlements() async {
        for await result in Transaction.currentEntitlements {
            if case .verified(let tx) = result,
               tx.productID == productID,
               tx.revocationDate == nil {
                await MainActor.run { unlock() }
                return
            }
        }
    }

    @MainActor
    private func unlock() {
        isUnlocked = true
        UserDefaults.standard.set(true, forKey: storageKey)
    }

    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified(_, let error): throw error
        case .verified(let value): return value
        }
    }
}
