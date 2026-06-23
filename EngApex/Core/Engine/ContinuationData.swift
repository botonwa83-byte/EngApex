import Foundation

/// 读后续写工坊情境库。每个情境含情节链脚手架、关联句式、高分范文与自评 rubric。
enum ContinuationData {

    static let all: [ContinuationPrompt] = [rainstorm, sportsDay]

    static let sharedRubric = [
        "承接给定首句，时态与人称保持一致",
        "环境、动作、心理三类描写齐全，少直白多画面",
        "至少用 2 个高级句式或精准动词（见各阶段推荐）",
        "情节完整、积极向上，两段之间衔接自然",
        "无低级语法错误，每段篇幅适中（约 4-5 句）",
    ]

    // MARK: 情境一·暴雨夜归

    static let rainstorm = ContinuationPrompt(
        id: "cw_rain",
        title: "暴雨夜归",
        context: "Tom 从朋友家步行回家时遇上暴雨，手机也没电了，陌生的街道让他迷失了方向。",
        para1Lead: "Rain poured down as Tom stumbled along the muddy path.",
        para2Lead: "Just then, a flashlight beam cut through the darkness.",
        stages: [
            PlotStage(name: "起因·环境", guidance: "用风雨、泥泞、黑暗烘托困境，开篇即给画面。", phraseIds: ["p1", "p13"]),
            PlotStage(name: "发展·心理", guidance: "把恐惧化为身体反应（寒意、心跳），避免直白说 afraid。", phraseIds: ["p3", "p14"]),
            PlotStage(name: "转折·相遇", guidance: "用 Just then 推进当下，引入帮助者，制造转机。", phraseIds: ["p2"]),
            PlotStage(name: "高潮·互助", guidance: "以动作与语言细节刻画陌生人的善意。", phraseIds: ["p16", "p17"]),
            PlotStage(name: "结局·获救", guidance: "回到温暖与安全，呼应开头的寒冷与黑暗。", phraseIds: []),
            PlotStage(name: "升华·感悟", guidance: "由获救升华到对善意与成长的领悟，点题收束。", phraseIds: ["p20"]),
        ],
        modelEssay: rainEssay,
        rubric: sharedRubric
    )

    private static let rainEssay: String = {
        let p1 = "Rain poured down as Tom stumbled along the muddy path. His clothes were soaked through, and a chill ran down his spine. "
            + "He had no idea how far he still had to go. Every shadow seemed to hide some unknown danger, and his heart pounded against his chest. "
            + "\"Stay calm,\" he told himself, though his voice trembled. He pressed on, one careful step after another, refusing to give in to panic."
        let p2 = "Just then, a flashlight beam cut through the darkness. An old man in a raincoat hurried toward him, holding a large umbrella. "
            + "\"You must be freezing, young man,\" he said warmly, leading Tom to his nearby cottage. Inside, a fire crackled, and a cup of hot tea soon warmed Tom's hands. "
            + "As he looked at the kind stranger, a wave of gratitude washed over him. He finally understood that even on the darkest night, kindness could light the way home."
        return p1 + "\n\n" + p2
    }()

    // MARK: 情境二·赛场坚持

    static let sportsDay = ContinuationPrompt(
        id: "cw_sports",
        title: "赛场坚持",
        context: "Lily 是班上跑得最慢的学生。运动会上，她报名了 800 米，下定决心无论如何都要跑完。",
        para1Lead: "As the starting gun fired, Lily fell behind almost at once.",
        para2Lead: "With only one lap to go, her legs felt like lead.",
        stages: [
            PlotStage(name: "起因·落后", guidance: "开篇点明劣势，用对比制造张力。", phraseIds: ["p15"]),
            PlotStage(name: "发展·挣扎", guidance: "身体疲惫加内心动摇，再以决心扭转。", phraseIds: ["p3", "p18"]),
            PlotStage(name: "转折·鼓励", guidance: "用呐喊或对话带来转机，推动情节。", phraseIds: ["p2", "p14"]),
            PlotStage(name: "高潮·冲刺", guidance: "连续强动词写冲刺，群体反应烘托高潮。", phraseIds: ["p17", "p19"]),
            PlotStage(name: "结局·完成", guidance: "完成比赛，结果不完美但有意义。", phraseIds: []),
            PlotStage(name: "升华·意义", guidance: "由‘最后一名却像赢家’升华坚持的意义。", phraseIds: ["p20"]),
        ],
        modelEssay: sportsEssay,
        rubric: sharedRubric
    )

    private static let sportsEssay: String = {
        let p1 = "As the starting gun fired, Lily fell behind almost at once. The other runners shot ahead like arrows, while her legs felt heavy and slow. "
            + "Whispers and giggles rose from the crowd, and tears stung her eyes. For a moment, she wanted to stop. But then she remembered her promise to herself: "
            + "to finish, no matter what. Taking a deep breath, she fixed her eyes on the track and pushed forward, one determined stride at a time."
        let p2 = "With only one lap to go, her legs felt like lead. Just then, a familiar voice rang out from the stands. \"You can do it, Lily!\" Her classmates were on their feet, cheering her name. "
            + "A spark of strength suddenly lit up inside her. She gritted her teeth and sprinted toward the finish line, her heart pounding wildly. "
            + "As she crossed it at last, the whole crowd burst into cheers. She had come in last, yet in that moment she felt like a true winner."
        return p1 + "\n\n" + p2
    }()

    static func find(_ id: String) -> ContinuationPrompt? { all.first { $0.id == id } }
}
