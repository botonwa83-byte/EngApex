import SwiftUI

/// 限时模考：算法组卷 → 限时作答（不即时揭答案）→ 自动判分折合高考分 + 薄弱报告。
struct MockExamView: View {
    @EnvironmentObject var store: EngStore
    @ObservedObject private var purchase = PurchaseManager.shared
    @Environment(\.dismiss) private var dismiss
    @State private var showPaywall = false

    private enum Phase { case intro, exam, result }
    @State private var phase: Phase = .intro
    @State private var paper: [Question] = []
    @State private var answers: [String: Int] = [:]
    @State private var index = 0
    @State private var elapsed = 0
    @State private var timeLimit = 0
    @State private var result: MockResult?
    @State private var listeningPlayCount = 0
    @State private var timedOut = false
    @State private var mockLength: MockLength = .quick
    @State private var selectedPaper: Int = 0

    /// 快速模考用于碎片时间的题型抽样；完整模考是 6 套固定全真模拟卷(套卷一免费试用)，合起来覆盖题库全部题目，可反复重考追踪进步。
    /// 注：题目均为本 app 自研、仿真考点与难度分布，非真实历年高考原题，UI 文案不用"真题"以免误导。
    enum MockLength: String, CaseIterable, Identifiable {
        case quick, full
        var id: String { rawValue }
        var label: String { self == .quick ? "快速模考 · 14 题" : "完整模考 · 6 套全真模拟卷" }
    }
    private static let quickCount = 14
    private static let paperNumerals = ["一", "二", "三", "四", "五", "六"]

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    /// 剩余秒数：到 0 自动交卷，让"限时"真正限时，逼真训练考场的时间分配。
    private var remaining: Int { max(0, timeLimit - elapsed) }

    var body: some View {
        Group {
            switch phase {
            case .intro:  introView
            case .exam:   examView
            case .result: resultView
            }
        }
        .background(Color.apexBackground.ignoresSafeArea())
        .navigationTitle("限时模考")
        .navigationBarTitleDisplayMode(.inline)
        .onReceive(timer) { _ in
            guard phase == .exam else { return }
            elapsed += 1
            if remaining <= 0 { timedOut = true; submit() }
        }
        .onChange(of: index) { _ in listeningPlayCount = 0; autoPlayIfNeeded() }
        .sheet(isPresented: $showPaywall) { PaywallView() }
    }

    /// 按模块给每题分配一个接近真实考场节奏的时间预算（含听音频/审题时间）。
    private static func secondsBudget(for module: ExamModule) -> Int {
        switch module {
        case .listening:      return 75
        case .reading:        return 95
        case .sevenChoose:    return 70
        case .cloze:          return 55
        case .grammarFill:    return 50
        case .appliedWriting: return 45
        case .continuation:   return 45
        }
    }
    private static func timeLimit(for paper: [Question]) -> Int {
        paper.reduce(0) { $0 + secondsBudget(for: $1.module) }
    }

    private var fixedPapers: [[Question]] { MockEngine.fixedPapers(from: QuestionBank.all) }

    private var estimatedMinutes: Int {
        let p = mockLength == .quick
            ? MockEngine.assemble(count: Self.quickCount, from: QuestionBank.all)
            : fixedPapers[selectedPaper]
        return Self.timeLimit(for: p) / 60
    }

    /// 听力题首次出现时自动播放一次。
    private func autoPlayIfNeeded() {
        guard index < paper.count, let script = paper[index].listeningScript, listeningPlayCount == 0 else { return }
        listeningPlayCount += 1
        SpeechPlayer.shared.play(script)
    }

    // MARK: Intro

    private var introView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.lg) {
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Label("算法组卷", systemImage: "doc.text.magnifyingglass")
                        .font(AppFont.cardTitle).foregroundColor(.apexLava)
                    Text("自动抽取一套覆盖各题型的卷子，限时作答、时间到自动交卷并折合高考分。")
                        .font(AppFont.caption).foregroundColor(.secondary)
                    Text("满分 150 分（含听力，音频为离线语音合成朗读）")
                        .font(AppFont.chip).foregroundColor(.apexGold)
                }.frame(maxWidth: .infinity, alignment: .leading).cardSurface(padding: Spacing.md)

                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Picker("模考长度", selection: $mockLength) {
                        ForEach(MockLength.allCases) { length in
                            Text(length.label).tag(length)
                        }
                    }
                    .pickerStyle(.segmented)
                    Text("本卷按题型节奏配速，约 \(estimatedMinutes) 分钟，到点强制交卷")
                        .font(AppFont.chip).foregroundColor(.secondary)
                    if mockLength == .full {
                        Text(purchase.isUnlocked
                             ? "6 套固定全真模拟卷，合起来覆盖题库全部题目，可反复重考、各自追踪进步。"
                             : "套卷一永久免费试用；其余 5 套(含考点级薄弱报告)为解锁内容。")
                            .font(AppFont.chip).foregroundColor(purchase.isUnlocked ? .secondary : .apexLava)
                    }
                }.cardSurface(padding: Spacing.md)

                if mockLength == .full {
                    paperPicker
                }

                let mock = MockManager.shared
                if mock.count > 0 {
                    HStack {
                        stat("上次", mock.lastScore)
                        Divider().frame(height: 36)
                        stat("最佳", mock.bestScore)
                        Divider().frame(height: 36)
                        VStack(spacing: 2) {
                            Text("\(mock.count)").font(AppFont.bigStat(22)).foregroundColor(.apexStarBlue)
                            Text("已考次数").font(AppFont.caption).foregroundColor(.secondary)
                        }.frame(maxWidth: .infinity)
                    }.cardSurface(padding: Spacing.md)
                }

                Button { startExam() } label: {
                    Text("开始模考").font(AppFont.cardTitle).foregroundColor(.white)
                        .frame(maxWidth: .infinity).padding(Spacing.md)
                        .background(Color.apexLava).cornerRadius(Radius.inner)
                }
            }
            .padding(Spacing.lg).readableWidth()
        }
    }

    private func stat(_ label: String, _ v: Double) -> some View {
        VStack(spacing: 2) {
            Text(fmt(v)).font(AppFont.bigStat(22)).foregroundColor(.apexLava)
            Text(label).font(AppFont.caption).foregroundColor(.secondary)
        }.frame(maxWidth: .infinity)
    }

    /// 6 套全真模拟卷的选择列表：各自独立显示题量/用时与上次/最佳成绩，可反复重考同一套追踪进步。
    /// 套卷一(freePaperIndex)永久免费试用，其余套卷需解锁完整模考才能选中。
    private func isPaperLocked(_ i: Int) -> Bool {
        i != MockEngine.freePaperIndex && !purchase.isUnlocked
    }

    private var paperPicker: some View {
        let papers = fixedPapers
        let manager = MockManager.shared
        return VStack(spacing: Spacing.sm) {
            ForEach(0..<papers.count, id: \.self) { i in
                let s = manager.papers[i]
                let p = papers[i]
                let locked = isPaperLocked(i)
                Button {
                    if locked { showPaywall = true } else { selectedPaper = i }
                } label: {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            HStack(spacing: 4) {
                                Text("套卷\(Self.paperNumerals[i])").font(AppFont.cardTitle)
                                if i == MockEngine.freePaperIndex {
                                    TagChip(text: "免费", color: .apexEmerald)
                                }
                            }
                            Text("\(p.count) 题 · 约 \(Self.timeLimit(for: p) / 60) 分钟")
                                .font(AppFont.caption).foregroundColor(.secondary)
                        }
                        Spacer()
                        if locked {
                            Image(systemName: "lock.fill").foregroundColor(.secondary)
                        } else {
                            if s.count > 0 {
                                VStack(alignment: .trailing, spacing: 2) {
                                    Text("上次 \(fmt(s.last))").font(AppFont.chip).foregroundColor(.secondary)
                                    Text("最佳 \(fmt(s.best))").font(AppFont.chip).foregroundColor(.apexLava)
                                }
                            }
                            Image(systemName: selectedPaper == i ? "largecircle.fill.circle" : "circle")
                                .foregroundColor(.apexLava)
                        }
                    }
                    .padding(Spacing.md).frame(maxWidth: .infinity)
                    .background(!locked && selectedPaper == i ? Color.apexLava.opacity(0.12) : Color.apexCardSurface)
                    .cornerRadius(Radius.inner)
                    .opacity(locked ? 0.6 : 1)
                }.buttonStyle(.plain)
            }
        }.cardSurface(padding: Spacing.md)
    }

    // MARK: Exam

    @ViewBuilder private var examView: some View {
        if index < paper.count {
            let q = paper[index]
            ScrollView {
                VStack(alignment: .leading, spacing: Spacing.lg) {
                    HStack {
                        TagChip(text: q.module.title, color: .apexStarBlue)
                        Spacer()
                        Label(remainingString, systemImage: "clock")
                            .font(AppFont.caption).foregroundColor(remaining <= 60 ? .apexDanger : .secondary)
                        Text("\(index + 1)/\(paper.count)").font(AppFont.caption).foregroundColor(.secondary)
                    }
                    ProgressView(value: Double(index + 1), total: Double(paper.count)).tint(.apexLava)
                    if let script = q.listeningScript {
                        ListeningPlayerCard(script: script, playCount: $listeningPlayCount)
                    }
                    Text(q.stem).font(.body).fixedSize(horizontal: false, vertical: true)
                    ForEach(Array(q.options.enumerated()), id: \.offset) { i, opt in
                        Button { answers[q.id] = i } label: {
                            HStack {
                                Text(opt).font(AppFont.body).multilineTextAlignment(.leading)
                                    .fixedSize(horizontal: false, vertical: true)
                                Spacer()
                                if answers[q.id] == i {
                                    Image(systemName: "largecircle.fill.circle").foregroundColor(.apexLava)
                                }
                            }
                            .padding(Spacing.md).frame(maxWidth: .infinity, alignment: .leading)
                            .background(answers[q.id] == i ? Color.apexLava.opacity(0.12) : Color.apexCardSurface)
                            .cornerRadius(Radius.inner)
                        }.buttonStyle(.plain)
                    }
                    HStack {
                        if index > 0 {
                            Button { index -= 1 } label: { Label("上一题", systemImage: "chevron.left").font(AppFont.body) }
                        }
                        Spacer()
                        Button {
                            if index + 1 < paper.count { index += 1 } else { submit() }
                        } label: {
                            Text(index + 1 < paper.count ? "下一题" : "交卷判分")
                                .font(AppFont.cardTitle).foregroundColor(.white)
                                .padding(.horizontal, Spacing.xl).padding(.vertical, Spacing.sm)
                                .background(Color.apexLava).cornerRadius(Radius.inner)
                        }
                    }
                }
                .padding(Spacing.lg).readableWidth()
            }
        }
    }

    // MARK: Result

    @ViewBuilder private var resultView: some View {
        if let r = result {
            ScrollView {
                VStack(spacing: Spacing.lg) {
                    VStack(spacing: 4) {
                        Text(mockLength == .full ? "套卷\(Self.paperNumerals[selectedPaper]) · 折合高考分" : "折合高考分")
                            .font(AppFont.caption).foregroundColor(.secondary)
                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                            Text(fmt(r.scaledScore)).font(AppFont.bigStat(52)).foregroundColor(.apexLava)
                            Text("/ \(fmt(r.coveredFullScore))").font(AppFont.body).foregroundColor(.secondary)
                        }
                        Text("答对 \(r.totalCorrect)/\(r.totalCount) · 用时 \(timeString)")
                            .font(AppFont.caption).foregroundColor(.secondary)
                        if timedOut {
                            Text("时间到，已自动交卷").font(AppFont.chip).foregroundColor(.apexDanger)
                        }
                    }.frame(maxWidth: .infinity).cardSurface()

                    VStack(alignment: .leading, spacing: Spacing.md) {
                        SectionHeader(title: "各模块表现", systemImage: "chart.bar.fill", accent: .apexStarBlue)
                        ForEach(ExamModule.allCases.filter { (r.perModule[$0]?.total ?? 0) > 0 }) { m in
                            let e = r.perModule[m]!
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text(m.title).font(AppFont.body)
                                    Spacer()
                                    Text("\(e.correct)/\(e.total)").font(AppFont.caption).foregroundColor(.secondary)
                                }
                                GeometryReader { geo in
                                    ZStack(alignment: .leading) {
                                        Capsule().fill(Color.secondary.opacity(0.15))
                                        Capsule().fill(Color.apexStarBlue)
                                            .frame(width: geo.size.width * (e.total > 0 ? Double(e.correct) / Double(e.total) : 0))
                                    }
                                }.frame(height: 7)
                            }
                        }
                    }.cardSurface()

                    if let weak = r.weakestModule {
                        HStack(spacing: Spacing.sm) {
                            Image(systemName: "scope").foregroundColor(.apexDanger)
                            Text("薄弱点：**\(weak.title)** —— 去高频狙击与提分雷达重点补。")
                                .font(AppFont.caption)
                            Spacer()
                        }.cardSurface(padding: Spacing.md)
                    }

                    if purchase.isUnlocked {
                        pointTagReport(r)
                    } else {
                        pointTagTeaser
                    }

                    Text("错题已自动收录，可在错题本与智能复习里再战。")
                        .font(AppFont.caption).foregroundColor(.secondary)

                    Button { dismiss() } label: {
                        Text("完成").font(AppFont.cardTitle).foregroundColor(.white)
                            .frame(maxWidth: .infinity).padding(Spacing.md)
                            .background(Color.apexLava).cornerRadius(Radius.inner)
                    }
                }
                .padding(Spacing.lg).readableWidth()
            }
        }
    }

    @ViewBuilder private func pointTagReport(_ r: MockResult) -> some View {
        let weakest = Array(r.weakestPointTags.prefix(5))
        if !weakest.isEmpty {
            VStack(alignment: .leading, spacing: Spacing.md) {
                SectionHeader(title: "考点级薄弱报告", systemImage: "magnifyingglass", accent: .apexMystery)
                Text("不只是哪个模块弱，精确到具体考点——完整模考的样本量足够支撑这份细颗粒度报告。")
                    .font(AppFont.caption).foregroundColor(.secondary)
                ForEach(weakest, id: \.tag) { item in
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(item.tag).font(AppFont.body)
                            Spacer()
                            Text("\(Int(item.accuracy * 100))% (\(item.total) 题)").font(AppFont.caption).foregroundColor(.secondary)
                        }
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                Capsule().fill(Color.secondary.opacity(0.15))
                                Capsule().fill(Color.apexDanger).frame(width: geo.size.width * item.accuracy)
                            }
                        }.frame(height: 6)
                    }
                }
            }.cardSurface()
        }
    }

    private var pointTagTeaser: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            SectionHeader(title: "考点级薄弱报告", systemImage: "magnifyingglass", accent: .apexMystery)
            Text("解锁完整版可看到精确到具体考点(而非只是模块)的薄弱排行——知道具体差在哪一个语法点/阅读技巧上。")
                .font(AppFont.caption).foregroundColor(.secondary)
            Button { showPaywall = true } label: {
                Label("解锁完整模考报告", systemImage: "lock.open.fill").font(AppFont.cardTitle).foregroundColor(.white)
                    .frame(maxWidth: .infinity).padding(Spacing.md)
                    .background(Color.apexStarBlue).cornerRadius(Radius.inner)
            }
        }.cardSurface()
    }

    // MARK: 逻辑

    private func startExam() {
        if mockLength == .full && isPaperLocked(selectedPaper) {
            showPaywall = true
            return
        }
        paper = mockLength == .quick
            ? MockEngine.assemble(count: Self.quickCount, from: QuestionBank.all)
            : fixedPapers[selectedPaper]
        answers = [:]; index = 0; elapsed = 0; listeningPlayCount = 0; timedOut = false
        timeLimit = Self.timeLimit(for: paper)
        phase = .exam
        autoPlayIfNeeded()
    }

    private func submit() {
        let r = MockEngine.score(questions: paper, answers: answers)
        // 回喂各引擎：已作答的题按对错记录（错题自动入错题本/复习库）
        for q in paper {
            guard let a = answers[q.id] else { continue }
            store.record(q, correct: a == q.answer)
        }
        if mockLength == .quick {
            MockManager.shared.recordQuickResult(r.scaledScore)
        } else {
            MockManager.shared.recordPaperResult(selectedPaper, r.scaledScore)
        }
        result = r
        phase = .result
    }

    private var timeString: String { String(format: "%02d:%02d", elapsed / 60, elapsed % 60) }
    private var remainingString: String { String(format: "%02d:%02d", remaining / 60, remaining % 60) }
    private func fmt(_ v: Double) -> String { v == v.rounded() ? String(Int(v)) : String(format: "%.1f", v) }
}
