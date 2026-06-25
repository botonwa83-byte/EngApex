import SwiftUI

/// 应用文工坊：体裁列表 → 写作要求 + 结构骨架 + 推荐句式 + 高分范文 + 自评清单。
/// 每个体裁第 1 个场景免费预览，第 2 个场景付费解锁。
struct AppliedWritingWorkshopView: View {
    @ObservedObject private var purchase = PurchaseManager.shared
    @State private var showPaywall = false

    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.md) {
                Text("应用文得分靠'踩对结构+用对句式'。先按骨架搭框架，再用推荐句式填血肉。")
                    .font(AppFont.caption).foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ForEach(AppliedWritingData.all) { prompt in
                    row(prompt)
                }
            }
            .padding(Spacing.lg).readableWidth()
        }
        .background(Color.apexBackground.ignoresSafeArea())
        .navigationTitle("应用文工坊")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showPaywall) { PaywallView() }
    }

    @ViewBuilder private func row(_ prompt: AppliedWritingPrompt) -> some View {
        let locked = !prompt.isFree && !purchase.isUnlocked
        Group {
            if locked {
                Button { showPaywall = true } label: { rowLabel(prompt, locked: true) }
            } else {
                NavigationLink { AppliedWritingDetailView(prompt: prompt) } label: { rowLabel(prompt, locked: false) }
            }
        }.buttonStyle(.plain)
    }

    private func rowLabel(_ prompt: AppliedWritingPrompt, locked: Bool) -> some View {
        HStack(spacing: Spacing.md) {
            Image(systemName: locked ? "lock.fill" : "envelope.fill")
                .font(.title2).foregroundColor(locked ? .secondary : .apexGold)
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 6) {
                    Text(prompt.genre).font(AppFont.cardTitle)
                    TagChip(text: prompt.title, color: .apexStarBlue)
                }
                Text(prompt.scenario).font(AppFont.caption).foregroundColor(.secondary).lineLimit(2)
            }
            Spacer()
            Image(systemName: "chevron.right").font(.caption).foregroundColor(.secondary)
        }
        .cardSurface(padding: Spacing.md)
        .opacity(locked ? 0.6 : 1)
    }
}

struct AppliedWritingDetailView: View {
    let prompt: AppliedWritingPrompt
    @ObservedObject private var purchase = PurchaseManager.shared
    @State private var showEssay = false
    @State private var checked: Set<Int> = []
    @State private var showPaywall = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.lg) {
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    SectionHeader(title: "写作要求", systemImage: "text.book.closed", accent: .apexStarBlue)
                    Text(prompt.scenario).font(AppFont.body)
                }.cardSurface()

                VStack(alignment: .leading, spacing: Spacing.md) {
                    SectionHeader(title: "结构骨架", systemImage: "point.topleft.down.to.point.bottomright.curvepath", accent: .apexLava)
                    ForEach(Array(prompt.stages.enumerated()), id: \.element.id) { i, stage in
                        stageRow(index: i + 1, stage: stage)
                    }
                }.cardSurface()

                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Button { withAnimation { showEssay.toggle() } } label: {
                        HStack {
                            SectionHeader(title: "高分范文", systemImage: "doc.richtext", accent: .apexEmerald)
                            Image(systemName: showEssay ? "chevron.up" : "chevron.down").foregroundColor(.secondary)
                        }
                    }.buttonStyle(.plain)
                    if showEssay {
                        Text(prompt.modelEssay).font(AppFont.body).foregroundColor(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(Spacing.md).background(Color.apexBackground).cornerRadius(Radius.inner)
                    } else {
                        Text("先自己动笔写，再展开对照——效果最好。").font(AppFont.caption).foregroundColor(.secondary)
                    }
                }.cardSurface()

                VStack(alignment: .leading, spacing: Spacing.sm) {
                    SectionHeader(title: "自评清单", systemImage: "checklist", accent: .apexGold)
                    ForEach(Array(prompt.rubric.enumerated()), id: \.offset) { i, item in
                        Button { toggle(i) } label: {
                            HStack(alignment: .top, spacing: Spacing.sm) {
                                Image(systemName: checked.contains(i) ? "checkmark.square.fill" : "square")
                                    .foregroundColor(checked.contains(i) ? .apexEmerald : .secondary)
                                Text(item).font(AppFont.body).foregroundColor(.primary)
                                    .fixedSize(horizontal: false, vertical: true)
                                Spacer()
                            }
                        }.buttonStyle(.plain)
                    }
                    Text("\(checked.count)/\(prompt.rubric.count) 项达标").font(AppFont.caption)
                        .foregroundColor(checked.count == prompt.rubric.count ? .apexEmerald : .secondary)
                }.cardSurface()

                if purchase.isUnlocked {
                    WritingCoachView()
                } else {
                    writingCoachTeaser
                }
            }
            .padding(Spacing.lg).readableWidth()
        }
        .background(Color.apexBackground.ignoresSafeArea())
        .navigationTitle(prompt.title)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showPaywall) { PaywallView() }
    }

    private var writingCoachTeaser: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            SectionHeader(title: "写作教练 · 规则版", systemImage: "wand.and.stars", accent: .apexStarBlue)
            Text("解锁完整版即可用本地规则引擎为你自己的草稿挑语病、查套路——不联网、不是官方判分。")
                .font(AppFont.caption).foregroundColor(.secondary)
            Button { showPaywall = true } label: {
                Label("解锁写作教练", systemImage: "lock.open.fill").font(AppFont.cardTitle).foregroundColor(.white)
                    .frame(maxWidth: .infinity).padding(Spacing.md)
                    .background(Color.apexStarBlue).cornerRadius(Radius.inner)
            }
        }
        .cardSurface()
    }

    private func stageRow(index: Int, stage: WritingStage) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: Spacing.sm) {
                Text("\(index)").font(AppFont.chip).foregroundColor(.white)
                    .frame(width: 20, height: 20).background(Color.apexLava).clipShape(Circle())
                Text(stage.name).font(AppFont.cardTitle)
            }
            Text(stage.guidance).font(AppFont.caption).foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
            ForEach(stage.phrases) { card in
                HStack(alignment: .top, spacing: 4) {
                    Image(systemName: "quote.opening").font(.caption2).foregroundColor(.apexEmerald)
                    VStack(alignment: .leading, spacing: 1) {
                        Text(card.en).font(AppFont.caption).foregroundColor(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                        Text(card.zh).font(AppFont.chip).foregroundColor(.secondary)
                    }
                }
                .padding(.leading, Spacing.lg)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 4)
    }

    private func toggle(_ i: Int) {
        if checked.contains(i) { checked.remove(i) } else { checked.insert(i) }
    }
}
