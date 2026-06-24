import SwiftUI

/// 写作教练(规则版)：贴自己的草稿进来，本地规则引擎给出语病/套路提示。
/// 读后续写工坊与应用文工坊共用——非官方判分，仅供参考，明确标注以守诚信红线。
struct WritingCoachView: View {
    /// 读后续写需要承接的给定首句；不需要此项检查时传空数组。
    var requiredLeads: [String] = []

    @State private var draft = ""
    @State private var findings: [WritingCoachEngine.Finding] = []
    @State private var checked = false

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            SectionHeader(title: "写作教练 · 规则版", systemImage: "wand.and.stars", accent: .apexStarBlue)
            Text("把你自己写的草稿粘贴或写在这里，本地规则引擎会做语病/套路自查——不联网、不是官方判分，仅供参考。")
                .font(AppFont.caption).foregroundColor(.secondary)
            TextEditor(text: $draft)
                .frame(height: 160)
                .padding(4)
                .background(Color.apexBackground)
                .cornerRadius(Radius.inner)
            Button {
                findings = WritingCoachEngine.diagnose(draft, requiredLeads: requiredLeads)
                checked = true
            } label: {
                Text("诊断我的写作").font(AppFont.cardTitle).foregroundColor(.white)
                    .frame(maxWidth: .infinity).padding(Spacing.md)
                    .background(draft.trimmingCharacters(in: .whitespaces).isEmpty ? Color.secondary : Color.apexStarBlue)
                    .cornerRadius(Radius.inner)
            }
            .disabled(draft.trimmingCharacters(in: .whitespaces).isEmpty)

            if checked {
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    if findings.isEmpty {
                        Text("规则引擎暂无提示。").font(AppFont.caption).foregroundColor(.secondary)
                    } else {
                        ForEach(Array(findings.enumerated()), id: \.offset) { _, f in
                            findingRow(f)
                        }
                    }
                }
                .padding(.top, Spacing.sm)
            }
        }
        .cardSurface()
    }

    private func findingRow(_ f: WritingCoachEngine.Finding) -> some View {
        HStack(alignment: .top, spacing: 6) {
            Image(systemName: icon(f.severity)).foregroundColor(color(f.severity))
            Text(f.message).font(AppFont.body).fixedSize(horizontal: false, vertical: true)
        }
    }

    private func icon(_ s: WritingCoachEngine.Severity) -> String {
        switch s {
        case .good:    return "checkmark.circle.fill"
        case .tip:     return "lightbulb.fill"
        case .warning: return "exclamationmark.triangle.fill"
        }
    }

    private func color(_ s: WritingCoachEngine.Severity) -> Color {
        switch s {
        case .good:    return .apexEmerald
        case .tip:     return .apexGold
        case .warning: return .apexDanger
        }
    }
}
