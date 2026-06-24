import Foundation

/// 单词的拼写/搭配·僻义小测统计。
struct VocabStat: Codable {
    var spellingAttempts = 0
    var spellingCorrect = 0
    var quizAttempts = 0
    var quizCorrect = 0
}

/// 词汇专项的状态中枢：拼写/搭配/僻义三种练法共用同一份掌握度，复用 HighFreqEngine 的狙击公式排序。
final class VocabStore: ObservableObject {
    static let shared = VocabStore()

    @Published private(set) var stats: [String: VocabStat] = [:]
    @Published private(set) var mastered: Set<String> = []

    private let key = "vocabstore.v1"

    private init() { load() }

    func recordSpelling(_ word: VocabWord, correct: Bool) {
        var s = stats[word.id] ?? VocabStat()
        s.spellingAttempts += 1
        if correct { s.spellingCorrect += 1 }
        stats[word.id] = s
        save()
    }

    func recordQuiz(_ word: VocabWord, correct: Bool) {
        var s = stats[word.id] ?? VocabStat()
        s.quizAttempts += 1
        if correct { s.quizCorrect += 1 }
        stats[word.id] = s
        save()
    }

    func toggleMastered(_ id: String) {
        if mastered.contains(id) { mastered.remove(id) } else { mastered.insert(id) }
        save()
    }
    func isMastered(_ id: String) -> Bool { mastered.contains(id) }

    func stat(for id: String) -> VocabStat { stats[id] ?? VocabStat() }

    /// 掌握度：手动标记已掌握→1.0；否则按拼写/小测正确率的均值推断；无数据则给低基线(高频词优先冒头)。
    func mastery(_ word: VocabWord) -> Double {
        if mastered.contains(word.id) { return 1.0 }
        let s = stats[word.id] ?? VocabStat()
        var rates: [Double] = []
        if s.spellingAttempts > 0 { rates.append(Double(s.spellingCorrect) / Double(s.spellingAttempts)) }
        if s.quizAttempts > 0 { rates.append(Double(s.quizCorrect) / Double(s.quizAttempts)) }
        guard !rates.isEmpty else { return 0.2 }
        return rates.reduce(0, +) / Double(rates.count)
    }

    /// 按狙击优先级降序：高频权重 × (1 − 掌握度)，与高频狙击同一公式，统一算法口径。
    func priorityList(_ words: [VocabWord]) -> [(word: VocabWord, score: Double)] {
        words.map { w in (w, HighFreqEngine.sniperScore(frequency: w.frequencyWeight, mastery: mastery(w))) }
            .sorted { $0.1 > $1.1 }
    }

    func resetAll() {
        stats = [:]; mastered = []
        save()
    }

    // MARK: 持久化

    private struct Blob: Codable { var stats: [String: VocabStat]; var mastered: [String] }

    private func save() {
        if let data = try? JSONEncoder().encode(Blob(stats: stats, mastered: Array(mastered))) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let blob = try? JSONDecoder().decode(Blob.self, from: data) else { return }
        stats = blob.stats
        mastered = Set(blob.mastered)
    }
}
