import Foundation

/// 新高考英语 150 分的得分结构模型。
/// 这是三个算法引擎共享的"地图"——估分器在此结构上估分，提分雷达在此结构上算 ROI。
enum ExamModule: String, CaseIterable, Identifiable, Codable {
    case listening        // 听力
    case reading          // 阅读理解（四篇）
    case sevenChoose      // 七选五
    case cloze            // 完形填空
    case grammarFill      // 语法填空
    case appliedWriting   // 应用文写作
    case continuation     // 读后续写

    var id: String { rawValue }

    var title: String {
        switch self {
        case .listening:      return "听力"
        case .reading:        return "阅读理解"
        case .sevenChoose:    return "七选五"
        case .cloze:          return "完形填空"
        case .grammarFill:    return "语法填空"
        case .appliedWriting: return "应用文写作"
        case .continuation:   return "读后续写"
        }
    }

    /// 高考满分值。总和 = 150。
    var fullScore: Double {
        switch self {
        case .listening:      return 30
        case .reading:        return 37.5
        case .sevenChoose:    return 12.5
        case .cloze:          return 15
        case .grammarFill:    return 15
        case .appliedWriting: return 15
        case .continuation:   return 25
        }
    }

    /// 可学性系数 0...1：规则越强、套路越固定，短期越容易提分（→ 提分雷达的关键因子）。
    /// 语法填空/应用文规则性最强；读后续写/听力更吃长期积累。
    var learnability: Double {
        switch self {
        case .grammarFill:    return 0.90
        case .appliedWriting: return 0.85
        case .sevenChoose:    return 0.80
        case .cloze:          return 0.70
        case .reading:        return 0.60
        case .listening:      return 0.60
        case .continuation:   return 0.55
        }
    }

    /// 提分雷达里的"相对投入时间"权重：拿下该模块一个台阶大致要花多少功夫（小=快）。
    var effortWeight: Double {
        switch self {
        case .grammarFill:    return 1.0
        case .sevenChoose:    return 1.1
        case .appliedWriting: return 1.2
        case .cloze:          return 1.4
        case .listening:      return 1.6
        case .reading:        return 1.8
        case .continuation:   return 2.2
        }
    }

    /// 高考权重 = 该模块满分占总分比例。
    var examWeight: Double { fullScore / ExamModule.totalFullScore }

    static var totalFullScore: Double {
        allCases.reduce(0) { $0 + $1.fullScore }   // 150
    }

    /// SF Symbol 图标（驾驶舱/靶场列表用）。
    var icon: String {
        switch self {
        case .listening:      return "ear"
        case .reading:        return "book"
        case .sevenChoose:    return "list.bullet.indent"
        case .cloze:          return "text.word.spacing"
        case .grammarFill:    return "textformat.abc"
        case .appliedWriting: return "envelope"
        case .continuation:   return "pencil.and.scribble"
        }
    }
}
