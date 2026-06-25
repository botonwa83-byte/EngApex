import Foundation

/// 一次模考的判分结果。
struct MockResult {
    let perModule: [ExamModule: (correct: Int, total: Int)]
    /// 按考点标签(Question.pointTag)细分的正确率——大卷(完整模考)样本量足够时才有统计意义，是付费完整模考的差异化报告。
    let perPointTag: [String: (correct: Int, total: Int)]
    let answeredCount: Int
    let totalCount: Int

    /// 折合高考分：每个模块按正确率 × 满分求和（组卷已覆盖全部 7 模块）。
    var scaledScore: Double {
        var s = 0.0
        for m in ExamModule.allCases {
            guard let r = perModule[m], r.total > 0 else { continue }
            s += Double(r.correct) / Double(r.total) * m.fullScore
        }
        return (s * 10).rounded() / 10
    }

    var totalCorrect: Int { perModule.values.reduce(0) { $0 + $1.correct } }

    /// 本卷覆盖模块的满分合计：按实际抽中的模块如实相加（如某次组卷未抽中听力，则不计入听力满分）。
    var coveredFullScore: Double {
        var s = 0.0
        for m in ExamModule.allCases where (perModule[m]?.total ?? 0) > 0 {
            s += m.fullScore
        }
        return s
    }

    /// 是否含听力（决定满分是 150 还是 120）。
    var includesListening: Bool { (perModule[.listening]?.total ?? 0) > 0 }

    /// 正确率最低的模块（薄弱点）。
    var weakestModule: ExamModule? {
        var weakest: ExamModule?
        var worst = Double.infinity
        for (m, r) in perModule where r.total > 0 {
            let acc = Double(r.correct) / Double(r.total)
            if acc < worst { worst = acc; weakest = m }
        }
        return weakest
    }

    /// 答错≥1 次、且作答样本数≥2(避免单题误差被当成"薄弱点")的考点，按正确率升序——完整模考专属的考点级薄弱报告。
    var weakestPointTags: [(tag: String, accuracy: Double, total: Int)] {
        perPointTag.compactMap { tag, r in
            guard r.total >= 2 else { return nil }
            return (tag, Double(r.correct) / Double(r.total), r.total)
        }
        .filter { $0.accuracy < 1.0 }
        .sorted { $0.accuracy < $1.accuracy }
    }
}

/// 模考引擎：组卷 + 判分，纯函数可测。
enum MockEngine {

    /// 组卷：先保证每个模块至少 1 题，再按高考权重(examWeight)比例分配剩余名额，避免大份卷子被单一高权重模块(如阅读)占满。
    static func assemble(count: Int, from bank: [Question]) -> [Question] {
        let byModule = Dictionary(grouping: bank) { $0.module }
        var picked: [Question] = []
        var used = Set<String>()

        // 1. 每模块保底 1 题
        for m in ExamModule.allCases {
            if let q = byModule[m]?.shuffled().first {
                picked.append(q); used.insert(q.id)
            }
        }

        // 2. 按权重比例(最大余数法)分配剩余名额，题库不够的模块把名额让给其他模块
        let remaining = max(0, count - picked.count)
        if remaining > 0 {
            var quotas = proportionalQuotas(remaining: remaining, modules: ExamModule.allCases)
            for m in ExamModule.allCases {
                let available = (byModule[m] ?? []).filter { !used.contains($0.id) }.shuffled()
                let take = min(quotas[m] ?? 0, available.count)
                for q in available.prefix(take) { picked.append(q); used.insert(q.id) }
            }
            let shortfall = count - picked.count
            if shortfall > 0 {
                let leftover = bank.filter { !used.contains($0.id) }.shuffled()
                    .sorted { $0.module.examWeight > $1.module.examWeight }
                for q in leftover.prefix(shortfall) { picked.append(q); used.insert(q.id) }
            }
        }

        // 3. 按真实考场卷面顺序排列，体验更像真实试卷
        return picked.sorted { $0.module.examOrderIndex < $1.module.examOrderIndex }
    }

    /// 完整模考固定的全真模拟卷套数(套卷一~五轮转分割 + 套卷六固定打包)。
    static let paperCount = 6
    /// 套卷一(下标 0)免费开放试用，其余套卷需解锁完整模考。
    static let freePaperIndex = 0

    /// 套卷一~五：固定、互不重复、合起来正好覆盖"套卷六题目之外"的题库全部题目——均为本 app 自研题目，
    /// 仿真高考真题的题型/难度/考点分布，但不是真实历年高考原题(不臆造具体出处，守诚信红线)。
    /// 每模块的题先按 id 排序保证可复现，再轮转均分进 5 套，使每套结构相近、且重新进入同一套时题目不变。
    /// 套卷六：单独成套，不参与轮转，即 QuestionBank.paper6 本身(见该常量定义)。
    static func fixedPapers(from bank: [Question]) -> [[Question]] {
        let paper6Ids = Set(QuestionBank.paper6.map(\.id))
        let rotatingBank = bank.filter { !paper6Ids.contains($0.id) }
        let rotatingCount = paperCount - 1

        var papers: [[Question]] = Array(repeating: [], count: rotatingCount)
        let byModule = Dictionary(grouping: rotatingBank) { $0.module }
        for module in ExamModule.allCases {
            let pool = (byModule[module] ?? []).sorted { $0.id < $1.id }
            for (i, q) in pool.enumerated() {
                papers[i % rotatingCount].append(q)
            }
        }
        var result = papers.map { $0.sorted { $0.module.examOrderIndex < $1.module.examOrderIndex } }
        result.append(QuestionBank.paper6)
        return result
    }

    /// 把 remaining 个名额按 examWeight 比例分给各模块，最大余数法保证总数精确等于 remaining。
    private static func proportionalQuotas(remaining: Int, modules: [ExamModule]) -> [ExamModule: Int] {
        let totalWeight = modules.reduce(0.0) { $0 + $1.examWeight }
        guard totalWeight > 0 else { return [:] }
        var raw: [ExamModule: Double] = [:]
        for m in modules { raw[m] = Double(remaining) * (m.examWeight / totalWeight) }
        var quotas: [ExamModule: Int] = [:]
        var assigned = 0
        for m in modules {
            let q = Int(raw[m] ?? 0)
            quotas[m] = q
            assigned += q
        }
        let shortfall = remaining - assigned
        if shortfall > 0 {
            let byFraction = modules.sorted { ((raw[$0] ?? 0) - Double(quotas[$0] ?? 0)) > ((raw[$1] ?? 0) - Double(quotas[$1] ?? 0)) }
            for m in byFraction.prefix(shortfall) { quotas[m, default: 0] += 1 }
        }
        return quotas
    }

    /// 判分：answers 为 questionId → 所选下标（未作答的题不计入 correct，但计入 total）。
    static func score(questions: [Question], answers: [String: Int]) -> MockResult {
        var per: [ExamModule: (correct: Int, total: Int)] = [:]
        var perTag: [String: (correct: Int, total: Int)] = [:]
        var answered = 0
        for q in questions {
            var entry = per[q.module] ?? (0, 0)
            var tagEntry = perTag[q.pointTag] ?? (0, 0)
            entry.total += 1
            tagEntry.total += 1
            if let a = answers[q.id] {
                answered += 1
                if a == q.answer { entry.correct += 1; tagEntry.correct += 1 }
            }
            per[q.module] = entry
            perTag[q.pointTag] = tagEntry
        }
        return MockResult(perModule: per, perPointTag: perTag, answeredCount: answered, totalCount: questions.count)
    }
}

/// 模考成绩持久化：全局聚合(上次 / 最佳 / 次数，供驾驶舱等概览用) + 快速模考单独统计 +
/// 完整模考 6 套全真模拟卷各自的独立统计(下标 0...5 对应套卷一...六，可分别追踪、反复重考)。
final class MockManager: ObservableObject {
    static let shared = MockManager()

    struct Stats: Codable { var last: Double = 0; var best: Double = 0; var count: Int = 0 }

    @Published private(set) var lastScore: Double = 0
    @Published private(set) var bestScore: Double = 0
    @Published private(set) var count: Int = 0
    @Published private(set) var quick: Stats = Stats()
    @Published private(set) var papers: [Stats] = Array(repeating: Stats(), count: MockEngine.paperCount)

    private let key = "mockmanager.v2"

    private init() { load() }

    func recordQuickResult(_ score: Double) {
        quick.last = score; quick.best = max(quick.best, score); quick.count += 1
        recordGlobal(score)
        save()
    }

    func recordPaperResult(_ paperIndex: Int, _ score: Double) {
        guard papers.indices.contains(paperIndex) else { return }
        papers[paperIndex].last = score
        papers[paperIndex].best = max(papers[paperIndex].best, score)
        papers[paperIndex].count += 1
        recordGlobal(score)
        save()
    }

    private func recordGlobal(_ score: Double) {
        lastScore = score
        bestScore = max(bestScore, score)
        count += 1
    }

    private struct Blob: Codable { var last: Double; var best: Double; var count: Int; var quick: Stats; var papers: [Stats] }
    private func save() {
        let blob = Blob(last: lastScore, best: bestScore, count: count, quick: quick, papers: papers)
        if let d = try? JSONEncoder().encode(blob) {
            UserDefaults.standard.set(d, forKey: key)
        }
    }
    private func load() {
        guard let d = UserDefaults.standard.data(forKey: key),
              let b = try? JSONDecoder().decode(Blob.self, from: d) else { return }
        lastScore = b.last; bestScore = b.best; count = b.count
        quick = b.quick
        papers = b.papers.count == MockEngine.paperCount ? b.papers : Array(repeating: Stats(), count: MockEngine.paperCount)
    }
}
