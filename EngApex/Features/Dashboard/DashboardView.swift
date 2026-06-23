import SwiftUI

/// 提分驾驶舱（主线 Tab）：估分仪表盘 + 提分雷达 + 今日最优路径。
/// 这是三大算法引擎的可视化舞台——app 的"心脏"在这里跳。
struct DashboardView: View {
    @EnvironmentObject var store: EngStore
    @EnvironmentObject var purchase: PurchaseManager
    @ObservedObject private var daily = DailyManager.shared

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Spacing.xl) {
                    planCard
                    estimatorCard
                    sniperCard
                    reviewCard
                    radarSection
                    moduleBars
                }
                .padding(Spacing.lg)
                .readableWidth()
            }
            .background(Color.apexBackground.ignoresSafeArea())
            .navigationTitle("提分驾驶舱")
        }
    }

    // MARK: 今日提分计划（高考倒计时 + Streak + 三目标）

    private var planCard: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("距高考还有").font(AppFont.caption).foregroundColor(.secondary)
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("\(daily.daysToGaokao)").font(AppFont.bigStat(34)).foregroundColor(.apexLava)
                        Text("天").font(AppFont.body).foregroundColor(.secondary)
                    }
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 2) {
                    Label("\(daily.streak) 天", systemImage: "flame.fill")
                        .font(AppFont.cardTitle).foregroundColor(.apexGold)
                    Text("连续打卡").font(AppFont.caption).foregroundColor(.secondary)
                }
            }
            Divider()
            HStack {
                Text("今日提分计划").font(AppFont.cardTitle)
                Spacer()
                Text("\(daily.doneCount)/3").font(AppFont.caption)
                    .foregroundColor(daily.allDone ? .apexEmerald : .secondary)
            }
            goalRow("刷题 \(min(daily.log.quizzed, DailyManager.quizGoal))/\(DailyManager.quizGoal)", done: daily.quizDone, icon: "target")
            goalRow("复习到期卡片", done: daily.reviewDone, icon: "brain.head.profile")
            goalRow("狙击 1 个高频考点", done: daily.sniperDone, icon: "scope")
        }
        .cardSurface()
    }

    private func goalRow(_ title: String, done: Bool, icon: String) -> some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: done ? "checkmark.circle.fill" : "circle")
                .foregroundColor(done ? .apexEmerald : .secondary)
            Image(systemName: icon).font(.caption).foregroundColor(.apexStarBlue)
            Text(title).font(AppFont.body).foregroundColor(done ? .secondary : .primary)
                .strikethrough(done)
            Spacer()
        }
    }

    // MARK: 估分仪表盘

    private var estimatorCard: some View {
        let total = store.totalEstimate
        let answered = !store.performances.isEmpty
        return VStack(spacing: Spacing.md) {
            Text("高考英语 · 估分").font(AppFont.caption).foregroundColor(.secondary)
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(answered ? fmt(total.score) : "—")
                    .font(AppFont.bigStat(52)).foregroundColor(.apexStarBlue)
                Text("/ 150").font(AppFont.body).foregroundColor(.secondary)
            }
            if answered {
                Text("参考区间 \(fmt(total.low))–\(fmt(total.high)) 分")
                    .font(AppFont.caption).foregroundColor(.secondary)
            } else {
                Text("先去题型靶场做几题，算法开始为你估分")
                    .font(AppFont.caption).foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .cardSurface()
    }

    // MARK: 高频狙击入口

    private var sniperCard: some View {
        let top = store.sniperToday(limit: 3)
        return NavigationLink { HighFreqView() } label: {
            VStack(alignment: .leading, spacing: Spacing.sm) {
                HStack(spacing: Spacing.sm) {
                    Image(systemName: "scope").font(.title2).foregroundColor(.apexLava)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("高频狙击").font(AppFont.cardTitle)
                        Text("算法挑出高频且你最弱的考点，先打这些").font(AppFont.caption).foregroundColor(.secondary)
                    }
                    Spacer()
                    Image(systemName: "chevron.right").font(.caption).foregroundColor(.secondary)
                }
                if !top.isEmpty {
                    FlowLayout(spacing: 6) {
                        ForEach(top) { hit in
                            TagChip(text: hit.point.name, color: .apexLava)
                        }
                    }
                }
            }
            .cardSurface(padding: Spacing.md)
        }
        .buttonStyle(.plain)
    }

    // MARK: 今日复习

    @ViewBuilder private var reviewCard: some View {
        let due = ReviewScheduler.shared.dueCount
        if due > 0 {
            NavigationLink { ReviewView() } label: {
                HStack(spacing: Spacing.md) {
                    Image(systemName: "brain.head.profile").font(.title2).foregroundColor(.apexMystery)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("今日复习 \(due) 张").font(AppFont.cardTitle)
                        Text("错题与句式按遗忘曲线到期，趁热复盘").font(AppFont.caption).foregroundColor(.secondary)
                    }
                    Spacer()
                    Image(systemName: "chevron.right").font(.caption).foregroundColor(.secondary)
                }
                .cardSurface(padding: Spacing.md)
            }
            .buttonStyle(.plain)
        }
    }

    // MARK: 提分雷达 · 今日最优路径

    private var radarSection: some View {
        let path = store.topPath(limit: 3)
        return VStack(alignment: .leading, spacing: Spacing.md) {
            SectionHeader(title: "提分雷达 · 今日最优路径", systemImage: "scope", accent: .apexLava)
            if store.performances.isEmpty {
                Text("做题后，雷达会按‘性价比’把你下一个 +5 分排在最前。")
                    .font(AppFont.caption).foregroundColor(.secondary)
                    .padding(.vertical, Spacing.sm)
            } else {
                ForEach(Array(path.enumerated()), id: \.element.id) { idx, opp in
                    NavigationLink {
                        if let level = MainLineData.level(for: opp.module) { QuizView(level: level) }
                    } label: { radarRow(rank: idx + 1, opp: opp) }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private func radarRow(rank: Int, opp: GainOpportunity) -> some View {
        HStack(spacing: Spacing.md) {
            Text("\(rank)").font(AppFont.bigStat(22)).foregroundColor(.apexLava)
                .frame(width: 28)
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Image(systemName: opp.module.icon).foregroundColor(.apexStarBlue)
                    Text(opp.module.title).font(AppFont.cardTitle)
                    Spacer()
                    Text("+\(fmt(opp.expectedGain))").font(AppFont.cardTitle).foregroundColor(.apexEmerald)
                }
                Text(opp.reason).font(AppFont.caption).foregroundColor(.secondary).lineLimit(2)
                ProgressView(value: opp.normalizedROI).tint(.apexLava)
            }
        }
        .cardSurface(padding: Spacing.md)
    }

    // MARK: 各模块估分条

    private var moduleBars: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            SectionHeader(title: "各模块估分", systemImage: "chart.bar.fill", accent: .apexStarBlue)
            ForEach(store.estimates) { est in
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Image(systemName: est.module.icon).font(.caption).foregroundColor(.secondary)
                        Text(est.module.title).font(AppFont.body)
                        Spacer()
                        Text("\(fmt(est.estimatedScore))/\(fmt(est.fullScore))")
                            .font(AppFont.caption).foregroundColor(.secondary)
                        if est.confidence < 0.2 {
                            Text("待测").font(AppFont.chip).foregroundColor(.apexGold)
                        }
                    }
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Capsule().fill(Color.secondary.opacity(0.15))
                            Capsule().fill(Color.apexStarBlue)
                                .frame(width: geo.size.width * est.scoreRatio)
                        }
                    }.frame(height: 8)
                }
            }
        }
        .cardSurface()
    }

    private func fmt(_ v: Double) -> String {
        v == v.rounded() ? String(Int(v)) : String(format: "%.1f", v)
    }
}
