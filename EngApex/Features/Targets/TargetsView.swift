import SwiftUI

/// 题型靶场（练习 Tab）：主线 6 关入口，按提分雷达 ROI 排序。
struct TargetsView: View {
    @EnvironmentObject var store: EngStore
    @EnvironmentObject var purchase: PurchaseManager
    @State private var showPaywall = false

    /// 关卡按雷达 ROI 排序（无数据时按主线顺序）。
    private var orderedLevels: [MainLevel] {
        let rank = Dictionary(uniqueKeysWithValues: store.radar.enumerated().map { ($0.element.module, $0.offset) })
        if store.performances.isEmpty { return MainLineData.levels }
        return MainLineData.levels.sorted { (rank[$0.module] ?? 99) < (rank[$1.module] ?? 99) }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Spacing.md) {
                    mockBanner
                    Text("按‘提分性价比’为你排好序——从上往下打，最划算。")
                        .font(AppFont.caption).foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ForEach(orderedLevels) { level in
                        levelCard(level)
                    }
                }
                .padding(Spacing.lg)
                .readableWidth()
            }
            .background(Color.apexBackground.ignoresSafeArea())
            .navigationTitle("题型靶场")
            .sheet(isPresented: $showPaywall) { PaywallView() }
        }
    }

    private var mockBanner: some View {
        NavigationLink { MockExamView() } label: {
            HStack(spacing: Spacing.md) {
                Image(systemName: "stopwatch").font(.title2).foregroundColor(.apexLava)
                VStack(alignment: .leading, spacing: 2) {
                    Text("限时模考").font(AppFont.cardTitle)
                    Text("算法组卷 · 限时实战 · 自动判分折合高考分").font(AppFont.caption).foregroundColor(.secondary)
                }
                Spacer()
                if MockManager.shared.count > 0 {
                    Text("上次 \(Int(MockManager.shared.lastScore))").font(AppFont.chip).foregroundColor(.apexLava)
                }
                Image(systemName: "chevron.right").font(.caption).foregroundColor(.secondary)
            }
            .cardSurface(padding: Spacing.md)
        }
        .buttonStyle(.plain)
    }

    private func levelCard(_ level: MainLevel) -> some View {
        let locked = purchase.isLevelLocked(level)
        let qs = QuestionBank.byLevel(level.id)
        let done = qs.filter { store.stat(for: $0.id).attempts > 0 }.count
        return Group {
            if locked {
                Button { showPaywall = true } label: { cardBody(level, done: done, total: qs.count, locked: true) }
                    .buttonStyle(.plain)
            } else {
                NavigationLink { QuizView(level: level) } label: { cardBody(level, done: done, total: qs.count, locked: false) }
                    .buttonStyle(.plain)
            }
        }
    }

    private func cardBody(_ level: MainLevel, done: Int, total: Int, locked: Bool) -> some View {
        HStack(spacing: Spacing.md) {
            ZStack {
                Circle().fill(Color.apexStarBlue.opacity(0.15)).frame(width: 44, height: 44)
                Image(systemName: locked ? "lock.fill" : level.module.icon)
                    .foregroundColor(locked ? .secondary : .apexStarBlue)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(level.title).font(AppFont.cardTitle)
                Text(level.subtitle).font(AppFont.caption).foregroundColor(.secondary)
                if !locked {
                    Text("已练 \(done)/\(total)").font(AppFont.chip).foregroundColor(.apexEmerald)
                }
            }
            Spacer()
            Image(systemName: "chevron.right").font(.caption).foregroundColor(.secondary)
        }
        .cardSurface(padding: Spacing.md)
    }
}

/// 做题页：答题 → 揭示解题决策树 + 陷阱 → 记录喂引擎。
/// 答错时弹出极简自评，结果交给错因诊断树。
struct QuizView: View {
    let level: MainLevel
    @EnvironmentObject var store: EngStore
    @Environment(\.dismiss) private var dismiss

    @State private var index = 0
    @State private var selected: Int?
    @State private var revealed = false
    @State private var showDiagnose = false

    private var questions: [Question] { QuestionBank.byLevel(level.id) }
    private var q: Question? { index < questions.count ? questions[index] : nil }

    var body: some View {
        ScrollView {
            if let q {
                VStack(alignment: .leading, spacing: Spacing.lg) {
                    header
                    modelNote
                    Text(q.stem).font(.body).fixedSize(horizontal: false, vertical: true)
                    ForEach(Array(q.options.enumerated()), id: \.offset) { i, opt in
                        optionRow(q, i: i, text: opt)
                    }
                    if revealed { explanation(q) }
                }
                .padding(Spacing.lg)
                .readableWidth()
            } else {
                finishView
            }
        }
        .background(Color.apexBackground.ignoresSafeArea())
        .navigationTitle(level.title)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showDiagnose) {
            if let q { DiagnoseSheet(question: q) { advance() } }
        }
    }

    private var header: some View {
        HStack {
            TagChip(text: level.module.title, color: .apexStarBlue)
            if let q { TagChip(text: q.pointTag, color: .apexMystery) }
            Spacer()
            if !questions.isEmpty { Text("\(min(index + 1, questions.count))/\(questions.count)").font(AppFont.caption).foregroundColor(.secondary) }
        }
    }

    private var modelNote: some View {
        DisclosureGroup {
            Text(level.modelNote).font(AppFont.caption).foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true).padding(.top, 4)
        } label: {
            Label("得分点模型 / 解题决策树", systemImage: "lightbulb").font(AppFont.caption).foregroundColor(.apexGold)
        }
        .cardSurface(padding: Spacing.md)
    }

    private func optionRow(_ q: Question, i: Int, text: String) -> some View {
        let isAnswer = i == q.answer
        let isPicked = selected == i
        let bg: Color = {
            guard revealed else { return isPicked ? Color.apexStarBlue.opacity(0.15) : Color.apexCardSurface }
            if isAnswer { return Color.apexEmerald.opacity(0.2) }
            if isPicked { return Color.apexDanger.opacity(0.2) }
            return Color.apexCardSurface
        }()
        return Button {
            guard !revealed else { return }
            selected = i; reveal(q)
        } label: {
            HStack {
                Text(text).font(AppFont.body).multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                if revealed && isAnswer { Image(systemName: "checkmark.circle.fill").foregroundColor(.apexEmerald) }
                if revealed && isPicked && !isAnswer { Image(systemName: "xmark.circle.fill").foregroundColor(.apexDanger) }
            }
            .padding(Spacing.md)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(bg).cornerRadius(Radius.inner)
        }
        .buttonStyle(.plain)
    }

    private func explanation(_ q: Question) -> some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("解题决策树").font(AppFont.cardTitle).foregroundColor(.apexStarBlue)
            ForEach(Array(q.strategy.enumerated()), id: \.offset) { i, step in
                HStack(alignment: .top, spacing: 6) {
                    Text("\(i + 1)").font(AppFont.chip).foregroundColor(.white)
                        .frame(width: 18, height: 18).background(Color.apexStarBlue).clipShape(Circle())
                    Text(step).font(AppFont.body).fixedSize(horizontal: false, vertical: true)
                }
            }
            Label(q.trap, systemImage: "exclamationmark.triangle.fill")
                .font(AppFont.caption).foregroundColor(.apexDanger)
                .padding(.top, 4)
            Button {
                if selected == q.answer { advance() } else { showDiagnose = true }
            } label: {
                Text(index + 1 < questions.count ? "下一题" : "完成本关")
                    .font(AppFont.cardTitle).foregroundColor(.white)
                    .frame(maxWidth: .infinity).padding(Spacing.md)
                    .background(Color.apexStarBlue).cornerRadius(Radius.inner)
            }
            .padding(.top, Spacing.sm)
        }
        .cardSurface()
    }

    private var finishView: some View {
        VStack(spacing: Spacing.lg) {
            Image(systemName: "checkmark.seal.fill").font(.system(size: 56)).foregroundColor(.apexEmerald)
            Text("本关完成！").font(.title2.bold())
            Text("做题数据已喂给估分器与提分雷达，回驾驶舱看看变化。")
                .font(AppFont.body).foregroundColor(.secondary).multilineTextAlignment(.center)
            Button { dismiss() } label: {
                Text("返回").font(AppFont.cardTitle).foregroundColor(.white)
                    .frame(maxWidth: .infinity).padding(Spacing.md)
                    .background(Color.apexStarBlue).cornerRadius(Radius.inner)
            }
        }
        .padding(Spacing.xxl)
    }

    // MARK: 逻辑

    private func reveal(_ q: Question) {
        revealed = true
        let correct = selected == q.answer
        if correct { store.record(q, correct: true) }   // 答对直接记录；答错等自评后记录
    }

    private func advance() {
        revealed = false; selected = nil
        index += 1
        if index >= questions.count { store.markLevelComplete(level.id) }
    }
}

/// 答错后的极简自评 → 错因诊断树。
struct DiagnoseSheet: View {
    let question: Question
    let onDone: () -> Void
    @EnvironmentObject var store: EngStore
    @Environment(\.dismiss) private var dismiss

    @State private var vocab = true
    @State private var grammar = true
    @State private var strategy = true
    @State private var rushed = false

    var body: some View {
        NavigationStack {
            Form {
                Section("快速自评（帮算法定位你为什么丢分）") {
                    Toggle("题干关键词我都认识", isOn: $vocab)
                    Toggle("涉及的语法点我懂", isOn: $grammar)
                    Toggle("这类题的解法套路我清楚", isOn: $strategy)
                    Toggle("我是赶时间/没看清", isOn: $rushed)
                }
                Section {
                    let cause = DiagnosisEngine.diagnose(signal)
                    Label(cause.title, systemImage: cause.icon).foregroundColor(.apexLava)
                    Text(cause.advice).font(AppFont.caption).foregroundColor(.secondary)
                }
            }
            .navigationTitle("错因诊断")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("记录") {
                        store.record(question, correct: false, signal: signal)
                        dismiss(); onDone()
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }

    private var signal: ErrorSignal {
        ErrorSignal(module: question.module, vocabKnown: vocab, grammarKnown: grammar,
                    strategyKnown: strategy, rushed: rushed)
    }
}
