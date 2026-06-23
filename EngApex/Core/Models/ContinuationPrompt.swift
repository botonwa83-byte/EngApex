import Foundation

/// 读后续写情境：情节链脚手架 + 范文 + 自评 rubric。
/// 不做假 AI 批改——提供高分范文与自评清单，由学生对照打磨（守诚信红线）。
struct ContinuationPrompt: Identifiable {
    let id: String
    let title: String
    let context: String        // 原文梗概/已给情境
    let para1Lead: String      // 第一段给定首句（高考给两段首句）
    let para2Lead: String      // 第二段给定首句
    let stages: [PlotStage]    // 情节链脚手架
    let modelEssay: String     // 高分范文
    let rubric: [String]       // 自评要点
}

/// 情节链的一个阶段。
struct PlotStage: Identifiable {
    let name: String           // 起因/发展/转折/高潮/结局/升华
    let guidance: String       // 该阶段写什么、怎么写
    let phraseIds: [String]    // 关联句式库（PhraseBook id）

    var id: String { name }
    var phrases: [PhraseCard] { phraseIds.compactMap { id in PhraseBook.all.first { $0.id == id } } }
}
