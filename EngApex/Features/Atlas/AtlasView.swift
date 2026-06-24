import SwiftUI

/// 考点图谱（图鉴 Tab）：上半部七模块考点地图（随做题点亮），下半部句式/词块库。
struct AtlasView: View {
    @EnvironmentObject var store: EngStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Spacing.xl) {
                    moduleMap
                    phraseLibrary
                }
                .padding(Spacing.lg)
                .readableWidth()
            }
            .background(Color.apexBackground.ignoresSafeArea())
            .navigationTitle("考点图谱")
        }
    }

    // MARK: 模块考点地图

    private var moduleMap: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            SectionHeader(title: "七模块考点地图", systemImage: "map.fill", accent: .apexStarBlue)
            Text("做对题点亮模块——颜色越亮，掌握越好。").font(AppFont.caption).foregroundColor(.secondary)
            let cols = [GridItem(.adaptive(minimum: 100), spacing: Spacing.md)]
            LazyVGrid(columns: cols, spacing: Spacing.md) {
                ForEach(store.estimates) { est in
                    VStack(spacing: 6) {
                        Image(systemName: est.module.icon)
                            .font(.title2)
                            .foregroundColor(est.confidence < 0.15 ? .secondary : .apexStarBlue)
                        Text(est.module.title).font(AppFont.chip).foregroundColor(.primary)
                        Text("\(Int(est.scoreRatio * 100))%").font(AppFont.caption)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity).padding(Spacing.md)
                    .background(Color.apexStarBlue.opacity(0.06 + 0.18 * est.scoreRatio))
                    .cornerRadius(Radius.inner)
                }
            }
        }
        .cardSurface()
    }

    // MARK: 句式 / 词块库

    private var phraseLibrary: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            SectionHeader(title: "句式 / 词块库", systemImage: "text.quote", accent: .apexEmerald)
            ForEach(PhraseCategory.allCases) { cat in
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    TagChip(text: cat.title, color: cat.color)
                    ForEach(PhraseBook.cards(in: cat)) { card in
                        HStack(alignment: .top, spacing: Spacing.sm) {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(card.en).font(AppFont.body).foregroundColor(.primary)
                                    .fixedSize(horizontal: false, vertical: true)
                                Text(card.zh).font(AppFont.caption).foregroundColor(.secondary)
                                Text(card.usage).font(AppFont.chip).foregroundColor(cat.color)
                            }
                            Spacer(minLength: 0)
                            ReviewToggleButton(id: "p:\(card.id)")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(Spacing.sm)
                        .background(Color.apexBackground).cornerRadius(Radius.chip)
                    }
                }
            }
        }
        .cardSurface()
    }
}

/// "加入复习"按钮：加入 SM-2 复习库后变为已加入态。句式卡/词汇卡通用，按各自的 id 前缀区分。
struct ReviewToggleButton: View {
    let id: String
    @ObservedObject private var scheduler = ReviewScheduler.shared
    var body: some View {
        let added = scheduler.contains(id)
        Button { scheduler.addIfAbsent(id) } label: {
            Image(systemName: added ? "checkmark.circle.fill" : "plus.circle")
                .foregroundColor(added ? .apexEmerald : .apexStarBlue)
        }
        .buttonStyle(.plain)
        .disabled(added)
    }
}
