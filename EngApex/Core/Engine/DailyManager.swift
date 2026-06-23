import Foundation

/// 每日提分计划 + 打卡 streak + 高考倒计时。把各算法拧成一个每日习惯闭环。
/// 日期可注入，便于单测 streak 与倒计时逻辑。
final class DailyManager: ObservableObject {
    static let shared = DailyManager()

    /// 今日各动作计数。
    struct DayLog: Codable {
        var day: String
        var quizzed: Int = 0
        var reviewed: Int = 0
        var sniper: Int = 0
    }

    enum Action { case quiz, review, sniper }

    /// 今日目标阈值。
    static let quizGoal = 5

    @Published private(set) var streak: Int = 0
    @Published private(set) var lastCompletedDay: String = ""   // 最近一次"三目标全达成"的日期
    @Published private(set) var log: DayLog

    private let key = "dailymanager.v1"

    private init() {
        log = DayLog(day: Self.dayString(Date()))
        load()
        ensureToday()
    }

    // MARK: 高考倒计时

    /// 距下一次高考（6/7）的天数。
    static func daysToGaokao(from now: Date = Date(), calendar: Calendar = .current) -> Int {
        let startToday = calendar.startOfDay(for: now)
        let year = calendar.component(.year, from: now)
        func june7(_ y: Int) -> Date { calendar.date(from: DateComponents(year: y, month: 6, day: 7))! }
        var target = calendar.startOfDay(for: june7(year))
        if target < startToday { target = calendar.startOfDay(for: june7(year + 1)) }
        return calendar.dateComponents([.day], from: startToday, to: target).day ?? 0
    }
    var daysToGaokao: Int { Self.daysToGaokao() }

    // MARK: 今日三目标

    var quizDone: Bool { log.quizzed >= Self.quizGoal }
    var reviewDone: Bool { log.reviewed >= 1 || ReviewScheduler.shared.dueCount == 0 }
    var sniperDone: Bool { log.sniper >= 1 }
    var allDone: Bool { quizDone && reviewDone && sniperDone }
    var doneCount: Int { [quizDone, reviewDone, sniperDone].filter { $0 }.count }

    // MARK: 记录

    func record(_ action: Action, now: Date = Date()) {
        ensureToday(now)
        switch action {
        case .quiz:   log.quizzed += 1
        case .review: log.reviewed += 1
        case .sniper: log.sniper += 1
        }
        refreshCompletion(now)
        save()
    }

    /// 跨天则把今日计数清零（streak 不在此处断，由 nextStreak 的连续性判断决定）。
    private func ensureToday(_ now: Date = Date()) {
        let today = Self.dayString(now)
        if log.day != today {
            log = DayLog(day: today)
            save()
        }
    }

    /// 若今日三目标刚好全达成且尚未计入，则更新 streak。
    private func refreshCompletion(_ now: Date) {
        let today = Self.dayString(now)
        guard allDone, lastCompletedDay != today else { return }
        let yesterday = Self.dayString(now.addingTimeInterval(-86400))
        streak = Self.nextStreak(current: streak, lastCompletedDay: lastCompletedDay,
                                 today: today, yesterday: yesterday)
        lastCompletedDay = today
    }

    /// 纯函数：根据连续性推算新的 streak。
    static func nextStreak(current: Int, lastCompletedDay: String, today: String, yesterday: String) -> Int {
        if lastCompletedDay == today { return current }     // 今天已计入
        if lastCompletedDay == yesterday { return current + 1 }
        return 1
    }

    static func dayString(_ date: Date, calendar: Calendar = .current) -> String {
        let c = calendar.dateComponents([.year, .month, .day], from: date)
        return String(format: "%04d-%02d-%02d", c.year ?? 0, c.month ?? 0, c.day ?? 0)
    }

    func reset() {
        streak = 0; lastCompletedDay = ""; log = DayLog(day: Self.dayString(Date()))
        save()
    }

    // MARK: 持久化

    private struct Blob: Codable { var streak: Int; var lastCompletedDay: String; var log: DayLog }

    private func save() {
        if let data = try? JSONEncoder().encode(Blob(streak: streak, lastCompletedDay: lastCompletedDay, log: log)) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let blob = try? JSONDecoder().decode(Blob.self, from: data) else { return }
        streak = blob.streak
        lastCompletedDay = blob.lastCompletedDay
        log = blob.log
    }
}
