import Foundation

/// 提分雷达的一条建议：某模块的边际提分 ROI 与给用户看的理由。
struct GainOpportunity: Identifiable {
    let module: ExamModule
    let roi: Double              // 归一化前的原始 ROI
    let normalizedROI: Double    // 0...1，全模块内相对排名用
    let expectedGain: Double     // 该模块若补到位、可期望拿回的分数
    let reason: String           // 人话理由

    var id: String { module.id }
}

/// 提分雷达：EngApex 的最大创新点。
/// 对每个模块计算"边际提分 ROI"，把用户永远导向性价比最高的那 +5 分。
///
///   ROI = (失分空间 × 可提升概率 × 高考权重) ÷ 投入时间
///   - 失分空间   = 满分 − 估分
///   - 可提升概率 = 近期错误率 × 可学性系数
///   - 高考权重   = 模块满分 / 150
///   - 投入时间   = 模块 effortWeight
enum GainRadar {

    /// `recentErrorRate` 可选：来自错因诊断的"近期错误率"，缺省时用 (1 − 估分比例) 近似。
    static func opportunities(
        from estimates: [ModuleEstimate],
        recentErrorRate: [ExamModule: Double] = [:]
    ) -> [GainOpportunity] {

        let raw: [(ExamModule, Double, Double)] = estimates.map { est in
            let module = est.module
            let gap = est.gap
            let errorRate = recentErrorRate[module] ?? (1 - est.scoreRatio)
            let improvable = errorRate * module.learnability        // 可提升概率
            let roi = gap * improvable * module.examWeight / module.effortWeight
            // 期望提分：失分空间里"可提升概率"能拿回的部分。
            let expectedGain = (gap * improvable * 10).rounded() / 10
            return (module, roi, expectedGain)
        }

        let maxROI = raw.map { $0.1 }.max() ?? 1
        return raw
            .map { module, roi, gain in
                GainOpportunity(
                    module: module,
                    roi: roi,
                    normalizedROI: maxROI > 0 ? roi / maxROI : 0,
                    expectedGain: gain,
                    reason: reason(module: module, roi: roi, gain: gain)
                )
            }
            .sorted { $0.roi > $1.roi }
    }

    /// 今日最优路径：ROI 最高的前 n 个模块。
    static func topPath(
        from estimates: [ModuleEstimate],
        recentErrorRate: [ExamModule: Double] = [:],
        limit: Int = 3
    ) -> [GainOpportunity] {
        Array(opportunities(from: estimates, recentErrorRate: recentErrorRate).prefix(limit))
    }

    private static func reason(module: ExamModule, roi: Double, gain: Double) -> String {
        if gain < 0.5 {
            return "\(module.title)已接近上限，先稳住，把时间投到别处更划算。"
        }
        if module.learnability >= 0.8 {
            return "\(module.title)规则性强、见效快，预计可拿回约 \(fmt(gain)) 分——优先打。"
        }
        return "\(module.title)还有约 \(fmt(gain)) 分空间，按当前性价比排在这里。"
    }

    private static func fmt(_ v: Double) -> String {
        v == v.rounded() ? String(Int(v)) : String(format: "%.1f", v)
    }
}
