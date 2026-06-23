import SwiftUI

/// 单题统计。
struct QStat: Codable {
    var attempts: Int = 0
    var correct: Int = 0
    var lastWrong: Bool = false
}

/// 持久化的错因信号（ErrorSignal 不直接 Codable，这里存其原料）。
struct StoredSignal: Codable {
    let module: String
    let cause: String
    let date: Date
}

/// EngApex 的状态中枢：记录做题数据 → 喂三大算法引擎 → 驱动整个 UI。
/// 持久化用 UserDefaults（Codable blob），离线、无后端。
final class EngStore: ObservableObject {
    static let shared = EngStore()

    @Published private(set) var stats: [String: QStat] = [:]      // questionId -> 统计
    @Published private(set) var signals: [StoredSignal] = []      // 错因历史
    @Published private(set) var completedLevels: Set<String> = [] // 已完成关卡 id
    @Published private(set) var flagged: Set<String> = []         // 错题本收藏
    @Published private(set) var masteredPoints: Set<String> = []   // 高频考点·已掌握

    private let key = "engstore.v1"

    private init() { load() }

    // MARK: - 写入

    /// 记录一次作答；若答错且带自评信号，则归因并入库。
    func record(_ q: Question, correct: Bool, signal: ErrorSignal? = nil) {
        var s = stats[q.id] ?? QStat()
        s.attempts += 1
        if correct { s.correct += 1 }
        s.lastWrong = !correct
        stats[q.id] = s
        DailyManager.shared.record(.quiz)          // 今日计划·刷题

        if !correct {
            flagged.insert(q.id)                       // 错题自动进错题本
            ReviewScheduler.shared.addIfAbsent("q:\(q.id)")  // 并加入 SM-2 复习库
            if let signal {
                let cause = DiagnosisEngine.diagnose(signal)
                signals.append(StoredSignal(module: q.module.rawValue, cause: cause.rawValue, date: Date()))
            }
        } else {
            flagged.remove(q.id)
        }
        save()
    }

    func markLevelComplete(_ levelId: String) {
        completedLevels.insert(levelId)
        save()
    }

    func toggleFlag(_ id: String) {
        if flagged.contains(id) { flagged.remove(id) } else { flagged.insert(id) }
        save()
    }

    func togglePointMastered(_ id: String) {
        if masteredPoints.contains(id) {
            masteredPoints.remove(id)
        } else {
            masteredPoints.insert(id)
            DailyManager.shared.record(.sniper)     // 今日计划·狙击
        }
        save()
    }
    func isPointMastered(_ id: String) -> Bool { masteredPoints.contains(id) }

    func resetAll() {
        stats = [:]; signals = []; completedLevels = []; flagged = []; masteredPoints = []
        save()
    }

    // MARK: - 高频狙击

    /// 某高频考点的掌握度：手动标记已掌握→1.0；否则按关联题正确率推断；无数据则给低基线。
    func pointMastery(_ p: HighFreqPoint) -> Double {
        if masteredPoints.contains(p.id) { return 1.0 }
        let answered = p.linkedQuestionIds.compactMap { id -> QStat? in
            let s = stat(for: id); return s.attempts > 0 ? s : nil
        }
        guard !answered.isEmpty else { return 0.2 }   // 没做过→视为低掌握，高频点优先冒头
        var sum = 0.0
        for s in answered {
            sum += Double(s.correct) / Double(s.attempts)
        }
        return sum / Double(answered.count)
    }

    var sniperHits: [SniperHit] {
        HighFreqEngine.hitList(HighFreqData.all, mastery: pointMastery)
    }
    func sniperToday(limit: Int = 5) -> [SniperHit] {
        HighFreqEngine.today(HighFreqData.all, mastery: pointMastery, limit: limit)
    }

    // MARK: - 喂引擎（派生数据）

    /// 各模块做题表现 → 估分器输入。
    var performances: [ModulePerformance] {
        ExamModule.allCases.compactMap { module in
            let qs = QuestionBank.all.filter { $0.module == module }
            let answered = qs.compactMap { q -> (Question, QStat)? in
                guard let s = stats[q.id], s.attempts > 0 else { return nil }
                return (q, s)
            }
            guard !answered.isEmpty else { return nil }
            let attempts = answered.reduce(0) { $0 + $1.1.attempts }
            // 按难度加权的正确率
            let wSum = answered.reduce(0.0) { $0 + $1.0.difficulty }
            let accW = answered.reduce(0.0) { acc, pair in
                let (q, s) = pair
                let rate = Double(s.correct) / Double(s.attempts)
                return acc + rate * q.difficulty
            }
            let weightedAcc = wSum > 0 ? accW / wSum : 0
            return ModulePerformance(module: module, attempts: attempts, weightedAccuracy: weightedAcc)
        }
    }

    var estimates: [ModuleEstimate] { EstimatorEngine.estimate(performances) }

    var totalEstimate: (score: Double, low: Double, high: Double) {
        EstimatorEngine.total(estimates)
    }

    /// 近期错误率（按模块作答总数归一）→ 提分雷达输入。
    var recentErrorRate: [ExamModule: Double] {
        var totalByModule: [ExamModule: Int] = [:]
        for (id, s) in stats {
            guard let q = QuestionBank.find(id) else { continue }
            totalByModule[q.module, default: 0] += s.attempts
        }
        // 把存储的信号还原为 ErrorSignal 的模块统计
        var errByModule: [ExamModule: Int] = [:]
        for sig in signals {
            if let m = ExamModule(rawValue: sig.module) { errByModule[m, default: 0] += 1 }
        }
        var rate: [ExamModule: Double] = [:]
        for (m, t) in totalByModule where t > 0 {
            rate[m] = min(1, Double(errByModule[m] ?? 0) / Double(t))
        }
        return rate
    }

    var radar: [GainOpportunity] {
        GainRadar.opportunities(from: estimates, recentErrorRate: recentErrorRate)
    }

    func topPath(limit: Int = 3) -> [GainOpportunity] {
        GainRadar.topPath(from: estimates, recentErrorRate: recentErrorRate, limit: limit)
    }

    /// 错因分布（诊断页）。
    var causeDistribution: [ErrorCause: Int] {
        var dist: [ErrorCause: Int] = [:]
        for sig in signals {
            if let c = ErrorCause(rawValue: sig.cause) { dist[c, default: 0] += 1 }
        }
        return dist
    }

    var flaggedQuestions: [Question] {
        flagged.compactMap { QuestionBank.find($0) }.sorted { $0.id < $1.id }
    }

    func stat(for id: String) -> QStat { stats[id] ?? QStat() }

    // MARK: - 持久化

    private struct Blob: Codable {
        var stats: [String: QStat]
        var signals: [StoredSignal]
        var completedLevels: [String]
        var flagged: [String]
        var masteredPoints: [String]?
    }

    private func save() {
        let blob = Blob(stats: stats, signals: signals,
                        completedLevels: Array(completedLevels), flagged: Array(flagged),
                        masteredPoints: Array(masteredPoints))
        if let data = try? JSONEncoder().encode(blob) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let blob = try? JSONDecoder().decode(Blob.self, from: data) else { return }
        stats = blob.stats
        signals = blob.signals
        completedLevels = Set(blob.completedLevels)
        flagged = Set(blob.flagged)
        masteredPoints = Set(blob.masteredPoints ?? [])
    }
}
