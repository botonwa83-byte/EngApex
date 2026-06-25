import SwiftUI

@main
struct EngApexApp: App {
    @StateObject private var store = EngStore.shared
    @StateObject private var purchase = PurchaseManager.shared
    @StateObject private var appearance = AppearanceManager.shared

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(store)
                .environmentObject(purchase)
                .preferredColorScheme(appearance.colorScheme)
        }
    }
}

/// 启动先展示广告页，点击进入主界面。
/// 启动参数（截图/UI 自动化用）：-skipPromo 或任意 -demo* 跳过广告页直达主界面。
struct RootView: View {
    @State private var passedPromo: Bool = {
        let args = ProcessInfo.processInfo.arguments
        return args.contains("-skipPromo") || args.contains { $0.hasPrefix("-demo") }
    }()

    var body: some View {
        ZStack {
            if passedPromo {
                MainTabView().transition(.opacity)
            } else {
                PromoView { withAnimation(.easeInOut(duration: 0.4)) { passedPromo = true } }
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.4), value: passedPromo)
    }
}

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var demoPaywall = ProcessInfo.processInfo.arguments.contains("-demoPaywall")
    @State private var demoQuiz = ProcessInfo.processInfo.arguments.contains("-demoQuiz")
    @State private var demoSniper = ProcessInfo.processInfo.arguments.contains("-demoSniper")
    @State private var demoMock = ProcessInfo.processInfo.arguments.contains("-demoMock")
    @State private var demoAtlas = ProcessInfo.processInfo.arguments.contains("-demoAtlas")
    @State private var demoWorkshop = ProcessInfo.processInfo.arguments.contains("-demoWorkshop")
    @State private var demoListening = ProcessInfo.processInfo.arguments.contains("-demoListening")
    @State private var demoApplied = ProcessInfo.processInfo.arguments.contains("-demoApplied")
    @State private var demoVocab = ProcessInfo.processInfo.arguments.contains("-demoVocab")

    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView()
                .tabItem { Label("提分驾驶舱", systemImage: "gauge.with.dots.needle.67percent") }
                .tag(0)
            TargetsView()
                .tabItem { Label("题型靶场", systemImage: "target") }
                .tag(1)
            AtlasView()
                .tabItem { Label("素材库", systemImage: "books.vertical") }
                .tag(2)
            MoreView()
                .tabItem { Label("更多", systemImage: "ellipsis.circle") }
                .tag(3)
        }
        .tint(.apexStarBlue)
        .sheet(isPresented: $demoPaywall) { PaywallView() }
        .fullScreenCover(isPresented: $demoQuiz) {
            if let level = MainLineData.levels.first {
                NavigationStack { QuizView(level: level) }
            }
        }
        .fullScreenCover(isPresented: $demoSniper) {
            NavigationStack { HighFreqView() }
        }
        .fullScreenCover(isPresented: $demoMock) {
            NavigationStack { MockExamView() }
        }
        .fullScreenCover(isPresented: $demoAtlas) {
            NavigationStack { AtlasView() }
        }
        .fullScreenCover(isPresented: $demoWorkshop) {
            NavigationStack { ContinuationWorkshopView() }
        }
        .fullScreenCover(isPresented: $demoListening) {
            if let level = MainLineData.level(for: .listening) {
                NavigationStack { QuizView(level: level) }
            }
        }
        .fullScreenCover(isPresented: $demoApplied) {
            NavigationStack { AppliedWritingWorkshopView() }
        }
        .fullScreenCover(isPresented: $demoVocab) {
            NavigationStack { VocabView() }
        }
    }
}
