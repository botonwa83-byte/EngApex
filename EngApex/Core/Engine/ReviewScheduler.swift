import Foundation

/// 一张复习卡的 SM-2 状态。
struct ReviewCard: Codable {
    var ease: Double = 2.5      // 难度因子 EF，最低 1.3
    var interval: Int = 0       // 当前间隔（天）
    var reps: Int = 0           // 连续答对次数
    var due: Date = Date()      // 下次到期
}

/// 复习项的来源：错题 / 句式卡 / 词汇卡。id 形如 "q:g1" / "p:p3" / "v:v_address"。
enum ReviewRef {
    case question(Question)
    case phrase(PhraseCard)
    case vocab(VocabWord)

    static func resolve(_ id: String) -> ReviewRef? {
        guard let sep = id.firstIndex(of: ":") else { return nil }
        let kind = id[..<sep], key = String(id[id.index(after: sep)...])
        switch kind {
        case "q": return QuestionBank.find(key).map(ReviewRef.question)
        case "p": return PhraseBook.all.first { $0.id == key }.map(ReviewRef.phrase)
        case "v": return VocabData.find(key).map(ReviewRef.vocab)
        default:  return nil
        }
    }
}

/// SM-2 间隔重复复习引擎。错题自动入库，句式可手动加入。离线持久化。
final class ReviewScheduler: ObservableObject {
    static let shared = ReviewScheduler()

    @Published private(set) var cards: [String: ReviewCard] = [:]
    private let key = "reviewscheduler.v1"

    private init() { load() }

    func addIfAbsent(_ id: String) {
        guard cards[id] == nil else { return }
        cards[id] = ReviewCard()
        save()
    }

    func contains(_ id: String) -> Bool { cards[id] != nil }

    /// 到期的卡片 id（按到期时间升序）。
    func dueIDs(asOf now: Date = Date()) -> [String] {
        cards.filter { $0.value.due <= now }
            .sorted { $0.value.due < $1.value.due }
            .map(\.key)
    }

    var dueCount: Int { dueIDs().count }

    /// SM-2 评分：quality 0...5（<3 视为没记住，重置）。
    func grade(_ id: String, quality: Int, now: Date = Date()) {
        guard var card = cards[id] else { return }
        let q = max(0, min(5, quality))
        if q < 3 {
            card.reps = 0
            card.interval = 1
        } else {
            switch card.reps {
            case 0: card.interval = 1
            case 1: card.interval = 6
            default: card.interval = Int((Double(card.interval) * card.ease).rounded())
            }
            card.reps += 1
        }
        // 更新 EF
        let delta = 0.1 - Double(5 - q) * (0.08 + Double(5 - q) * 0.02)
        card.ease = max(1.3, card.ease + delta)
        card.due = Calendar.current.date(byAdding: .day, value: max(1, card.interval), to: now) ?? now
        cards[id] = card
        DailyManager.shared.record(.review)         // 今日计划·复习
        save()
    }

    func reset() { cards = [:]; save() }

    // MARK: 持久化

    private func save() {
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([String: ReviewCard].self, from: data) else { return }
        cards = decoded
    }
}
