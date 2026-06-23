import Foundation

/// 单模块的做题表现输入：做了多少题、按难度加权后的正确率。
struct ModulePerformance {
    let module: ExamModule
    let attempts: Int          // 累计作答题数（含历史）
    let weightedAccuracy: Double  // 0...1，按题目难度加权后的正确率

    init(module: ExamModule, attempts: Int, weightedAccuracy: Double) {
        self.module = module
        self.attempts = attempts
        self.weightedAccuracy = min(max(weightedAccuracy, 0), 1)
    }
}

/// 单模块估分结果。
struct ModuleEstimate: Identifiable {
    let module: ExamModule
    let estimatedScore: Double   // 估计得分
    let fullScore: Double
    let confidence: Double       // 0...1，样本越多越高

    var id: String { module.id }
    var gap: Double { fullScore - estimatedScore }          // 失分空间
    var scoreRatio: Double { fullScore > 0 ? estimatedScore / fullScore : 0 }
}

/// 估分器：把做题数据折算成"高考英语估分 + 置信区间"。
/// 纯函数式、可单元测试，不依赖任何 UI 或持久化。
enum EstimatorEngine {

    /// 没有任何作答记录时，对一个模块的先验得分比例（保守中位）。
    private static let priorRatio = 0.5
    /// 置信度增长速率：作答约 `confidenceK` 题后置信度达 ~0.63。
    private static let confidenceK = 12.0

    static func estimate(_ performances: [ModulePerformance]) -> [ModuleEstimate] {
        let byModule = Dictionary(performances.map { ($0.module, $0) }) { a, _ in a }
        return ExamModule.allCases.map { module in
            let perf = byModule[module]
            let confidence = perf.map { Self.confidence(forAttempts: $0.attempts) } ?? 0
            // 置信度低时向先验收缩，避免一两题就给极端估分。
            let ratio: Double = {
                guard let perf else { return priorRatio }
                return perf.weightedAccuracy * confidence + priorRatio * (1 - confidence)
            }()
            return ModuleEstimate(
                module: module,
                estimatedScore: (ratio * module.fullScore * 10).rounded() / 10,
                fullScore: module.fullScore,
                confidence: confidence
            )
        }
    }

    /// 总分估计：返回点估计与置信区间（区间宽度随整体置信度收窄）。
    static func total(_ estimates: [ModuleEstimate]) -> (score: Double, low: Double, high: Double) {
        let score = estimates.reduce(0) { $0 + $1.estimatedScore }
        // 置信度按满分加权平均；越不确定，区间越宽（最宽 ±18 分）。
        let weightedConf = estimates.reduce(0.0) { $0 + $1.confidence * $1.fullScore } / ExamModule.totalFullScore
        let halfWidth = 18.0 * (1 - weightedConf)
        let s = (score * 10).rounded() / 10
        return (s, max(0, (s - halfWidth).rounded()), min(150, (s + halfWidth).rounded()))
    }

    static func confidence(forAttempts attempts: Int) -> Double {
        guard attempts > 0 else { return 0 }
        return 1 - exp(-Double(attempts) / confidenceK)
    }
}
