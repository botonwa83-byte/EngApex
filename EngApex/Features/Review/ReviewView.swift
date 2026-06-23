import SwiftUI

/// 智能复习：按 SM-2 调度，复习到期的错题与句式卡。
struct ReviewView: View {
    @ObservedObject private var scheduler = ReviewScheduler.shared
    @State private var queue: [String] = []
    @State private var revealed = false

    var body: some View {
        Group {
            if queue.isEmpty {
                ContentUnavailableViewCompat(
                    title: "今日复习已清空",
                    systemImage: "checkmark.circle",
                    description: "答错的题与你加入的句式会按遗忘曲线在这里到期，明天再来。")
            } else if let id = queue.first, let ref = ReviewRef.resolve(id) {
                card(id: id, ref: ref)
            } else {
                Color.clear.onAppear { advance(removeFirst: true) }
            }
        }
        .navigationTitle("智能复习")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { if queue.isEmpty { queue = scheduler.dueIDs() } }
    }

    private func card(id: String, ref: ReviewRef) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.lg) {
                HStack {
                    TagChip(text: kindLabel(ref), color: .apexMystery)
                    Spacer()
                    Text("剩 \(queue.count)").font(AppFont.caption).foregroundColor(.secondary)
                }
                front(ref)
                if revealed {
                    Divider()
                    back(ref)
                    gradeButtons(id: id)
                } else {
                    Button { withAnimation { revealed = true } } label: {
                        Text("显示答案").font(AppFont.cardTitle).foregroundColor(.white)
                            .frame(maxWidth: .infinity).padding(Spacing.md)
                            .background(Color.apexStarBlue).cornerRadius(Radius.inner)
                    }
                }
            }
            .padding(Spacing.lg)
            .readableWidth()
        }
        .background(Color.apexBackground.ignoresSafeArea())
    }

    @ViewBuilder private func front(_ ref: ReviewRef) -> some View {
        switch ref {
        case .question(let q):
            Text(q.stem).font(.body).fixedSize(horizontal: false, vertical: true)
        case .phrase(let p):
            Text(p.en).font(.title3.weight(.semibold)).fixedSize(horizontal: false, vertical: true)
        }
    }

    @ViewBuilder private func back(_ ref: ReviewRef) -> some View {
        switch ref {
        case .question(let q):
            VStack(alignment: .leading, spacing: Spacing.sm) {
                Label("正确答案：\(q.options[q.answer])", systemImage: "checkmark.circle.fill")
                    .foregroundColor(.apexEmerald).font(AppFont.cardTitle)
                ForEach(Array(q.strategy.enumerated()), id: \.offset) { i, s in
                    Text("\(i + 1). \(s)").font(AppFont.body).foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        case .phrase(let p):
            VStack(alignment: .leading, spacing: 6) {
                Text(p.zh).font(.body)
                Text(p.usage).font(AppFont.caption).foregroundColor(.secondary)
            }
        }
    }

    private func gradeButtons(id: String) -> some View {
        HStack(spacing: Spacing.sm) {
            gradeBtn("重来", .apexDanger, id: id, q: 1)
            gradeBtn("困难", .apexGold, id: id, q: 3)
            gradeBtn("良好", .apexStarBlue, id: id, q: 4)
            gradeBtn("简单", .apexEmerald, id: id, q: 5)
        }
        .padding(.top, Spacing.sm)
    }

    private func gradeBtn(_ title: String, _ color: Color, id: String, q: Int) -> some View {
        Button {
            scheduler.grade(id, quality: q)
            advance(removeFirst: true)
        } label: {
            Text(title).font(AppFont.chip).foregroundColor(.white)
                .frame(maxWidth: .infinity).padding(.vertical, Spacing.md)
                .background(color).cornerRadius(Radius.chip)
        }
    }

    private func advance(removeFirst: Bool) {
        revealed = false
        if removeFirst, !queue.isEmpty { queue.removeFirst() }
    }

    private func kindLabel(_ ref: ReviewRef) -> String {
        switch ref { case .question: return "错题复习"; case .phrase: return "句式复习" }
    }
}
