import SwiftUI

// MARK: - 配色（移植自 PhysicsApex，apex* 语义保持一致）
// stage* 为段位色：初中 / 高中 / 竞赛。

extension Color {
    // MARK: 自适应底色
    static let apexBackground = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark ? UIColor(hex6: 0x1C1C1E) : UIColor(hex6: 0xF5F0EB)
    })
    static let apexCardSurface = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark ? UIColor(hex6: 0x2C2C2E) : UIColor(hex6: 0xFFFFFF)
    })
    static let mysteryBackground = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark ? UIColor(hex6: 0x1E1A2E) : UIColor(hex6: 0xF3EEFF)
    })
    static let mysteryPaper = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark ? UIColor(hex6: 0x2A2520) : UIColor(hex6: 0xFFF8E1)
    })

    // MARK: 强调色
    static let apexLava = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark ? UIColor(hex6: 0xFF8A65) : UIColor(hex6: 0xFF7043)
    })
    static let apexEmerald = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark ? UIColor(hex6: 0x4DB6AC) : UIColor(hex6: 0x26A69A)
    })
    static let apexStarBlue = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark ? UIColor(hex6: 0x64B5F6) : UIColor(hex6: 0x42A5F5)
    })
    static let apexDanger = Color(UIColor { _ in UIColor(hex6: 0xEF5350) })
    static let apexMystery = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark ? UIColor(hex6: 0x9575CD) : UIColor(hex6: 0x7E57C2)
    })
    static let apexGold = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark ? UIColor(hex6: 0xFFB74D) : UIColor(hex6: 0xFFA726)
    })

    // MARK: 段位色
    /// 初中
    static let stageJunior = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark ? UIColor(hex6: 0x81C784) : UIColor(hex6: 0x66BB6A)
    })
    /// 高中（主战场）
    static let stageSenior = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark ? UIColor(hex6: 0xFF8A65) : UIColor(hex6: 0xFF7043)
    })
    /// 竞赛（天花板）
    static let stageOlympiad = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark ? UIColor(hex6: 0x9575CD) : UIColor(hex6: 0x7E57C2)
    })

    // MARK: 元素类别色（元素星图）
    static let elementMetal = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark ? UIColor(hex6: 0x64B5F6) : UIColor(hex6: 0x42A5F5)
    })
    static let elementTransition = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark ? UIColor(hex6: 0xFFB74D) : UIColor(hex6: 0xFFA726)
    })
    static let elementNonmetal = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark ? UIColor(hex6: 0x4DB6AC) : UIColor(hex6: 0x26A69A)
    })
    static let elementNoble = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark ? UIColor(hex6: 0x9575CD) : UIColor(hex6: 0x7E57C2)
    })
}

extension UIColor {
    convenience init(hex6: UInt32) {
        self.init(
            red:   CGFloat((hex6 >> 16) & 0xFF) / 255,
            green: CGFloat((hex6 >> 8)  & 0xFF) / 255,
            blue:  CGFloat( hex6        & 0xFF) / 255,
            alpha: 1
        )
    }
}

// MARK: - 外观偏好

enum AppearancePreference: String, CaseIterable, Identifiable {
    case system, light, dark
    var id: String { rawValue }
    var label: String {
        switch self {
        case .system: return "跟随系统"
        case .light:  return "浅色"
        case .dark:   return "深色"
        }
    }
    var icon: String {
        switch self {
        case .system: return "circle.lefthalf.filled"
        case .light:  return "sun.max.fill"
        case .dark:   return "moon.fill"
        }
    }
    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light:  return .light
        case .dark:   return .dark
        }
    }
}

final class AppearanceManager: ObservableObject {
    static let shared = AppearanceManager()
    private let storageKey = "appearance_preference"
    @Published var preference: AppearancePreference {
        didSet { UserDefaults.standard.set(preference.rawValue, forKey: storageKey) }
    }
    var colorScheme: ColorScheme? { preference.colorScheme }
    private init() {
        let raw = UserDefaults.standard.string(forKey: storageKey) ?? ""
        preference = AppearancePreference(rawValue: raw) ?? .system
    }
}
