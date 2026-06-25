import SwiftUI

// MARK: - 完整功能解锁付费墙（移植自 PhysicsApex）

struct PaywallView: View {
    @ObservedObject private var purchase = PurchaseManager.shared
    @Environment(\.dismiss) private var dismiss

    private var priceLabel: String { purchase.product?.displayPrice ?? "¥22" }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                heroArea

                VStack(alignment: .leading, spacing: 14) {
                    benefitRow(icon: "book.fill", color: .apexStarBlue,
                               title: "解锁阅读理解关 · 37.5 分主战场",
                               desc: "细节/主旨/推理/词义猜测四题型定位策略，权重最大的模块系统打")
                    benefitRow(icon: "envelope.fill", color: .apexGold,
                               title: "应用文工坊全部 6 体裁 · 12 个场景",
                               desc: "求助/建议/感谢/道歉/通知/海报各 2 个场景的骨架+范文，外加写作教练帮你挑自己草稿的语病")
                    benefitRow(icon: "pencil.and.scribble", color: .apexMystery,
                               title: "读后续写工坊全部 6 主题 · 12 个场景 · 25 分高地",
                               desc: "情节链 + 高分句式，6 大主题各 2 个场景练迁移，写作教练检查你是否真的承接了给定首句")
                    benefitRow(icon: "ear", color: .apexDanger,
                               title: "解锁听力关 · 30 分预判训练",
                               desc: "离线语音合成朗读 + 设问预判决策树，场景词/数字修正/态度推断全覆盖")
                    benefitRow(icon: "scope", color: .apexLava,
                               title: "提分雷达对全模块开放",
                               desc: "估分、ROI 排序、错因诊断对 7 个模块全程导航")
                    benefitRow(icon: "doc.text.magnifyingglass", color: .apexStarBlue,
                               title: "完整模考 · 50 题 + 考点级薄弱报告",
                               desc: "不只告诉你哪个模块弱，精确到具体考点(如'强调句·not until')，知道该补哪一刀")
                    benefitRow(icon: "infinity", color: .apexEmerald,
                               title: "一次买断，永久使用",
                               desc: "无订阅、无续费，内容持续更新；支持换机恢复购买")
                }
                .padding(.horizontal, 24).padding(.top, 28).padding(.bottom, 20)

                Divider().padding(.horizontal, 24)

                VStack(spacing: 6) {
                    Text("免费已开放：主线前 \(PurchaseManager.freeLevelCount) 关（语法填空 / 完形 / 七选五）完整可练；两个工坊每个体裁/主题第 1 个场景免费预览；估分器 / 提分雷达 / 考点图谱 / 句式库 / 词汇专项 / 错题本永久免费")
                        .font(.footnote).foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    Text("先免费练前三关感受算法导航，再解锁全套 →")
                        .font(.footnote).fontWeight(.medium).foregroundColor(.apexLava)
                }
                .padding(.vertical, 16).padding(.horizontal, 24)

                purchaseButton.padding(.horizontal, 24)

                Button { Task { await purchase.restore() } } label: {
                    Text("恢复购买").font(.footnote).foregroundColor(.secondary).underline()
                }
                .padding(.top, 12).disabled(purchase.isPurchasing)

                if let err = purchase.errorMessage {
                    Text(err).font(.caption).foregroundColor(.apexDanger)
                        .multilineTextAlignment(.center).padding(.horizontal, 24).padding(.top, 8)
                }

                Text("购买即视为同意[用户协议](https://botonwa83-byte.github.io/engapex/terms.html)与[隐私政策](https://botonwa83-byte.github.io/engapex/privacy.html)。付款通过 Apple 账户完成，换机后可在「恢复购买」找回。")
                    .font(.system(size: 10)).foregroundColor(.secondary)
                    .tint(.apexLava)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 28).padding(.top, 16).padding(.bottom, 32)
            }
        }
        .background(Color.apexBackground.ignoresSafeArea())
        .onChange(of: purchase.isUnlocked) { unlocked in
            if unlocked { dismiss() }
        }
    }

    private var heroArea: some View {
        ZStack {
            LinearGradient(colors: [Color.apexLava, Color.apexMystery],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack(spacing: 10) {
                Image(systemName: "graduationcap.fill").font(.system(size: 44)).foregroundColor(.white)
                Text("解锁全部提分关卡").font(.system(size: 24, weight: .black, design: .rounded)).foregroundColor(.white)
                Text("不是多给你几道题，是用算法带你冲高分").font(.subheadline).foregroundColor(.white.opacity(0.9))
            }
            .padding(.vertical, 40)
        }
    }

    private var purchaseButton: some View {
        Button { Task { await purchase.purchase() } } label: {
            HStack(spacing: 10) {
                if purchase.isPurchasing { ProgressView().tint(.white) }
                else { Image(systemName: "lock.open.fill") }
                Text(purchase.isPurchasing ? "处理中…" : "立即解锁  \(priceLabel)").fontWeight(.bold)
            }
            .font(.headline).foregroundColor(.white)
            .frame(maxWidth: .infinity).padding(.vertical, 16)
            .background(LinearGradient(colors: [.apexLava, .apexMystery], startPoint: .leading, endPoint: .trailing))
            .cornerRadius(16)
            .shadow(color: Color.apexLava.opacity(0.3), radius: 10, y: 4)
        }
        .disabled(purchase.isPurchasing)
    }

    private func benefitRow(icon: String, color: Color, title: String, desc: String) -> some View {
        HStack(alignment: .top, spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(color.opacity(0.15)).frame(width: 38, height: 38)
                Image(systemName: icon).font(.subheadline).foregroundColor(color)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.subheadline).fontWeight(.semibold).foregroundColor(.primary)
                Text(desc).font(.caption).foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}
