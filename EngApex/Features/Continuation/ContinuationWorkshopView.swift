import SwiftUI

/// 读后续写工坊：情境列表 → 情节链脚手架 + 推荐句式 + 高分范文 + 自评清单。
struct ContinuationWorkshopView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.md) {
                Text("读后续写 25 分，靠的是‘有套路的想象力’。先用情节链搭骨架，再用高分句式填血肉。")
                    .font(AppFont.caption).foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ForEach(ContinuationData.all) { prompt in
                    NavigationLink { WorkshopDetailView(prompt: prompt) } label: {
                        HStack(spacing: Spacing.md) {
                            Image(systemName: "pencil.and.scribble").font(.title2).foregroundColor(.apexMystery)
                            VStack(alignment: .leading, spacing: 2) {
                                Text(prompt.title).font(AppFont.cardTitle)
                                Text(prompt.context).font(AppFont.caption).foregroundColor(.secondary).lineLimit(2)
                            }
                            Spacer()
                            Image(systemName: "chevron.right").font(.caption).foregroundColor(.secondary)
                        }
                        .cardSurface(padding: Spacing.md)
                    }.buttonStyle(.plain)
                }
            }
            .padding(Spacing.lg).readableWidth()
        }
        .background(Color.apexBackground.ignoresSafeArea())
        .navigationTitle("读后续写工坊")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct WorkshopDetailView: View {
    let prompt: ContinuationPrompt
    @State private var showEssay = false
    @State private var checked: Set<Int> = []

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.lg) {
                // 情境 + 给定首句
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    SectionHeader(title: "情境", systemImage: "text.book.closed", accent: .apexStarBlue)
                    Text(prompt.context).font(AppFont.body)
                    leadBox("第 1 段首句", prompt.para1Lead)
                    leadBox("第 2 段首句", prompt.para2Lead)
                }.cardSurface()

                // 情节链脚手架
                VStack(alignment: .leading, spacing: Spacing.md) {
                    SectionHeader(title: "情节链脚手架", systemImage: "point.topleft.down.to.point.bottomright.curvepath", accent: .apexLava)
                    ForEach(Array(prompt.stages.enumerated()), id: \.element.id) { i, stage in
                        stageRow(index: i + 1, stage: stage)
                    }
                }.cardSurface()

                // 高分范文（默认折叠，先想后看）
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

                // 自评清单（诚信：不做机器打分，自评对照）
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
            }
            .padding(Spacing.lg).readableWidth()
        }
        .background(Color.apexBackground.ignoresSafeArea())
        .navigationTitle(prompt.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func leadBox(_ label: String, _ text: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label).font(AppFont.chip).foregroundColor(.apexStarBlue)
            Text(text).font(AppFont.body).italic().fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Spacing.sm).background(Color.apexBackground).cornerRadius(Radius.chip)
    }

    private func stageRow(index: Int, stage: PlotStage) -> some View {
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
