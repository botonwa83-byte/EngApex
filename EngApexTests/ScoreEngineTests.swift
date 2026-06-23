import XCTest
@testable import EngApex

/// EngApex 三大算法引擎的单元测试——核心资产，必须可证伪。
final class ScoreEngineTests: XCTestCase {

    // MARK: - 考试模型

    func testTotalScoreIs150() {
        XCTAssertEqual(ExamModule.totalFullScore, 150, accuracy: 0.01)
    }

    func testExamWeightsSumToOne() {
        let sum = ExamModule.allCases.reduce(0) { $0 + $1.examWeight }
        XCTAssertEqual(sum, 1, accuracy: 0.0001)
    }

    // MARK: - 估分器

    func testNoAttemptsFallsBackToPrior() {
        let est = EstimatorEngine.estimate([])
        XCTAssertEqual(est.count, ExamModule.allCases.count)
        // 无数据时每模块估到满分一半，置信度 0。
        for e in est {
            XCTAssertEqual(e.confidence, 0, accuracy: 0.0001)
            // 估分四舍五入到 0.1，非整满分(37.5/12.5)上比例会有 <0.5% 漂移。
            XCTAssertEqual(e.scoreRatio, 0.5, accuracy: 0.01)
        }
    }

    func testConfidenceGrowsWithAttempts() {
        XCTAssertEqual(EstimatorEngine.confidence(forAttempts: 0), 0, accuracy: 0.0001)
        XCTAssertLessThan(EstimatorEngine.confidence(forAttempts: 5),
                          EstimatorEngine.confidence(forAttempts: 50))
        XCTAssertGreaterThan(EstimatorEngine.confidence(forAttempts: 100), 0.99)
    }

    func testHighAccuracyManyAttemptsApproachesFullScore() {
        let perf = ModulePerformance(module: .grammarFill, attempts: 200, weightedAccuracy: 1.0)
        let est = EstimatorEngine.estimate([perf]).first { $0.module == .grammarFill }!
        XCTAssertGreaterThan(est.estimatedScore, 14.5)   // 满分 15，几乎拿满
        XCTAssertGreaterThan(est.confidence, 0.99)
    }

    func testTotalEstimateWithinBounds() {
        let perfs = ExamModule.allCases.map {
            ModulePerformance(module: $0, attempts: 30, weightedAccuracy: 0.7)
        }
        let est = EstimatorEngine.estimate(perfs)
        let total = EstimatorEngine.total(est)
        XCTAssertLessThanOrEqual(total.low, total.score)
        XCTAssertLessThanOrEqual(total.score, total.high)
        XCTAssertGreaterThanOrEqual(total.low, 0)
        XCTAssertLessThanOrEqual(total.high, 150)
    }

    // MARK: - 提分雷达

    func testRadarPrioritizesHighROIModule() {
        // 两个模块同样失分，但 grammarFill 可学性/权重更高 → ROI 应更高、排更前。
        let estimates = [
            ModuleEstimate(module: .grammarFill, estimatedScore: 7.5, fullScore: 15, confidence: 0.8),
            ModuleEstimate(module: .continuation, estimatedScore: 12.5, fullScore: 25, confidence: 0.8)
        ]
        let opps = GainRadar.opportunities(from: estimates)
        // 注意：opportunities 覆盖全部模块；这里只断言两者相对顺序。
        let gIdx = opps.firstIndex { $0.module == .grammarFill }!
        let cIdx = opps.firstIndex { $0.module == .continuation }!
        XCTAssertLessThan(gIdx, cIdx, "语法填空 ROI 应高于读后续写")
    }

    func testZeroGapYieldsZeroGain() {
        let est = ExamModule.allCases.map {
            ModuleEstimate(module: $0, estimatedScore: $0.fullScore, fullScore: $0.fullScore, confidence: 1)
        }
        let opps = GainRadar.opportunities(from: est)
        for o in opps { XCTAssertEqual(o.expectedGain, 0, accuracy: 0.0001) }
    }

    func testTopPathLimited() {
        let est = EstimatorEngine.estimate([])
        XCTAssertEqual(GainRadar.topPath(from: est, limit: 3).count, 3)
    }

    // MARK: - 错因诊断树

    func testDiagnosisPriorityOrder() {
        let m = ExamModule.cloze
        XCTAssertEqual(DiagnosisEngine.diagnose(.init(module: m, vocabKnown: false, grammarKnown: false, strategyKnown: false, rushed: true)), .vocabGap)
        XCTAssertEqual(DiagnosisEngine.diagnose(.init(module: m, vocabKnown: true, grammarKnown: false, strategyKnown: false, rushed: true)), .grammarHole)
        XCTAssertEqual(DiagnosisEngine.diagnose(.init(module: m, vocabKnown: true, grammarKnown: true, strategyKnown: false, rushed: true)), .strategyMiss)
        XCTAssertEqual(DiagnosisEngine.diagnose(.init(module: m, vocabKnown: true, grammarKnown: true, strategyKnown: true, rushed: true)), .carelessness)
        XCTAssertEqual(DiagnosisEngine.diagnose(.init(module: m, vocabKnown: true, grammarKnown: true, strategyKnown: true, rushed: false)), .strategyMiss)
    }

    // MARK: - 题库完整性

    func testQuestionBankIntegrity() {
        let all = QuestionBank.all
        XCTAssertEqual(Set(all.map(\.id)).count, all.count, "题目 ID 必须全局唯一")
        for q in all {
            XCTAssertTrue(q.options.indices.contains(q.answer), "题 \(q.id) 答案下标越界")
            XCTAssertGreaterThanOrEqual(q.options.count, 2, "题 \(q.id) 选项过少")
            XCTAssertFalse(q.strategy.isEmpty, "题 \(q.id) 缺解题决策树")
            XCTAssertFalse(q.stem.isEmpty)
        }
    }

    func testEveryLevelHasQuestions() {
        for level in MainLineData.levels {
            let qs = QuestionBank.byLevel(level.id)
            XCTAssertGreaterThanOrEqual(qs.count, 3, "关卡 \(level.id) 题量不足")
            XCTAssertTrue(qs.allSatisfy { $0.module == level.module }, "关卡 \(level.id) 含错配模块的题")
        }
    }

    // MARK: - SM-2 复习调度

    func testSM2IntervalsGrow() {
        let s = ReviewScheduler.shared
        s.reset()
        s.addIfAbsent("q:g1")
        XCTAssertEqual(s.dueCount, 1)               // 新卡立即到期
        let now = Date()
        s.grade("q:g1", quality: 5, now: now)       // 第一次答对→间隔 1 天
        XCTAssertEqual(s.dueCount, 0)               // 已排到未来
        s.grade("q:g1", quality: 5, now: now)       // 第二次→间隔 6 天
        let due = s.cards["q:g1"]!.due
        XCTAssertGreaterThan(due, Calendar.current.date(byAdding: .day, value: 5, to: now)!)
        s.reset()
    }

    func testSM2FailResetsInterval() {
        let s = ReviewScheduler.shared
        s.reset()
        s.addIfAbsent("q:g1")
        let now = Date()
        s.grade("q:g1", quality: 5, now: now)
        s.grade("q:g1", quality: 1, now: now)       // 没记住→重置，间隔回到 1 天
        XCTAssertEqual(s.cards["q:g1"]!.interval, 1)
        XCTAssertEqual(s.cards["q:g1"]!.reps, 0)
        XCTAssertGreaterThanOrEqual(s.cards["q:g1"]!.ease, 1.3)  // EF 有下限
        s.reset()
    }

    func testPhraseBookIntegrity() {
        let all = PhraseBook.all
        XCTAssertEqual(all.count, 30)
        XCTAssertEqual(Set(all.map(\.id)).count, all.count, "句式卡 ID 必须唯一")
        for cat in PhraseCategory.allCases {
            XCTAssertFalse(PhraseBook.cards(in: cat).isEmpty, "类目 \(cat.title) 不应为空")
        }
        XCTAssertFalse(PhraseBook.cards(in: .polysemy).isEmpty, "应有熟词僻义档案")
    }

    func testContinuationWorkshopIntegrity() {
        let all = ContinuationData.all
        XCTAssertFalse(all.isEmpty)
        XCTAssertEqual(Set(all.map(\.id)).count, all.count, "情境 ID 必须唯一")
        for p in all {
            XCTAssertFalse(p.stages.isEmpty, "\(p.id) 缺情节链")
            XCTAssertFalse(p.rubric.isEmpty, "\(p.id) 缺自评清单")
            XCTAssertFalse(p.modelEssay.isEmpty)
            for stage in p.stages {
                // 关联句式必须真实存在
                for pid in stage.phraseIds {
                    XCTAssertNotNil(PhraseBook.all.first { $0.id == pid }, "\(p.id)/\(stage.name) 关联了不存在的句式 \(pid)")
                }
            }
        }
    }

    func testReviewRefResolves() {
        XCTAssertNotNil(ReviewRef.resolve("q:g1"))
        XCTAssertNotNil(ReviewRef.resolve("p:p1"))
        XCTAssertNil(ReviewRef.resolve("x:none"))
    }

    // MARK: - 高频狙击

    func testSniperScoreFormula() {
        // 高频权重 0.9、掌握度 0.5 → 0.45
        XCTAssertEqual(HighFreqEngine.sniperScore(frequency: 0.9, mastery: 0.5), 0.45, accuracy: 0.0001)
        // 完全掌握 → 优先级 0
        XCTAssertEqual(HighFreqEngine.sniperScore(frequency: 1.0, mastery: 1.0), 0, accuracy: 0.0001)
    }

    func testSniperRanksHighFreqWeakFirst() {
        let hits = HighFreqEngine.hitList(HighFreqData.all) { _ in 0 }   // 全未掌握
        // 全未掌握时，排序应与高频权重降序一致
        XCTAssertEqual(hits.first?.point.frequencyWeight, HighFreqData.all.map(\.frequencyWeight).max())
        for i in 1..<hits.count {
            XCTAssertGreaterThanOrEqual(hits[i - 1].sniperScore, hits[i].sniperScore)
        }
    }

    func testMasteredPointDropsPriority() {
        let p = HighFreqData.all.first!
        let unmastered = HighFreqEngine.sniperScore(frequency: p.frequencyWeight, mastery: 0)
        let mastered = HighFreqEngine.sniperScore(frequency: p.frequencyWeight, mastery: 1)
        XCTAssertGreaterThan(unmastered, mastered)
        XCTAssertEqual(mastered, 0, accuracy: 0.0001)
    }

    func testHighFreqDataIntegrity() {
        let all = HighFreqData.all
        XCTAssertEqual(all.count, 30)
        XCTAssertEqual(Set(all.map(\.id)).count, all.count, "高频考点 ID 必须唯一")
        for p in all {
            XCTAssertTrue((0...1).contains(p.frequencyWeight))
            XCTAssertFalse(p.digest.isEmpty)
            // 关联题若存在，必须真实
            for qid in p.linkedQuestionIds { XCTAssertNotNil(QuestionBank.find(qid), "高频点 \(p.id) 关联了不存在的题 \(qid)") }
        }
    }

    // MARK: - 每日计划 / Streak / 倒计时

    func testStreakConsecutiveDays() {
        // 昨天完成→今天再完成，streak +1
        XCTAssertEqual(DailyManager.nextStreak(current: 3, lastCompletedDay: "2026-06-22", today: "2026-06-23", yesterday: "2026-06-22"), 4)
    }

    func testStreakResetsAfterGap() {
        // 上次完成是三天前→断签，重置为 1
        XCTAssertEqual(DailyManager.nextStreak(current: 9, lastCompletedDay: "2026-06-20", today: "2026-06-23", yesterday: "2026-06-22"), 1)
    }

    func testStreakNoDoubleCountSameDay() {
        XCTAssertEqual(DailyManager.nextStreak(current: 5, lastCompletedDay: "2026-06-23", today: "2026-06-23", yesterday: "2026-06-22"), 5)
    }

    func testDaysToGaokaoRollsToNextYear() {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(identifier: "Asia/Shanghai")!
        // 2026-06-23 已过当年高考(6/7)→应指向 2027-06-07
        let now = cal.date(from: DateComponents(year: 2026, month: 6, day: 23))!
        let d = DailyManager.daysToGaokao(from: now, calendar: cal)
        XCTAssertEqual(d, 349)   // 2026-06-23 → 2027-06-07
    }

    func testDaysToGaokaoSameYear() {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(identifier: "Asia/Shanghai")!
        let now = cal.date(from: DateComponents(year: 2026, month: 6, day: 1))!
        XCTAssertEqual(DailyManager.daysToGaokao(from: now, calendar: cal), 6)  // 6/1 → 6/7
    }

    // MARK: - 限时模考

    func testMockAssembleCoversAvailableModules() {
        let available = Set(QuestionBank.all.map(\.module))   // 现有内容覆盖 6 模块（无听力）
        let paper = MockEngine.assemble(count: 14, from: QuestionBank.all)
        XCTAssertEqual(Set(paper.map(\.module)), available, "组卷应覆盖全部有内容的模块")
        XCTAssertEqual(Set(paper.map(\.id)).count, paper.count, "组卷不应出现重复题")
        XCTAssertLessThanOrEqual(paper.count, 14)
        XCTAssertGreaterThanOrEqual(paper.count, available.count)
    }

    func testMockScorePerfectMatchesCoveredFullScore() {
        let paper = MockEngine.assemble(count: 14, from: QuestionBank.all)
        let answers = Dictionary(uniqueKeysWithValues: paper.map { ($0.id, $0.answer) })  // 全对
        let r = MockEngine.score(questions: paper, answers: answers)
        XCTAssertEqual(r.totalCorrect, paper.count)
        XCTAssertEqual(r.scaledScore, r.coveredFullScore, accuracy: 0.01, "全对应折合覆盖模块满分")
        XCTAssertFalse(r.includesListening, "当前无听力内容")
        XCTAssertEqual(r.coveredFullScore, 120, accuracy: 0.01, "六模块满分合计 120（不含听力 30）")
    }

    func testMockScoreZeroAndWeakest() {
        let paper = MockEngine.assemble(count: 14, from: QuestionBank.all)
        // 全错（选一个非正确项）
        let answers = Dictionary(uniqueKeysWithValues: paper.map { ($0.id, ($0.answer + 1) % $0.options.count) })
        let r = MockEngine.score(questions: paper, answers: answers)
        XCTAssertEqual(r.totalCorrect, 0)
        XCTAssertEqual(r.scaledScore, 0, accuracy: 0.01)
        XCTAssertNotNil(r.weakestModule)
    }

    func testRecentErrorRate() {
        let signals = [
            ErrorSignal(module: .reading, vocabKnown: false, grammarKnown: true, strategyKnown: true, rushed: false),
            ErrorSignal(module: .reading, vocabKnown: true, grammarKnown: true, strategyKnown: false, rushed: false)
        ]
        let rate = DiagnosisEngine.recentErrorRate(from: signals, total: [.reading: 4])
        XCTAssertEqual(rate[.reading]!, 0.5, accuracy: 0.0001)
    }
}
