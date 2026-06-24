import SwiftUI

/// 一道题。题干 + 选项 + 答案 + 考点标签 + 解题决策树 + 陷阱。
/// 这是"吃透考点"的载体：每题都带可学习的解题步骤，而非只有答案。
struct Question: Identifiable, Codable, Equatable {
    let id: String
    let module: ExamModule
    let levelId: String
    let stem: String          // 题干（完形/语法填空用 ___ 表示空；听力题干只放设问本身）
    var listeningScript: String? = nil   // 听力原文：TTS 朗读用，非听力题为 nil（var 是为了让带默认值的字段能被合成的逐成员初始化器覆盖）
    let options: [String]
    let answer: Int           // 正确选项下标
    let pointTag: String      // 考点标签，如"逻辑词·转折"/"非谓语·现在分词"
    let strategy: [String]    // 解题决策树步骤
    let trap: String          // 高频陷阱
    let difficulty: Double    // 0...1，0.3 易 / 0.6 中 / 0.85 难

    var difficultyLabel: String {
        switch difficulty {
        case ..<0.45: return "基础"
        case ..<0.7:  return "进阶"
        default:      return "拔高"
        }
    }
    var difficultyColor: Color {
        switch difficulty {
        case ..<0.45: return .apexEmerald
        case ..<0.7:  return .apexGold
        default:      return .apexDanger
        }
    }
}

/// 主线关卡（提分之路的一个节点）= 一个得分模块 + 得分点模型讲解 + 配套题。
struct MainLevel: Identifiable {
    let id: String
    let order: Int
    let module: ExamModule
    let title: String
    let subtitle: String
    let modelNote: String      // 得分点模型 / 解题决策树讲解
    let questionIds: [String]
    let isFree: Bool
}

/// 句式 / 词块库条目（图鉴 Tab）。读后续写、应用文的高分弹药。
struct PhraseCard: Identifiable, Codable {
    let id: String
    let category: PhraseCategory
    let en: String
    let zh: String
    let usage: String          // 用法 / 适用场景
}

enum PhraseCategory: String, CaseIterable, Codable, Identifiable {
    case continuationOpener   // 读后续写·段落开头
    case advancedVerb         // 高级动词替换
    case sentencePattern      // 加分句式
    case applied              // 应用文模板句
    case polysemy             // 熟词僻义档案

    var id: String { rawValue }
    var title: String {
        switch self {
        case .continuationOpener: return "续写开头句"
        case .advancedVerb:       return "高级动词"
        case .sentencePattern:    return "加分句式"
        case .applied:            return "应用文句"
        case .polysemy:           return "熟词僻义"
        }
    }
    var color: Color {
        switch self {
        case .continuationOpener: return .apexMystery
        case .advancedVerb:       return .apexEmerald
        case .sentencePattern:    return .apexStarBlue
        case .applied:            return .apexGold
        case .polysemy:           return .apexLava
        }
    }
}
