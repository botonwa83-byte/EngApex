import SwiftUI

// MARK: - 启动广告页：品牌 → 卖点 → 数据 → 开发者 → 版权 → 进入
// 设计参考 Apex 家族 PromoView。每次启动先展示，点击进入主界面。

struct PromoView: View {
    var onEnter: () -> Void

    @State private var appeared = false
    @State private var glow = false

    private let features: [(icon: String, color: Color, title: String, desc: String)] = [
        ("scope", .apexLava, "提分雷达 · 性价比导航", "算法算出你下一个 +5 分在哪，永远把最划算的提分点排在最前"),
        ("gauge.with.dots.needle.67percent", .apexStarBlue, "估分器", "把做题数据折算成高考英语估分 + 置信区间，提分看得见"),
        ("arrow.triangle.branch", .apexMystery, "错因诊断树", "每道错题定位根因：词汇 / 语法 / 套路 / 粗心，对症下药"),
        ("text.quote", .apexEmerald, "句式 / 词块库", "读后续写与应用文的高分弹药，开头句、加分句式即取即用"),
        ("checklist", .apexGold, "题型决策树", "完形/阅读/七选五/语法填空，每题都教你‘怎么想’而非只给答案"),
    ]

    private var bg: some View {
        LinearGradient(colors: [Color(UIColor(hex6: 0x0A1018)),
                                Color(UIColor(hex6: 0x102030)),
                                Color(UIColor(hex6: 0x0A1018))],
                       startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }

    var body: some View {
        ZStack {
            bg
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    VStack(spacing: 14) {
                        ZStack {
                            Circle()
                                .fill(LinearGradient(colors: [.apexStarBlue, .apexEmerald], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: 96, height: 96)
                                .shadow(color: Color.apexStarBlue.opacity(glow ? 0.7 : 0.3), radius: glow ? 26 : 12)
                            Image(systemName: "graduationcap.fill").font(.system(size: 42, weight: .bold)).foregroundColor(.white)
                        }
                        Text("ENG APEX")
                            .font(.system(size: 30, weight: .heavy, design: .rounded)).tracking(2)
                            .foregroundStyle(LinearGradient(colors: [.apexStarBlue, .apexEmerald], startPoint: .leading, endPoint: .trailing))
                        Text("英 语 登 顶 · 提 分 导 航")
                            .font(.system(size: 14, weight: .medium)).tracking(2).foregroundColor(.white.opacity(0.6))
                    }
                    .padding(.top, 48)

                    VStack(spacing: 10) {
                        Text("不只是刷题——它算得出你下一个 +5 分在哪")
                            .font(.system(size: 18, weight: .bold)).multilineTextAlignment(.center).foregroundColor(.white)
                        Text("把高考英语 150 分拆开建模，用算法导航\n按提分性价比，带你用最短路径冲高分")
                            .font(.system(size: 13)).multilineTextAlignment(.center).foregroundColor(.white.opacity(0.6)).lineSpacing(4)
                    }
                    .padding(.top, 28).padding(.horizontal, 24)

                    VStack(spacing: 12) {
                        ForEach(Array(features.enumerated()), id: \.offset) { _, f in
                            HStack(spacing: 14) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12).fill(f.color.opacity(0.20)).frame(width: 46, height: 46)
                                    Image(systemName: f.icon).font(.system(size: 20, weight: .semibold)).foregroundColor(f.color)
                                }
                                VStack(alignment: .leading, spacing: 3) {
                                    Text(f.title).font(.system(size: 16, weight: .bold)).foregroundColor(.white)
                                    Text(f.desc).font(.system(size: 13)).foregroundColor(.white.opacity(0.65)).lineSpacing(2).fixedSize(horizontal: false, vertical: true)
                                }
                                Spacer(minLength: 0)
                            }
                            .padding(14)
                            .background(RoundedRectangle(cornerRadius: 16).fill(Color.white.opacity(0.06)))
                        }
                    }
                    .padding(.top, 28).padding(.horizontal, 24)

                    HStack(spacing: 0) {
                        stat("\(MainLineData.levels.count)", "提分关卡")
                        statDivider
                        stat("\(QuestionBank.all.count)", "决策树题")
                        statDivider
                        stat("\(PhraseBook.all.count)", "高分句式")
                    }
                    .padding(.vertical, 18).padding(.horizontal, 24)
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.white.opacity(0.05)))
                    .padding(.top, 24).padding(.horizontal, 24)

                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 12) {
                            ZStack {
                                Circle().fill(LinearGradient(colors: [.apexStarBlue, .apexEmerald], startPoint: .top, endPoint: .bottom)).frame(width: 44, height: 44)
                                Text("K").font(.system(size: 22, weight: .heavy)).foregroundColor(.white)
                            }
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Top King").font(.system(size: 16, weight: .bold)).foregroundColor(.white)
                                Text("独立开发者 / 教育科技探索者").font(.system(size: 12)).foregroundColor(.white.opacity(0.6))
                            }
                            Spacer()
                        }
                        Text("专注教育类 App，用科技让学习更高效。EngApex 把‘老师的提分直觉’做成算法——估分、雷达、错因诊断，让每一分钟都投在最该提分的地方。")
                            .font(.system(size: 13)).foregroundColor(.white.opacity(0.65)).lineSpacing(3)
                    }
                    .padding(16)
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.white.opacity(0.06)))
                    .padding(.top, 24).padding(.horizontal, 24)

                    VStack(spacing: 4) {
                        Text("EngApex · 英语登顶  v1.0.0").font(.system(size: 12)).foregroundColor(.white.opacity(0.5))
                        Text("© 2026 Top King. All rights reserved.").font(.system(size: 11)).foregroundColor(.white.opacity(0.35))
                    }
                    .padding(.top, 22).padding(.bottom, 120)
                }
                .frame(maxWidth: 600).frame(maxWidth: .infinity)
                .opacity(appeared ? 1 : 0).offset(y: appeared ? 0 : 24)
            }

            VStack {
                Spacer()
                Button(action: onEnter) {
                    HStack(spacing: 8) {
                        Text("开 启 英 语 登 顶 之 旅").fontWeight(.bold).tracking(1)
                        Image(systemName: "arrow.right")
                    }
                    .font(.system(size: 17, weight: .bold)).foregroundColor(.white)
                    .frame(maxWidth: .infinity).padding(.vertical, 16)
                    .background(LinearGradient(colors: [.apexStarBlue, .apexEmerald], startPoint: .leading, endPoint: .trailing),
                                in: RoundedRectangle(cornerRadius: 16))
                    .shadow(color: Color.apexStarBlue.opacity(0.45), radius: 14, y: 4)
                }
                .frame(maxWidth: 600 - 48).padding(.horizontal, 24).padding(.bottom, 20)
                .background(
                    LinearGradient(colors: [Color(UIColor(hex6: 0x0A1018)).opacity(0), Color(UIColor(hex6: 0x0A1018))], startPoint: .top, endPoint: .bottom)
                        .frame(height: 120).allowsHitTesting(false), alignment: .bottom
                )
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.7)) { appeared = true }
            withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) { glow = true }
        }
    }

    private func stat(_ n: String, _ label: String) -> some View {
        VStack(spacing: 4) {
            Text(n).font(.system(size: 24, weight: .heavy, design: .rounded)).foregroundColor(.apexEmerald)
            Text(label).font(.system(size: 12)).foregroundColor(.white.opacity(0.6))
        }
        .frame(maxWidth: .infinity)
    }

    private var statDivider: some View {
        Rectangle().fill(Color.white.opacity(0.2)).frame(width: 1, height: 30)
    }
}
