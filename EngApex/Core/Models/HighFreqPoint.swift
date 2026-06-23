import Foundation

/// 一个高频考点：高频狙击算法的最小作战单元。
/// frequencyWeight 基于考纲高频统计（不臆造具体某年某卷出处，守诚信红线）。
struct HighFreqPoint: Identifiable {
    let id: String
    let module: ExamModule
    let name: String                 // 考点名
    let frequencyWeight: Double       // 0...1，高频程度
    let digest: String                // 一句话精讲 / 口诀
    let example: String               // 例证
    let linkedLevelId: String?        // 去靶场强化对应关卡
    let linkedQuestionIds: [String]   // 据其正确率推断掌握度
}
