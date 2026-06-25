import SwiftUI

/// 语言素材库（图鉴 Tab）：静态知识统一索引——词汇 + 句式/词块库，与"提分驾驶舱"(算法日计划)、
/// "题型靶场"(限时刷题)、两个写作工坊(长文写作+教练)各自分工，不再重复模块掌握度展示。
struct AtlasView: View {
    @ObservedObject private var vocabStore = VocabStore.shared

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Spacing.xl) {
                    vocabLibrary
                    phraseLibrary
                }
                .padding(Spacing.lg)
                .readableWidth()
            }
            .background(Color.apexBackground.ignoresSafeArea())
            .navigationTitle("语言素材库")
        }
    }

    // MARK: 词汇

    private var vocabLibrary: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            SectionHeader(title: "词汇", systemImage: "character.book.closed", accent: .apexLava)
            Text("拼写 / 搭配辨析 / 熟词僻义三种练法；高频且你最弱的词永远排最前。").font(AppFont.caption).foregroundColor(.secondary)
            ForEach(Array(vocabStore.priorityList(VocabData.all).enumerated()), id: \.element.word.id) { idx, entry in
                NavigationLink { VocabDetailView(word: entry.word) } label: {
                    vocabRow(rank: idx + 1, word: entry.word)
                }.buttonStyle(.plain)
            }
        }
        .cardSurface()
    }

    private func vocabRow(rank: Int, word: VocabWord) -> some View {
        let mastered = vocabStore.isMastered(word.id)
        return HStack(spacing: Spacing.md) {
            Text("\(rank)").font(AppFont.bigStat(20)).foregroundColor(.apexLava).frame(width: 26)
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 6) {
                    Text(word.headword).font(AppFont.cardTitle)
                    TagChip(text: word.category.title, color: word.category == .collocation ? .apexStarBlue : .apexMystery)
                }
                Text(word.meaning).font(AppFont.caption).foregroundColor(.secondary).lineLimit(1)
            }
            Spacer()
            if mastered { Image(systemName: "checkmark.seal.fill").foregroundColor(.apexEmerald) }
            Image(systemName: "chevron.right").font(.caption).foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Spacing.sm)
        .background(Color.apexBackground).cornerRadius(Radius.chip)
        .opacity(mastered ? 0.6 : 1)
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
