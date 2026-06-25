import SwiftUI

/// 更多 Tab：错因诊断 / 错题本 / 设置 / 解锁完整版。
struct MoreView: View {
    @EnvironmentObject var store: EngStore
    @ObservedObject private var purchase = PurchaseManager.shared
    @State private var showPaywall = false

    var body: some View {
        NavigationStack {
            List {
                if !purchase.isUnlocked {
                    Section {
                        Button { showPaywall = true } label: {
                            HStack(spacing: 12) {
                                Image(systemName: "crown.fill").font(.title3).foregroundColor(.apexGold)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("解锁完整版").font(.headline).foregroundColor(.primary)
                                    Text("主线 7 关全开（阅读/应用文/读后续写/听力），一次买断")
                                        .font(.caption).foregroundColor(.secondary)
                                }
                                Spacer()
                                Image(systemName: "chevron.right").font(.caption).foregroundColor(.secondary)
                            }.padding(.vertical, 4)
                        }
                    }
                }

                Section("我的提分") {
                    NavigationLink { ReviewView() } label: {
                        HStack {
                            Label("智能复习", systemImage: "brain.head.profile")
                            Spacer()
                            let due = ReviewScheduler.shared.dueCount
                            if due > 0 {
                                Text("\(due)").font(AppFont.chip).foregroundColor(.white)
                                    .padding(.horizontal, 7).padding(.vertical, 2)
                                    .background(Color.apexStarBlue).clipShape(Capsule())
                            }
                        }
                    }
                    NavigationLink { DiagnosisView() } label: {
                        HStack {
                            Label("错因诊断 · 找薄弱", systemImage: "chart.bar.xaxis")
                            Spacer()
                            if let top = store.causeDistribution.max(by: { $0.value < $1.value }) {
                                Text(top.key.title).font(AppFont.chip).foregroundColor(.apexDanger)
                            }
                        }
                    }
                    NavigationLink { ErrorBookView() } label: {
                        HStack {
                            Label("错题本", systemImage: "exclamationmark.triangle")
                            Spacer()
                            if !store.flaggedQuestions.isEmpty {
                                Text("\(store.flaggedQuestions.count)").font(AppFont.chip).foregroundColor(.white)
                                    .padding(.horizontal, 7).padding(.vertical, 2)
                                    .background(Color.apexLava).clipShape(Capsule())
                            }
                        }
                    }
                }

                Section("专项突破") {
                    NavigationLink { ContinuationWorkshopView() } label: {
                        Label("读后续写工坊", systemImage: "pencil.and.scribble")
                    }
                    NavigationLink { AppliedWritingWorkshopView() } label: {
                        Label("应用文工坊", systemImage: "envelope.fill")
                    }
                }

                Section("设置") {
                    NavigationLink { SettingsView() } label: {
                        Label("外观与数据", systemImage: "gearshape")
                    }
                }

                Section {
                    Text("EngApex · 英语登顶　提分导航仪")
                        .font(AppFont.caption).foregroundColor(.secondary)
                }
            }
            .navigationTitle("更多")
            .sheet(isPresented: $showPaywall) { PaywallView() }
        }
    }
}

/// 错因诊断：四类根因分布 + 建议。
struct DiagnosisView: View {
    @EnvironmentObject var store: EngStore

    var body: some View {
        let dist = store.causeDistribution
        let total = max(1, dist.values.reduce(0, +))
        return ScrollView {
            VStack(alignment: .leading, spacing: Spacing.lg) {
                if dist.isEmpty {
                    ContentUnavailableViewCompat(title: "还没有诊断数据",
                        systemImage: "stethoscope",
                        description: "做题答错并自评后，这里会告诉你分主要丢在哪一类。")
                        .frame(height: 320)
                } else {
                    ForEach(ErrorCause.allCases, id: \.self) { cause in
                        let n = dist[cause] ?? 0
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Label(cause.title, systemImage: cause.icon).foregroundColor(.apexLava)
                                Spacer()
                                Text("\(n) 次").font(AppFont.caption).foregroundColor(.secondary)
                            }
                            GeometryReader { geo in
                                ZStack(alignment: .leading) {
                                    Capsule().fill(Color.secondary.opacity(0.15))
                                    Capsule().fill(Color.apexLava)
                                        .frame(width: geo.size.width * CGFloat(n) / CGFloat(total))
                                }
                            }.frame(height: 8)
                            Text(cause.advice).font(AppFont.caption).foregroundColor(.secondary)
                        }
                        .cardSurface(padding: Spacing.md)
                    }
                }
            }
            .padding(Spacing.lg)
            .readableWidth()
        }
        .background(Color.apexBackground.ignoresSafeArea())
        .navigationTitle("错因诊断")
    }
}

/// 错题本：收录答错/收藏的题，可重做。
struct ErrorBookView: View {
    @EnvironmentObject var store: EngStore

    var body: some View {
        let items = store.flaggedQuestions
        return Group {
            if items.isEmpty {
                ContentUnavailableViewCompat(title: "还没有错题",
                    systemImage: "checkmark.seal",
                    description: "答错的题会自动收录到这里，方便你回头重做。")
            } else {
                List(items) { q in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(q.stem).font(AppFont.body).lineLimit(2)
                        HStack(spacing: 6) {
                            TagChip(text: q.module.title, color: .apexStarBlue)
                            TagChip(text: q.pointTag, color: .apexMystery)
                        }
                    }.padding(.vertical, 2)
                }
            }
        }
        .navigationTitle("错题本")
        .navigationBarTitleDisplayMode(.inline)
    }
}

/// 设置：外观切换 + 清空数据。
struct SettingsView: View {
    @ObservedObject private var appearance = AppearanceManager.shared
    @EnvironmentObject var store: EngStore
    @State private var showReset = false

    var body: some View {
        Form {
            Section("外观") {
                Picker("主题", selection: $appearance.preference) {
                    ForEach(AppearancePreference.allCases) { p in
                        Label(p.label, systemImage: p.icon).tag(p)
                    }
                }
            }
            Section("数据") {
                Button(role: .destructive) { showReset = true } label: {
                    Label("清空我的做题数据", systemImage: "trash")
                }
            }
        }
        .navigationTitle("外观与数据")
        .navigationBarTitleDisplayMode(.inline)
        .alert("确定清空？", isPresented: $showReset) {
            Button("清空", role: .destructive) { store.resetAll() }
            Button("取消", role: .cancel) {}
        } message: { Text("估分、错题、诊断记录都会被清除，不可恢复。") }
    }
}
