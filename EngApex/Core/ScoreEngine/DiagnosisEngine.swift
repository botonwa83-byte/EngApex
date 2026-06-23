import Foundation

/// 一道错题的根因（四类）。
enum ErrorCause: String, CaseIterable, Codable {
    case vocabGap       // 词汇盲区
    case grammarHole    // 语法漏洞
    case strategyMiss   // 题型策略错
    case carelessness   // 粗心审题

    var title: String {
        switch self {
        case .vocabGap:     return "词汇盲区"
        case .grammarHole:  return "语法漏洞"
        case .strategyMiss: return "题型策略错"
        case .carelessness: return "粗心审题"
        }
    }

    var advice: String {
        switch self {
        case .vocabGap:     return "把这个词/词块加入复习卡，明天遗忘曲线再考你一遍。"
        case .grammarHole:  return "回到对应语法点决策树，重走一遍判断步骤。"
        case .strategyMiss: return "你词法都懂，丢在套路上——重看该题型的解题决策树。"
        case .carelessness: return "答案其实会做，放慢审题、圈出题干关键词再下笔。"
        }
    }

    var icon: String {
        switch self {
        case .vocabGap:     return "character.book.closed"
        case .grammarHole:  return "textformat.size"
        case .strategyMiss: return "arrow.triangle.branch"
        case .carelessness: return "exclamationmark.bubble"
        }
    }
}

/// 学生做完一道错题后的自评信号（极少几个布尔，降低自评负担）。
struct ErrorSignal {
    let module: ExamModule
    let vocabKnown: Bool      // 关键词都认识吗
    let grammarKnown: Bool    // 涉及的语法点懂吗
    let strategyKnown: Bool   // 该题型解法套路清楚吗
    let rushed: Bool          // 是不是赶时间/没看清

    init(module: ExamModule, vocabKnown: Bool, grammarKnown: Bool,
         strategyKnown: Bool, rushed: Bool) {
        self.module = module
        self.vocabKnown = vocabKnown
        self.grammarKnown = grammarKnown
        self.strategyKnown = strategyKnown
        self.rushed = rushed
    }
}

/// 错因诊断树：沿决策树把一道错题归到唯一根因，结果回喂雷达与复习。
enum DiagnosisEngine {

    /// 决策树（顺序即优先级）：词法 → 语法 → 策略 → 粗心。
    /// 先排除最底层的知识缺口，再归因到更高层的策略/状态问题。
    static func diagnose(_ s: ErrorSignal) -> ErrorCause {
        if !s.vocabKnown { return .vocabGap }
        if !s.grammarKnown { return .grammarHole }
        if !s.strategyKnown { return .strategyMiss }
        if s.rushed { return .carelessness }
        // 词法语法套路都说懂、又不赶时间却仍错——多半是套路没真正吃透。
        return .strategyMiss
    }

    /// 汇总一批信号，得到各模块"近期错误率"——直接喂给提分雷达的可提升概率。
    static func recentErrorRate(from signals: [ErrorSignal], total: [ExamModule: Int]) -> [ExamModule: Double] {
        var errs: [ExamModule: Int] = [:]
        for s in signals { errs[s.module, default: 0] += 1 }
        var rate: [ExamModule: Double] = [:]
        for (module, t) in total where t > 0 {
            rate[module] = min(1, Double(errs[module] ?? 0) / Double(t))
        }
        return rate
    }

    /// 根因分布（错题本/诊断页用）。
    static func distribution(_ signals: [ErrorSignal]) -> [ErrorCause: Int] {
        var dist: [ErrorCause: Int] = [:]
        for s in signals { dist[diagnose(s), default: 0] += 1 }
        return dist
    }
}
