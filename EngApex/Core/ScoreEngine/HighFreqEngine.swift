import Foundation

/// 一条狙击结果：高频考点 + 你的掌握度 + 狙击优先级。
struct SniperHit: Identifiable {
    let point: HighFreqPoint
    let mastery: Double         // 0...1
    let sniperScore: Double     // 高频权重 × (1 − 掌握度)
    var id: String { point.id }

    /// 优先级档位（给用户看的标签）。
    var priorityLabel: String {
        switch sniperScore {
        case 0.55...: return "高"
        case 0.3..<0.55: return "中"
        default: return "低"
        }
    }
}

/// 高频狙击算法：考点级的提分导航。
///
///   狙击优先级 = 高频权重 × (1 − 掌握度)
///
/// 高频且你最弱的考点永远排最前。掌握度由外部（EngStore）提供，引擎保持纯函数可测。
enum HighFreqEngine {

    static func sniperScore(frequency: Double, mastery: Double) -> Double {
        frequency * (1 - min(max(mastery, 0), 1))
    }

    /// 全部高频考点按狙击优先级降序。
    static func hitList(_ points: [HighFreqPoint],
                        mastery: (HighFreqPoint) -> Double) -> [SniperHit] {
        points.map { p in
            let m = mastery(p)
            return SniperHit(point: p, mastery: m, sniperScore: sniperScore(frequency: p.frequencyWeight, mastery: m))
        }
        .sorted { $0.sniperScore > $1.sniperScore }
    }

    /// 今日高频清单：优先级最高的前 limit 个。
    static func today(_ points: [HighFreqPoint],
                      mastery: (HighFreqPoint) -> Double,
                      limit: Int = 5) -> [SniperHit] {
        Array(hitList(points, mastery: mastery).prefix(limit))
    }
}
