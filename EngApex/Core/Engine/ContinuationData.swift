import Foundation

/// 读后续写工坊情境库。每个情境含情节链脚手架、关联句式、高分范文与自评 rubric。
enum ContinuationData {

    static let all: [ContinuationPrompt] = [
        rainstorm, sportsDay, reconciliation, strayDog, lostWallet, oldBicycle,
        lostTourist, pianoContest, siblingMisunderstanding, injuredBird, examTemptation, unsentLetter,
    ]

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
        rubric: sharedRubric,
        isFree: true
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
        rubric: sharedRubric,
        isFree: true
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

    // MARK: 情境三·误会与和解

    static let reconciliation = ContinuationPrompt(
        id: "cw_reconciliation",
        title: "误会与和解",
        context: "Anna 和好朋友 Mia 因为一次误会(以为 Mia 故意没邀请她参加生日会)冷战了一周，两人都不愿先开口。",
        para1Lead: "Anna stared at her phone, hesitating whether to send the message she had typed and deleted five times.",
        para2Lead: "Just as she put her phone down, it suddenly buzzed with a new message from Mia.",
        stages: [
            PlotStage(name: "起因·内心挣扎", guidance: "用反复的小动作(打字又删除)外化主人公的纠结，不直接说'她很难过'。", phraseIds: []),
            PlotStage(name: "发展·回忆委屈", guidance: "插入一小段对误会起因的回忆，夹杂自责或委屈的心理描写。", phraseIds: []),
            PlotStage(name: "转折·收到消息", guidance: "用 Just then/Just as 推进当下，引入对方的主动示好，制造转机。", phraseIds: ["p2"]),
            PlotStage(name: "高潮·当面解释", guidance: "通过对话还原误会的真相，让两人的情绪有来有回，不要单方面陈述。", phraseIds: ["p16"]),
            PlotStage(name: "结局·重归于好", guidance: "用一个具体动作(如一个拥抱)代替'他们和好了'的直白叙述。", phraseIds: []),
            PlotStage(name: "升华·友情感悟", guidance: "由这次误会升华到'真正的朋友愿意主动沟通'的感悟，点题收束。", phraseIds: ["p8"]),
        ],
        modelEssay: reconciliationEssay,
        rubric: sharedRubric,
        isFree: true
    )

    private static let reconciliationEssay: String = {
        let p1 = "Anna stared at her phone, hesitating whether to send the message she had typed and deleted five times. "
            + "Ever since she had heard that Mia didn't invite her to the birthday party, a heavy feeling had settled in her chest. "
            + "She kept replaying the scene in her mind, wondering what she could have done wrong. Maybe Mia simply didn't want to be friends anymore, she thought, and the idea made her throat tighten."
        let p2 = "Just as she put her phone down, it suddenly buzzed with a new message from Mia. \"Can we talk? I think there's been a huge misunderstanding,\" it read. "
            + "They met at the park bench where they always used to sit, and slowly, in whispers at first, the truth came out: the invitation had simply gotten lost between two phones. "
            + "It was not until that moment that Anna understood how a single unspoken doubt could grow into something so painful. They hugged tightly, both promising to talk things through next time, no matter how small the issue seemed."
        return p1 + "\n\n" + p2
    }()

    // MARK: 情境四·迷路的小狗

    static let strayDog = ContinuationPrompt(
        id: "cw_straydog",
        title: "迷路的小狗",
        context: "Ben 在放学路上发现一只浑身湿透、瘸着腿的小狗在巷子里发抖，附近没有任何主人的踪迹。",
        para1Lead: "Ben was about to walk past the alley when a soft whimper made him stop in his tracks.",
        para2Lead: "After three days of searching, Ben finally found a clue that led him to the dog's owner.",
        stages: [
            PlotStage(name: "起因·发现", guidance: "用细节(浑身湿透/瘸腿/发抖)描写小动物的处境，激发主人公的同情心。", phraseIds: []),
            PlotStage(name: "发展·决定帮助", guidance: "描写主人公的纠结(要不要管/家里能不能养)和最终的行动决心。", phraseIds: ["p9"]),
            PlotStage(name: "转折·寻找线索", guidance: "推进情节到寻找主人的过程，可用时间词(over the next few days)压缩叙事节奏。", phraseIds: []),
            PlotStage(name: "高潮·找到线索", guidance: "通过一个具体物证(项圈/海报)制造发现线索的戏剧性瞬间。", phraseIds: ["p6"]),
            PlotStage(name: "结局·团聚", guidance: "描写主人与小狗重聚的画面，侧重双方的反应而非直叙'团聚了'。", phraseIds: []),
            PlotStage(name: "升华·感悟", guidance: "由这次经历升华到'善意微小却能改变一切'的感悟。", phraseIds: ["p7"]),
        ],
        modelEssay: strayDogEssay,
        rubric: sharedRubric,
        isFree: true
    )

    private static let strayDogEssay: String = {
        let p1 = "Ben was about to walk past the alley when a soft whimper made him stop in his tracks. There, shivering behind a trash can, was a small dog, "
            + "its fur soaked and one leg held awkwardly off the ground. Its eyes, wide and frightened, seemed to beg for help. Although he had never taken care "
            + "of an animal before, Ben couldn't bring himself to walk away. He gently wrapped the trembling dog in his jacket and carried it home."
        let p2 = "After three days of searching, Ben finally found a clue that led him to the dog's owner: a faded \"missing pet\" poster taped to a lamppost two streets away, "
            + "with a phone number barely readable in the rain-smudged ink. His hands trembled with excitement as he dialed the number. When the owner, an elderly woman, "
            + "opened her door and saw her dog leap into her arms, tears of joy filled her eyes. Not only had Ben saved a life, but he also learned that even the smallest act of kindness could make someone's whole world whole again."
        return p1 + "\n\n" + p2
    }()

    // MARK: 情境五·拾金不昧

    static let lostWallet = ContinuationPrompt(
        id: "cw_wallet",
        title: "拾金不昧",
        context: "Lucy 在公交车上捡到一个钱包，里面有不少现金和一张看起来很重要的车票。她面临要不要据为己有的内心考验。",
        para1Lead: "Lucy's fingers brushed against something soft under the bus seat, and she pulled out a worn leather wallet.",
        para2Lead: "Three stops later, she finally spotted a woman frantically searching through her bag near the same seat.",
        stages: [
            PlotStage(name: "起因·发现钱包", guidance: "描写发现钱包的瞬间和打开后的内容(现金/车票)，为后续抉择埋伏笔。", phraseIds: []),
            PlotStage(name: "发展·内心挣扎", guidance: "正面写出诚实与诱惑之间的心理拉锯，不要回避'动心'这一真实反应。", phraseIds: ["p9"]),
            PlotStage(name: "转折·决定寻找失主", guidance: "用一个关键细节(车票上的姓名/时间)推动主人公主动行动。", phraseIds: []),
            PlotStage(name: "高潮·物归原主", guidance: "描写归还瞬间双方的反应，失主的惊喜与主人公的释然都要写到。", phraseIds: ["p20"]),
            PlotStage(name: "结局·失主感谢", guidance: "可加入对方的具体感谢方式(如坚持留下联系方式)增添真实感。", phraseIds: []),
            PlotStage(name: "升华·诚信感悟", guidance: "由这次选择升华到'诚实比一时的诱惑更珍贵'的感悟。", phraseIds: ["p19"]),
        ],
        modelEssay: lostWalletEssay,
        rubric: sharedRubric,
        isFree: true
    )

    private static let lostWalletEssay: String = {
        let p1 = "Lucy's fingers brushed against something soft under the bus seat, and she pulled out a worn leather wallet. Inside were several hundred yuan in cash "
            + "and a train ticket marked for a departure just an hour away. For a brief, guilty moment, she wondered what it would be like to simply keep the money and say nothing. "
            + "However tempting the thought was, she knew deep down that it wasn't who she wanted to be."
        let p2 = "Three stops later, she finally spotted a woman frantically searching through her bag near the same seat, panic written all over her face. "
            + "\"Excuse me, is this yours?\" Lucy asked, holding up the wallet. The woman's eyes lit up with disbelief and relief as she clutched it to her chest, "
            + "thanking Lucy again and again and insisting on exchanging contact information. Such was the woman's gratitude that Lucy felt a warmth in her heart far greater than any amount of money could buy."
        return p1 + "\n\n" + p2
    }()

    // MARK: 情境六·爸爸的旧自行车

    static let oldBicycle = ContinuationPrompt(
        id: "cw_bicycle",
        title: "爸爸的旧自行车",
        context: "Tom 一直觉得爸爸送他上学用的旧自行车又破又旧，让他在同学面前很没面子，直到有一天他偶然发现了这台自行车背后的故事。",
        para1Lead: "Tom rolled his eyes as his father wheeled out the same old, rusty bicycle for the hundredth morning in a row.",
        para2Lead: "That evening, he found an old photograph tucked inside the bicycle's worn seat cushion.",
        stages: [
            PlotStage(name: "起因·嫌弃旧车", guidance: "直接呈现主人公的不耐烦/尴尬情绪，为后续的转变做对比。", phraseIds: []),
            PlotStage(name: "发展·日常细节", guidance: "插入父亲默默维护自行车的细节(擦车/上油)，为后文埋下情感线索。", phraseIds: []),
            PlotStage(name: "转折·发现照片", guidance: "用一个具体物件(照片)作为情节的转折点，引出背后的故事。", phraseIds: ["p2"]),
            PlotStage(name: "高潮·得知真相", guidance: "通过照片或父亲的讲述揭示自行车的来历，让细节自己说话。", phraseIds: ["p6"]),
            PlotStage(name: "结局·态度转变", guidance: "描写主人公主动帮父亲擦车或主动骑车上学的细节，展现态度的转变。", phraseIds: []),
            PlotStage(name: "升华·感悟", guidance: "由旧自行车升华到'爱有时藏在不起眼的细节里'的感悟，点题收束。", phraseIds: ["p8"]),
        ],
        modelEssay: oldBicycleEssay,
        rubric: sharedRubric,
        isFree: true
    )

    private static let oldBicycleEssay: String = {
        let p1 = "Tom rolled his eyes as his father wheeled out the same old, rusty bicycle for the hundredth morning in a row. He always made sure to walk a few steps behind it "
            + "on the way to school, hoping none of his classmates would notice. Every evening, though, he noticed his father quietly wiping down the frame and oiling the chain, "
            + "as if the bicycle were something precious rather than an embarrassment."
        let p2 = "That evening, he found an old photograph tucked inside the bicycle's worn seat cushion: a young man, clearly his father, grinning proudly beside the very same bicycle, "
            + "brand new and gleaming. On the back, in faded handwriting, were the words: \"My first bike, bought with a whole year's savings.\" It was not until that moment that Tom "
            + "understood why his father treasured it so deeply. The next morning, for the first time, he offered to help wipe down the seat before riding off to school, sitting a little taller than before."
        return p1 + "\n\n" + p2
    }()

    // MARK: 情境七·迷路的游客

    static let lostTourist = ContinuationPrompt(
        id: "cw_tourist",
        title: "迷路的游客",
        context: "Emma 在放学路上遇到一位拿着地图、神情焦急的外国游客，他似乎迷路了，正在寻找回酒店的路。",
        para1Lead: "Emma noticed a foreign tourist standing at the corner, anxiously turning his map this way and that.",
        para2Lead: "Just as they reached the hotel entrance, the man turned to Emma with a grateful smile.",
        stages: [
            PlotStage(name: "起因·发现", guidance: "用细节描写游客的焦急状态，引出主人公的注意。", phraseIds: []),
            PlotStage(name: "发展·主动帮助", guidance: "描写主人公克服语言不自信的顾虑，主动上前询问。", phraseIds: ["p9"]),
            PlotStage(name: "转折·一起寻路", guidance: "推进到两人一起寻路的过程，可压缩叙事节奏。", phraseIds: []),
            PlotStage(name: "高潮·克服沟通障碍", guidance: "用一个语言不通的小插曲，靠耐心和手势化解。", phraseIds: ["p17"]),
            PlotStage(name: "结局·到达酒店", guidance: "描写抵达酒店时双方的反应。", phraseIds: []),
            PlotStage(name: "升华·感悟", guidance: "由这次经历升华到'善意不分语言'的感悟。", phraseIds: ["p7"]),
        ],
        modelEssay: lostTouristEssay,
        rubric: sharedRubric,
        isFree: false
    )

    private static let lostTouristEssay: String = {
        let p1 = "Emma noticed a foreign tourist standing at the corner, anxiously turning his map this way and that. Sensing that something was wrong, "
            + "she walked over and asked, in her best English, if he needed any help. The man explained, with a mix of words and gestures, that he was "
            + "trying to find his hotel but had completely lost his way. Although Emma wasn't entirely confident in her spoken English, she decided to "
            + "walk him there herself rather than simply pointing at the map."
        let p2 = "Just as they reached the hotel entrance, the man turned to Emma with a grateful smile. \"Thank you so much,\" he said slowly, shaking her "
            + "hand warmly. \"You saved my afternoon.\" Emma smiled back, realizing that kindness needed no perfect grammar to be understood. Not only had "
            + "she helped a stranger find his way, but she had also discovered that a little courage could bridge any language gap."
        return p1 + "\n\n" + p2
    }()

    // MARK: 情境八·钢琴比赛

    static let pianoContest = ContinuationPrompt(
        id: "cw_piano",
        title: "钢琴比赛",
        context: "Lucy 为即将到来的钢琴比赛准备了好几个月，但比赛前一天不小心弄伤了手指。",
        para1Lead: "Lucy stared at her bandaged finger, wondering how she could possibly play tomorrow's piece.",
        para2Lead: "As the curtain rose and her name was called, Lucy took a deep breath and walked onto the stage.",
        stages: [
            PlotStage(name: "起因·受伤的打击", guidance: "开篇点明意外受伤，与数月的准备形成对比。", phraseIds: []),
            PlotStage(name: "发展·内心挣扎与决定", guidance: "正面写出'是否放弃'的心理拉锯，再以决心扭转。", phraseIds: ["p9"]),
            PlotStage(name: "转折·调整与坚持", guidance: "描写连夜调整指法、不放弃的具体行动。", phraseIds: []),
            PlotStage(name: "高潮·登台表演", guidance: "连续动作细节描写演奏过程中的坚持。", phraseIds: ["p17", "p19"]),
            PlotStage(name: "结局·完成演奏", guidance: "完成演出，结果不必完美但有意义。", phraseIds: []),
            PlotStage(name: "升华·意义", guidance: "由'带伤完成演奏'升华坚持的意义。", phraseIds: ["p7"]),
        ],
        modelEssay: pianoContestEssay,
        rubric: sharedRubric,
        isFree: false
    )

    private static let pianoContestEssay: String = {
        let p1 = "Lucy stared at her bandaged finger, wondering how she could possibly play tomorrow's piece. Months of practice seemed to be slipping away "
            + "because of one careless accident. For a while, she considered withdrawing from the competition altogether. However hopeless it seemed, she "
            + "decided to spend the night adjusting her fingering, determined not to give up on something she had worked so hard for."
        let p2 = "As the curtain rose and her name was called, Lucy took a deep breath and walked onto the stage. Her injured finger ached with every note, "
            + "but she gripped her focus and let the music carry her forward. When the final chord faded into silence, the audience burst into applause. "
            + "Not only had she finished the piece, but she had also proven to herself that determination could outplay pain."
        return p1 + "\n\n" + p2
    }()

    // MARK: 情境九·兄妹之间的误会

    static let siblingMisunderstanding = ContinuationPrompt(
        id: "cw_siblings",
        title: "兄妹之间的误会",
        context: "Jack 发现自己珍藏的限量版模型不见了，怀疑是妹妹 Lily 偷偷拿走玩坏了，两人因此大吵一架。",
        para1Lead: "Jack slammed his door shut, convinced that Lily had taken his model without asking.",
        para2Lead: "Just then, his mother walked in holding the very model he thought was lost.",
        stages: [
            PlotStage(name: "起因·愤怒的指责", guidance: "直接呈现主人公未经核实就指责的冲动。", phraseIds: []),
            PlotStage(name: "发展·冷战与委屈", guidance: "插入双方冷战的细节，暗示后续反转。", phraseIds: []),
            PlotStage(name: "转折·真相浮现", guidance: "用 Just then 引入第三方，推进当下情节。", phraseIds: ["p2"]),
            PlotStage(name: "高潮·明白真相", guidance: "通过一个具体物证(模型)制造真相揭晓的瞬间。", phraseIds: ["p6"]),
            PlotStage(name: "结局·道歉和解", guidance: "描写主人公主动道歉的具体动作。", phraseIds: []),
            PlotStage(name: "升华·感悟", guidance: "由这次误会升华到'先核实再指责'的感悟。", phraseIds: ["p8"]),
        ],
        modelEssay: siblingEssay,
        rubric: sharedRubric,
        isFree: false
    )

    private static let siblingEssay: String = {
        let p1 = "Jack slammed his door shut, convinced that Lily had taken his model without asking. He had searched his whole room twice and could only "
            + "imagine his little sister sneaking in to play with it. When she denied it, tears in her eyes, he refused to believe her, and the two didn't "
            + "speak to each other for the rest of the day."
        let p2 = "Just then, his mother walked in holding the very model he thought was lost, explaining that she had moved it while cleaning his desk that "
            + "morning. Jack's face went pale as he glanced at Lily, who was still quietly upset in the corner. It was not until that moment that he "
            + "understood how unfair he had been. He walked over and apologized sincerely, promising to trust her next time before jumping to conclusions."
        return p1 + "\n\n" + p2
    }()

    // MARK: 情境十·受伤的小鸟

    static let injuredBird = ContinuationPrompt(
        id: "cw_bird",
        title: "受伤的小鸟",
        context: "Amy 在公园散步时发现一只翅膀受伤、无法飞行的小鸟，决定把它带回家照顾。",
        para1Lead: "Amy crouched down beside the small bird, noticing how its wing hung at an odd angle.",
        para2Lead: "Weeks later, she opened her palms in the same park and watched closely.",
        stages: [
            PlotStage(name: "起因·发现受伤的鸟", guidance: "用细节描写鸟的处境，激发主人公的同情心。", phraseIds: []),
            PlotStage(name: "发展·细心照顾", guidance: "描写日常照顾的具体动作，体现耐心。", phraseIds: ["p4"]),
            PlotStage(name: "转折·逐渐恢复", guidance: "用时间词压缩叙事，展现状态的变化。", phraseIds: []),
            PlotStage(name: "高潮·尝试飞行", guidance: "描写鸟尝试起飞的紧张与期待。", phraseIds: ["p15"]),
            PlotStage(name: "结局·重新起飞", guidance: "描写鸟最终飞走的画面。", phraseIds: []),
            PlotStage(name: "升华·感悟", guidance: "由这次经历升华到'耐心与陪伴的意义'。", phraseIds: ["p7"]),
        ],
        modelEssay: birdEssay,
        rubric: sharedRubric,
        isFree: false
    )

    private static let birdEssay: String = {
        let p1 = "Amy crouched down beside the small bird, noticing how its wing hung at an odd angle. Without a second thought, she gently wrapped it in "
            + "her scarf and carried it home, determined to help it heal. Every day after school, she cleaned its wound, fed it small pieces of fruit, "
            + "and made sure it stayed warm, watching its strength slowly return."
        let p2 = "Weeks later, she opened her palms in the same park and watched closely as the bird hesitated, then spread its wings and soared into the "
            + "sky above the trees. Amy's eyes filled with happy tears as she watched it disappear into the distance. Not only had she saved a small life, "
            + "but she had also learned that patience and care could turn even the smallest creature's fate around."
        return p1 + "\n\n" + p2
    }()

    // MARK: 情境十一·考试中的诱惑

    static let examTemptation = ContinuationPrompt(
        id: "cw_exam",
        title: "考试中的诱惑",
        context: "Daniel 在一次重要的考试中，无意间看到了同桌的答案，内心十分纠结要不要抄。",
        para1Lead: "Daniel's eyes drifted toward his deskmate's paper before he could stop himself.",
        para2Lead: "When the results were announced a week later, Daniel felt a quiet sense of pride.",
        stages: [
            PlotStage(name: "起因·无意瞥见", guidance: "描写无意瞥见的瞬间，不必刻意丑化。", phraseIds: []),
            PlotStage(name: "发展·内心挣扎", guidance: "正面写出诚实与诱惑之间的心理拉锯。", phraseIds: ["p9"]),
            PlotStage(name: "转折·坚定选择", guidance: "用一个动作(移开视线)体现决定。", phraseIds: []),
            PlotStage(name: "高潮·独立完成", guidance: "描写靠自己完成考试的过程。", phraseIds: ["p17"]),
            PlotStage(name: "结局·考试结束", guidance: "描写结束时的心情，不必夸张。", phraseIds: []),
            PlotStage(name: "升华·诚信感悟", guidance: "由这次选择升华到'诚实本身就是一种胜利'。", phraseIds: ["p19"]),
        ],
        modelEssay: examEssay,
        rubric: sharedRubric,
        isFree: false
    )

    private static let examEssay: String = {
        let p1 = "Daniel's eyes drifted toward his deskmate's paper before he could stop himself, catching a glimpse of an answer he wasn't sure about. "
            + "For a moment, the temptation to copy it felt almost irresistible, especially with the exam counting so much toward his final grade. "
            + "However tempting it was, he forced himself to look away and return to his own paper, reminding himself that the score wouldn't mean "
            + "anything if it wasn't truly his."
        let p2 = "When the results were announced a week later, Daniel felt a quiet sense of pride, even though his score wasn't the highest in class. "
            + "He had earned every point through his own effort, and that mattered more to him than any number on the page. Such was his relief that he "
            + "realized honesty, even when no one was watching, was a victory in itself."
        return p1 + "\n\n" + p2
    }()

    // MARK: 情境十二·妈妈的手写信

    static let unsentLetter = ContinuationPrompt(
        id: "cw_letter",
        title: "妈妈的手写信",
        context: "Sophie 一直觉得妈妈不理解自己，母女俩很少深入交流，直到她在妈妈的旧抽屉里发现了一封没有寄出的信。",
        para1Lead: "Sophie almost closed the drawer when a folded piece of paper caught her eye.",
        para2Lead: "That evening, she found her mother in the kitchen and quietly handed her the letter.",
        stages: [
            PlotStage(name: "起因·偶然发现", guidance: "用细节描写发现信件的瞬间，制造悬念。", phraseIds: []),
            PlotStage(name: "发展·阅读信件", guidance: "描写信件内容带来的情感冲击。", phraseIds: ["p6"]),
            PlotStage(name: "转折·理解的转变", guidance: "用 Just then 或同类词推进，引出态度转变。", phraseIds: ["p2"]),
            PlotStage(name: "高潮·情感冲击", guidance: "描写主人公内心受到触动的细节。", phraseIds: []),
            PlotStage(name: "结局·主动沟通", guidance: "描写主人公主动与母亲交流的画面。", phraseIds: []),
            PlotStage(name: "升华·亲情感悟", guidance: "由这封信升华到'爱常常藏在沉默背后'的感悟。", phraseIds: ["p8"]),
        ],
        modelEssay: letterEssay,
        rubric: sharedRubric,
        isFree: false
    )

    private static let letterEssay: String = {
        let p1 = "Sophie almost closed the drawer when a folded piece of paper caught her eye. It was a letter, written in her mother's handwriting but "
            + "never sent, dated from years ago. As she read line after line, she realized it was filled with worries about whether she was being a good "
            + "enough mother, and how much she longed to understand her growing daughter better."
        let p2 = "That evening, she found her mother in the kitchen and quietly handed her the letter. Her mother's hands trembled slightly as she "
            + "recognized her own words. It was not until that moment that Sophie understood how much love had been hiding behind her mother's quiet, "
            + "undemonstrative way. The two sat down together, and for the first time in years, they talked late into the night about everything they "
            + "had never said out loud."
        return p1 + "\n\n" + p2
    }()

    static func find(_ id: String) -> ContinuationPrompt? { all.first { $0.id == id } }
}
