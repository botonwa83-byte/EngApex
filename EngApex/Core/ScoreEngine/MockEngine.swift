import Foundation

/// 一次模考的判分结果。
struct MockResult {
    let perModule: [ExamModule: (correct: Int, total: Int)]
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

    /// 本卷覆盖模块的满分合计（无听力内容时为 120，如实标注，不臆造听力分）。
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
}

/// 模考引擎：组卷 + 判分，纯函数可测。
enum MockEngine {

    /// 组卷：先保证每个模块至少 1 题，再按满分权重补足到 count，随机抽样。
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
        // 2. 按满分权重补足（先打乱，再按模块权重排序，高权重模块优先补）
        let remaining = max(0, count - picked.count)
        let shuffledRest: [Question] = bank.filter { !used.contains($0.id) }.shuffled()
        let pool: [Question] = shuffledRest.sorted { $0.module.fullScore > $1.module.fullScore }
        for q in pool.prefix(remaining) { picked.append(q); used.insert(q.id) }

        // 3. 按模块顺序排列，体验更像真卷
        return picked.sorted { $0.module.rawValue < $1.module.rawValue }
    }

    /// 判分：answers 为 questionId → 所选下标（未作答的题不计入 correct，但计入 total）。
    static func score(questions: [Question], answers: [String: Int]) -> MockResult {
        var per: [ExamModule: (correct: Int, total: Int)] = [:]
        var answered = 0
        for q in questions {
            var entry = per[q.module] ?? (0, 0)
            entry.total += 1
            if let a = answers[q.id] {
                answered += 1
                if a == q.answer { entry.correct += 1 }
            }
            per[q.module] = entry
        }
        return MockResult(perModule: per, answeredCount: answered, totalCount: questions.count)
    }
}

/// 模考成绩持久化（上次 / 最佳 / 次数）。
final class MockManager: ObservableObject {
    static let shared = MockManager()
    @Published private(set) var lastScore: Double = 0
    @Published private(set) var bestScore: Double = 0
    @Published private(set) var count: Int = 0
    private let key = "mockmanager.v1"

    private init() { load() }

    func recordResult(_ score: Double) {
        lastScore = score
        bestScore = max(bestScore, score)
        count += 1
        save()
    }

    private struct Blob: Codable { var last: Double; var best: Double; var count: Int }
    private func save() {
        if let d = try? JSONEncoder().encode(Blob(last: lastScore, best: bestScore, count: count)) {
            UserDefaults.standard.set(d, forKey: key)
        }
    }
    private func load() {
        guard let d = UserDefaults.standard.data(forKey: key),
              let b = try? JSONDecoder().decode(Blob.self, from: d) else { return }
        lastScore = b.last; bestScore = b.best; count = b.count
    }
}
