import Foundation

/// 应用文情境：体裁 + 写作要求 + 结构骨架 + 范文 + 自评 rubric。
/// 和读后续写工坊同一套设计：不做假 AI 批改，提供高分范文与自评清单，由学生对照打磨（守诚信红线）。
struct AppliedWritingPrompt: Identifiable {
    let id: String
    let genre: String          // 体裁，如"求助信"/"通知"
    let title: String          // 具体场景标题
    let scenario: String       // 情境说明 + 写作要求（中文）
    let stages: [WritingStage] // 结构骨架
    let modelEssay: String     // 高分范文
    let rubric: [String]       // 自评要点
    let isFree: Bool           // 每个体裁的第 1 个场景免费预览，第 2 个场景付费解锁
}

/// 应用文骨架的一个段落（开头/正文/结尾，或通知类的标题/要点/结尾）。
struct WritingStage: Identifiable {
    let name: String
    let guidance: String
    let phraseIds: [String]    // 关联句式库（PhraseBook id）

    var id: String { name }
    var phrases: [PhraseCard] { phraseIds.compactMap { id in PhraseBook.all.first { $0.id == id } } }
}
