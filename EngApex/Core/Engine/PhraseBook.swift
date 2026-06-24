import Foundation

/// 句式 / 词块库（图鉴 Tab）。读后续写与应用文的高分弹药，可加入复习。
enum PhraseBook {

    static let all: [PhraseCard] = base + extended

    static let base: [PhraseCard] = [
        // 读后续写·开头/画面
        PhraseCard(id: "p1", category: .continuationOpener,
            en: "Rain poured down as he stumbled along the muddy path.",
            zh: "雨倾盆而下，他踉跄地走在泥泞的小路上。",
            usage: "as 引导伴随动作，开篇即给画面与张力。"),
        PhraseCard(id: "p2", category: .continuationOpener,
            en: "Just then, a flashlight beam cut through the darkness.",
            zh: "就在那时，一道手电光划破黑暗。",
            usage: "Just then 推进当下情节，制造转机。"),
        PhraseCard(id: "p3", category: .continuationOpener,
            en: "A chill ran down his spine as the shadows closed in.",
            zh: "阴影逼近，一阵寒意顺着脊背蔓延。",
            usage: "化‘害怕’为身体反应，远胜直白的 afraid。"),
        // 高级动词替换
        PhraseCard(id: "p4", category: .advancedVerb,
            en: "improve / enhance（替换 make better）",
            zh: "提升、增强",
            usage: "improve our spoken English 比 make English better 更精准地道。"),
        PhraseCard(id: "p5", category: .advancedVerb,
            en: "tackle / address（替换 deal with）",
            zh: "解决、应对",
            usage: "tackle the problem 显书面、显功底。"),
        PhraseCard(id: "p6", category: .advancedVerb,
            en: "gaze / glance（替换 look）",
            zh: "凝视 / 瞥",
            usage: "续写描写视线时，精准动词更有画面感。"),
        // 加分句式
        PhraseCard(id: "p7", category: .sentencePattern,
            en: "Not only did she finish early, but she also helped others.",
            zh: "她不仅提前完成，还帮助了他人。",
            usage: "not only…but also 倒装，议论/记叙皆可加分。"),
        PhraseCard(id: "p8", category: .sentencePattern,
            en: "It was not until that moment that he understood.",
            zh: "直到那一刻他才明白。",
            usage: "not until 强调句，升级时间表达。"),
        PhraseCard(id: "p9", category: .sentencePattern,
            en: "However hard he tried, he never gave up.",
            zh: "无论多努力，他从不放弃。",
            usage: "However + adj/adv 让步状语，凸显人物品质。"),
        // 应用文模板句
        PhraseCard(id: "p10", category: .applied,
            en: "I'm writing to invite you to…",
            zh: "我写信是想邀请你参加……",
            usage: "邀请类应用文标准开头框架。"),
        PhraseCard(id: "p11", category: .applied,
            en: "I would appreciate it if you could…",
            zh: "如果你能……我将不胜感激。",
            usage: "含虚拟语气的礼貌结尾，语域正式、加分稳。"),
        PhraseCard(id: "p12", category: .applied,
            en: "Looking forward to your early reply.",
            zh: "期待你的尽早回复。",
            usage: "书信结尾固定礼貌句，规范得体。"),
    ]

    /// 二期扩充（12 → 30 张，新增熟词僻义档案）；三期补充应用文分体裁开头句（30 → 36 张）。
    static let extended: [PhraseCard] = extendedA + extendedB + extendedC

    static let extendedA: [PhraseCard] = [
        // 续写开头/画面
        PhraseCard(id: "p13", category: .continuationOpener,
            en: "The first rays of dawn crept over the silent hills.",
            zh: "第一缕晨光悄悄爬上寂静的山峦。",
            usage: "用拟人化动词 crept 写景，开篇即有画面。"),
        PhraseCard(id: "p14", category: .continuationOpener,
            en: "Her heart raced as the door creaked slowly open.",
            zh: "门吱呀着缓缓打开，她的心怦怦直跳。",
            usage: "环境(门声)+心理(心跳)并行，制造悬念。"),
        // 高级动词
        PhraseCard(id: "p15", category: .advancedVerb,
            en: "soar / plunge（替换 rise / fall）",
            zh: "骤升 / 骤降",
            usage: "写数据或情绪起伏，soar、plunge 更有张力。"),
        PhraseCard(id: "p16", category: .advancedVerb,
            en: "whisper / murmur（替换 say quietly）",
            zh: "低语 / 喃喃",
            usage: "续写对话时区分音量与情绪。"),
        PhraseCard(id: "p17", category: .advancedVerb,
            en: "grasp / seize（替换 take / hold）",
            zh: "紧抓 / 抓住",
            usage: "seize the chance 抓住机会，比 take 有力。"),
        // 加分句式
        PhraseCard(id: "p18", category: .sentencePattern,
            en: "No sooner had he sat down than the phone rang.",
            zh: "他刚坐下，电话就响了。",
            usage: "No sooner…than 倒装，写‘一……就……’。"),
        PhraseCard(id: "p19", category: .sentencePattern,
            en: "Such was her determination that nothing could stop her.",
            zh: "她的决心如此之大，没什么能阻挡她。",
            usage: "Such…that 倒装，突出程度，议论记叙皆宜。"),
        PhraseCard(id: "p20", category: .sentencePattern,
            en: "It was with great pride that she accepted the award.",
            zh: "她无比自豪地接过了奖项。",
            usage: "It was…that 强调句，强调状语更有感染力。"),
        // 应用文句
        PhraseCard(id: "p21", category: .applied,
            en: "I would be more than happy to help if needed.",
            zh: "如有需要，我非常乐意提供帮助。",
            usage: "表达意愿的礼貌高分句。"),
        PhraseCard(id: "p22", category: .applied,
            en: "Please don't hesitate to contact me for any details.",
            zh: "如需了解任何细节，请随时与我联系。",
            usage: "书信结尾的得体收束句。"),
    ]

    static let extendedB: [PhraseCard] = [
        // 熟词僻义档案（阅读高频陷阱）
        PhraseCard(id: "v1", category: .polysemy,
            en: "address　常义：地址",
            zh: "僻义：解决、处理",
            usage: "We must address the problem at once. 我们必须立即解决问题。"),
        PhraseCard(id: "v2", category: .polysemy,
            en: "last　常义：最后的",
            zh: "僻义：持续；最不可能的",
            usage: "The meeting lasted two hours. 会议持续了两小时。"),
        PhraseCard(id: "v3", category: .polysemy,
            en: "figure　常义：数字",
            zh: "僻义：人物；想出(figure out)",
            usage: "She is a key figure in the field. 她是该领域的重要人物。"),
        PhraseCard(id: "v4", category: .polysemy,
            en: "subject　常义：主题/科目",
            zh: "僻义：使遭受(subject to)",
            usage: "They were subjected to great pressure. 他们承受了巨大压力。"),
        PhraseCard(id: "v5", category: .polysemy,
            en: "content　常义：内容",
            zh: "僻义：满足的(be content with)",
            usage: "He is content with his simple life. 他满足于简朴的生活。"),
        PhraseCard(id: "v6", category: .polysemy,
            en: "novel　常义：小说",
            zh: "僻义：新颖的",
            usage: "It is a novel approach to the issue. 这是解决该问题的新颖方法。"),
        PhraseCard(id: "v7", category: .polysemy,
            en: "bear　常义：熊",
            zh: "僻义：忍受；承担",
            usage: "She had to bear the responsibility. 她不得不承担这份责任。"),
        PhraseCard(id: "v8", category: .polysemy,
            en: "second　常义：第二；秒",
            zh: "僻义：赞同、支持",
            usage: "I second your proposal. 我赞同你的提议。"),
    ]

    static let extendedC: [PhraseCard] = [
        // 应用文·分体裁开头句
        PhraseCard(id: "p23", category: .applied,
            en: "I'm writing to ask for your advice on how to prepare for the speech contest.",
            zh: "我写信是想就如何准备演讲比赛向你请教。",
            usage: "求助信标准开头，先点明求助内容再展开细节。"),
        PhraseCard(id: "p24", category: .applied,
            en: "I'm writing to offer a few suggestions on improving our school's recycling program.",
            zh: "我写信是想就改进学校的回收计划提几点建议。",
            usage: "建议信开头，直接点出建议主题，方便阅卷者快速定位文体。"),
        PhraseCard(id: "p25", category: .applied,
            en: "I'm writing to express my heartfelt thanks for your generous help last weekend.",
            zh: "我写信是想为你上周末的热心帮助表达由衷感谢。",
            usage: "感谢信开头，heartfelt 比 thank you very much 更书面、更有诚意。"),
        PhraseCard(id: "p26", category: .applied,
            en: "I'm writing to sincerely apologize for missing our appointment yesterday.",
            zh: "我写信是想为昨天错过我们的约定真诚致歉。",
            usage: "道歉信开头，sincerely apologize 比单纯的 sorry 更正式得体。"),
        PhraseCard(id: "p27", category: .applied,
            en: "This is to inform all students that the English speech contest will be held this Friday.",
            zh: "现通知全体学生，英语演讲比赛将于本周五举行。",
            usage: "通知类标准开头，This is to inform... 直接点出通知对象与事项。"),
        PhraseCard(id: "p28", category: .applied,
            en: "Those interested are welcome to sign up by emailing the Students' Union before Friday.",
            zh: "有意者可在周五前邮件联系学生会报名。",
            usage: "通知/海报类报名方式的标准表达，信息要素(方式+截止时间)一句给全。"),
    ]

    static func cards(in category: PhraseCategory) -> [PhraseCard] {
        all.filter { $0.category == category }
    }
}
