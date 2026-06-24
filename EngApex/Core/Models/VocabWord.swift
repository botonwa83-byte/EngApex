import Foundation

/// 词汇专项的练法分类：搭配辨析(易混词对) / 熟词僻义。
enum VocabCategory: String, Codable, CaseIterable, Identifiable {
    case collocation
    case polysemy

    var id: String { rawValue }
    var title: String { self == .collocation ? "搭配辨析" : "熟词僻义" }
}

/// 一个词汇专项词条：拼写 + 搭配/僻义小测，三种练法共用同一份数据。
/// tier 1 = 高考核心高频，tier 2 = 拓展高频——决定狙击算法里的频度权重。
struct VocabWord: Identifiable {
    let id: String
    let headword: String
    let meaning: String          // 中文释义(含词性)
    let tier: Int
    let category: VocabCategory
    let example: String
    let exampleMeaning: String
    let collocations: [String]   // 常见搭配，搭配辨析词为主
    let quizStem: String         // 搭配/僻义小测的题干(句中含该词)
    let quizOptions: [String]
    let quizAnswer: Int
    let quizExplanation: String

    /// 频度权重：供 HighFreqEngine.sniperScore 复用，统一狙击算法口径。
    var frequencyWeight: Double { tier == 1 ? 0.9 : 0.7 }
}
