import SwiftUI

/// 高频狙击：考点级的提分导航。狙击算法把"高频且你最弱"的考点排到最前。
struct HighFreqView: View {
    @EnvironmentObject var store: EngStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.lg) {
                algorithmBanner
                ForEach(Array(store.sniperHits.enumerated()), id: \.element.id) { idx, hit in
                    hitCard(rank: idx + 1, hit: hit)
                }
            }
            .padding(Spacing.lg)
            .readableWidth()
        }
        .background(Color.apexBackground.ignoresSafeArea())
        .navigationTitle("高频狙击")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var algorithmBanner: some View {
        VStack(alignment: .leading, spacing: 6) {
            Label("狙击算法", systemImage: "scope").font(AppFont.cardTitle).foregroundColor(.apexLava)
            Text("狙击优先级 = 高频权重 × (1 − 你的掌握度)")
                .font(AppFont.caption).foregroundColor(.primary)
            Text("高频且你最弱的考点永远排最前。做对关联题或点「已掌握」即可让它沉下去。")
                .font(AppFont.caption).foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardSurface(padding: Spacing.md)
    }

    private func hitCard(rank: Int, hit: SniperHit) -> some View {
        let p = hit.point
        let mastered = store.isPointMastered(p.id)
        return VStack(alignment: .leading, spacing: Spacing.sm) {
            HStack(spacing: Spacing.sm) {
                Text("\(rank)").font(AppFont.bigStat(20)).foregroundColor(.apexLava).frame(width: 26)
                VStack(alignment: .leading, spacing: 2) {
                    Text(p.name).font(AppFont.cardTitle)
                    HStack(spacing: 6) {
                        TagChip(text: p.module.title, color: .apexStarBlue)
                        priorityBadge(hit)
                    }
                }
                Spacer()
            }
            // 高频度条
            HStack(spacing: 6) {
                Text("高频度").font(AppFont.chip).foregroundColor(.secondary)
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule().fill(Color.secondary.opacity(0.15))
                        Capsule().fill(Color.apexLava).frame(width: geo.size.width * p.frequencyWeight)
                    }
                }.frame(height: 6)
                Text("\(Int(p.frequencyWeight * 100))%").font(AppFont.chip).foregroundColor(.secondary)
            }
            Text(p.digest).font(AppFont.body).fixedSize(horizontal: false, vertical: true)
            Text(p.example).font(AppFont.caption).foregroundColor(.secondary)
                .padding(Spacing.sm).frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.apexBackground).cornerRadius(Radius.chip)
            HStack {
                if let levelId = p.linkedLevelId, let level = MainLineData.level(id: levelId) {
                    NavigationLink { QuizView(level: level) } label: {
                        Label("去靶场强化", systemImage: "target").font(AppFont.chip).foregroundColor(.apexStarBlue)
                    }
                }
                Spacer()
                Button { store.togglePointMastered(p.id) } label: {
                    Label(mastered ? "已掌握" : "标记已掌握",
                          systemImage: mastered ? "checkmark.seal.fill" : "seal")
                        .font(AppFont.chip).foregroundColor(mastered ? .apexEmerald : .secondary)
                }
                .buttonStyle(.plain)
            }
        }
        .cardSurface(padding: Spacing.md)
        .opacity(mastered ? 0.6 : 1)
    }

    private func priorityBadge(_ hit: SniperHit) -> some View {
        let color: Color = hit.priorityLabel == "高" ? .apexDanger : (hit.priorityLabel == "中" ? .apexGold : .secondary)
        return Text("狙击优先级 \(hit.priorityLabel)").font(AppFont.chip)
            .padding(.horizontal, 8).padding(.vertical, 3)
            .background(color.opacity(0.15)).foregroundColor(color).clipShape(Capsule())
    }
}
