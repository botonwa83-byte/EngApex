import Foundation

/// 应用文工坊情境库。覆盖高考高频的 6 个体裁：求助信/建议信/感谢信/道歉信/通知/海报。
/// 每个情境含写作要求、结构骨架、关联句式、高分范文与自评 rubric——和读后续写工坊同一套打法。
enum AppliedWritingData {

    static let all: [AppliedWritingPrompt] = [
        help, suggest, thanks, apology, notice, poster,
        help2, suggest2, thanks2, apology2, notice2, poster2,
    ]

    static let sharedRubric = [
        "开头一句话点明文体目的(求助/建议/感谢/道歉/通知/海报)，不绕弈",
        "内容覆盖题目给出的所有要点，没有遗漏任何一条要求",
        "至少用 1-2 个亮点句式或精准词汇(虚拟语气/强调句/精准动词)，不堆砌简单句",
        "语域正式得体，没有口语化或命令式表达",
        "结尾礼貌收束(书信类)或要点清晰(通知/海报类)，与开头语域一致",
        "无低级语法/拼写错误，篇幅适中(约100词)",
    ]

    // MARK: 求助信

    static let help = AppliedWritingPrompt(
        id: "aw_help",
        genre: "求助信",
        title: "演讲比赛求助",
        scenario: "你叫李华，将代表班级参加学校英语演讲比赛，但缺乏经验。写信向英语老师 Mr. Smith 求助。要求包括：①说明情况 ②提出具体请求(如修改演讲稿、安排模拟练习) ③表达感谢。",
        stages: [
            WritingStage(name: "开头·说明来意", guidance: "一句话点出身份+求助内容，不绕弈，让阅卷者立刻判断文体。", phraseIds: ["p23"]),
            WritingStage(name: "正文·具体请求", guidance: "把请求拆成 2-3 条，每条具体而非笼统，可用虚拟语气礼貌提出。", phraseIds: ["p11"]),
            WritingStage(name: "结尾·感谢+礼貌收束", guidance: "用礼貌的期待回复句收尾，呼应开头语域。", phraseIds: ["p12", "p21"]),
        ],
        modelEssay: """
        Dear Mr. Smith,

        I'm writing to ask for your advice on how to prepare for the upcoming English speech contest. As I have never taken part in such a competition before, I find myself rather nervous and unsure where to start.

        Could you please take a few minutes to look over my draft and point out where it could be improved? I would also appreciate it if you could arrange a short practice session so that I can get used to speaking in front of an audience. Your guidance would mean a great deal to me.

        Thank you so much for your time and support. I am looking forward to your reply.

        Yours,
        Li Hua
        """,
        rubric: sharedRubric,
        isFree: true
    )

    // MARK: 建议信

    static let suggest = AppliedWritingPrompt(
        id: "aw_suggest",
        genre: "建议信",
        title: "提升环保意识建议信",
        scenario: "学校英文杂志就\"如何提高同学们的环保意识\"征集建议信，写信给编辑部，提出至少两条具体建议并说明理由。",
        stages: [
            WritingStage(name: "开头·点出建议主题", guidance: "直接说明写信目的是提建议，不必铺垫太多背景。", phraseIds: ["p24"]),
            WritingStage(name: "正文·分点建议+理由", guidance: "每条建议配一句理由或具体做法，让建议落地而非空泛口号。", phraseIds: ["p5"]),
            WritingStage(name: "结尾·呼应主题收束", guidance: "总结建议的意义，呼应集体利益，礼貌收尾。", phraseIds: ["p12"]),
        ],
        modelEssay: """
        Dear Editor,

        I'm writing to offer a few suggestions on improving our school's recycling program, as I believe many students still lack awareness of environmental protection.

        First, the school could place clearly labeled recycling bins in every classroom, which would make sorting waste much easier. Second, a monthly "Green Day" could be organized to raise students' awareness through posters, talks, and hands-on activities. These small steps, if carried out consistently, could gradually tackle the problem of careless waste disposal on campus.

        I hope these ideas will be useful, and I'm looking forward to seeing a greener campus soon.

        Yours,
        Li Hua
        """,
        rubric: sharedRubric,
        isFree: true
    )

    // MARK: 感谢信

    static let thanks = AppliedWritingPrompt(
        id: "aw_thanks",
        genre: "感谢信",
        title: "感谢志愿活动指导",
        scenario: "上周末你参加了社区志愿活动，负责人 Mr. Wang 给予了很多帮助和指导。写信表达感谢，提及具体帮助内容和活动收获。",
        stages: [
            WritingStage(name: "开头·点明感谢缘由", guidance: "一句话说清楚为什么感谢、感谢谁，避免空泛的'谢谢你'。", phraseIds: ["p25"]),
            WritingStage(name: "正文·具体事例+收获", guidance: "用 1-2 个具体细节(他做了什么)代替空泛感谢，再补一句自己的收获或感受。", phraseIds: ["p4"]),
            WritingStage(name: "结尾·再次致谢+礼貌结束", guidance: "再次致谢并礼貌收尾，可加一句愿意再次参与。", phraseIds: ["p21", "p12"]),
        ],
        modelEssay: """
        Dear Mr. Wang,

        I'm writing to express my heartfelt thanks for your generous help during last weekend's community volunteer activity.

        Throughout the day, you patiently showed me how to organize the donated books and even stayed late to help me finish sorting them. Thanks to your guidance, I not only learned practical skills but also came to enhance my understanding of what it truly means to serve the community.

        Once again, thank you for your time and patience. I would be more than happy to take part in similar activities again in the future.

        Yours,
        Li Hua
        """,
        rubric: sharedRubric,
        isFree: true
    )

    // MARK: 道歉信

    static let apology = AppliedWritingPrompt(
        id: "aw_apology",
        genre: "道歉信",
        title: "因故缺席道歉",
        scenario: "你和外教 Lisa 约好周六一起参观博物馆，但因突发情况无法赴约。写信道歉，说明理由，并提出补救方案(如改约时间)。",
        stages: [
            WritingStage(name: "开头·真诚致歉", guidance: "一句话直接道歉并点出未能赴约的事项。", phraseIds: ["p26"]),
            WritingStage(name: "正文·说明理由+补救方案", guidance: "理由简洁可信，紧接着主动提出补救方案，体现担当而非只道歉。", phraseIds: []),
            WritingStage(name: "结尾·再次致歉+礼貌结束", guidance: "再次表达歉意，礼貌收尾，期待对方回复。", phraseIds: ["p12"]),
        ],
        modelEssay: """
        Dear Lisa,

        I'm writing to sincerely apologize for missing our appointment to visit the museum yesterday. My grandmother was suddenly taken ill, so I had to rush to the hospital with my family and could not let you know in time.

        I do hope this hasn't caused you too much inconvenience. Would it be possible for us to reschedule the visit to next Saturday instead? I will make sure to confirm with you well in advance this time.

        Once again, I'm really sorry for the trouble. Looking forward to your reply.

        Yours,
        Li Hua
        """,
        rubric: sharedRubric,
        isFree: true
    )

    // MARK: 通知

    static let notice = AppliedWritingPrompt(
        id: "aw_notice",
        genre: "通知",
        title: "英语演讲比赛通知",
        scenario: "你是学生会成员，请为学校即将举办的\"英语演讲比赛\"写一则通知，告知时间地点、参赛要求、报名方式。",
        stages: [
            WritingStage(name: "标题与对象", guidance: "标题居中加粗(如 NOTICE)，第一句直接点出通知对象与事项，不绕弈。", phraseIds: ["p27"]),
            WritingStage(name: "正文·要点分行", guidance: "时间/地点/对象/要求逐条交代，每条一句话，避免堆成一段长难句。", phraseIds: []),
            WritingStage(name: "结尾·报名方式+落款", guidance: "报名方式与截止时间放在最后一句，落款写组织者而非个人语气收尾。", phraseIds: ["p28"]),
        ],
        modelEssay: """
        NOTICE

        This is to inform all students that the English speech contest will be held this Friday afternoon at 3 p.m. in the school hall.

        Students from Grade 1 and Grade 2 are all welcome to take part. Each speech should be about English learning experiences and last no more than three minutes. Please prepare your speech in advance and bring along any visual aids you may need.

        Those interested are welcome to sign up by emailing the Students' Union before Thursday noon.

        The Students' Union
        """,
        rubric: sharedRubric,
        isFree: true
    )

    // MARK: 海报

    static let poster = AppliedWritingPrompt(
        id: "aw_poster",
        genre: "海报",
        title: "英语角招新海报",
        scenario: "你校英语角(English Corner)将招募新成员，请写一张海报进行宣传，包括活动介绍、时间地点、报名方式。",
        stages: [
            WritingStage(name: "标题与简介", guidance: "标题要醒目(如 Join English Corner!)，开头一句话说明活动是什么、适合谁。", phraseIds: []),
            WritingStage(name: "正文·亮点+时间地点", guidance: "用 1-2 个亮点吸引人(外教交流/趣味游戏)，再给出固定的时间地点信息。", phraseIds: ["p4"]),
            WritingStage(name: "结尾·报名方式+号召", guidance: "报名方式简洁清楚，最后一句用号召性语言收尾，呼应海报的宣传目的。", phraseIds: ["p28"]),
        ],
        modelEssay: """
        Join English Corner!

        Are you eager to improve your spoken English in a fun and relaxed way? English Corner is exactly the place for you!

        Every Friday afternoon from 4 to 5 p.m. at the school library, we gather to chat with native speakers, play English games, and share interesting stories. Whether your English is just so-so or already pretty good, everyone is welcome to join and enhance their confidence in speaking.

        Simply scan the QR code below or contact Li Hua in Class Three to sign up. Don't miss this chance to make new friends and have fun while learning!
        """,
        rubric: sharedRubric,
        isFree: true
    )

    // MARK: 求助信·考前复习求助

    static let help2 = AppliedWritingPrompt(
        id: "aw_help2",
        genre: "求助信",
        title: "考前复习求助",
        scenario: "你叫李华，期末考试临近，但感觉复习方法不得力，写信向已经升入大学的学长 Mike 求助，请教高效的复习方法。要求包括：①说明当前的困扰 ②请教具体问题(如时间安排/重点把握) ③表达感谢。",
        stages: [
            WritingStage(name: "开头·说明来意", guidance: "一句话点出身份+求助内容，不绕弈。", phraseIds: ["p23"]),
            WritingStage(name: "正文·具体请求", guidance: "把请求拆成 2-3 条，每条具体而非笼统，可用虚拟语气礼貌提出。", phraseIds: ["p11"]),
            WritingStage(name: "结尾·感谢+礼貌收束", guidance: "用礼貌的期待回复句收尾。", phraseIds: ["p12"]),
        ],
        modelEssay: """
        Dear Mike,

        I'm writing to ask for your advice on how to prepare more effectively for my upcoming final exams. Lately I've been studying for long hours, but I still don't feel confident, and I'm not sure whether I'm focusing on the right things.

        Could you share how you used to organize your revision schedule back in high school? I would also appreciate it if you could tell me how to tell which topics deserve the most attention when time is limited. Any tips from your own experience would help me a great deal.

        Thank you so much for taking the time to help me. I'm looking forward to your reply.

        Yours,
        Li Hua
        """,
        rubric: sharedRubric,
        isFree: false
    )

    // MARK: 建议信·改善校园午餐

    static let suggest2 = AppliedWritingPrompt(
        id: "aw_suggest2",
        genre: "建议信",
        title: "改善校园午餐",
        scenario: "学校学生会就\"如何改善校园午餐质量\"征集建议信，写信给学生会，提出至少两条具体建议并说明理由。",
        stages: [
            WritingStage(name: "开头·点出建议主题", guidance: "直接说明写信目的是提建议。", phraseIds: ["p24"]),
            WritingStage(name: "正文·分点建议+理由", guidance: "每条建议配一句理由或具体做法。", phraseIds: ["p5"]),
            WritingStage(name: "结尾·呼应主题收束", guidance: "总结建议的意义，礼貌收尾。", phraseIds: ["p12"]),
        ],
        modelEssay: """
        Dear Students' Union,

        I'm writing to offer a few suggestions on improving the quality of our school lunches, as many students have recently complained about the limited variety of dishes.

        First, the canteen could introduce a rotating weekly menu so that students don't have to eat the same few dishes again and again. Second, adding a simple feedback box or online form would allow the kitchen staff to address students' preferences and any complaints in a timely manner. These changes, though small, could make lunchtime something students actually look forward to.

        I hope the union will consider these ideas, and I'm looking forward to seeing some improvements soon.

        Yours,
        Li Hua
        """,
        rubric: sharedRubric,
        isFree: false
    )

    // MARK: 感谢信·感谢老师课后辅导

    static let thanks2 = AppliedWritingPrompt(
        id: "aw_thanks2",
        genre: "感谢信",
        title: "感谢老师课后辅导",
        scenario: "你在英语学习上一直存在困难，英语老师 Ms. Chen 主动为你安排了几次课后辅导，帮你大幅提升了成绩。写信表达感谢。",
        stages: [
            WritingStage(name: "开头·点明感谢缘由", guidance: "一句话说清楚为什么感谢、感谢谁。", phraseIds: ["p25"]),
            WritingStage(name: "正文·具体事例+收获", guidance: "用具体细节代替空泛感谢，再补一句自己的收获。", phraseIds: ["p4"]),
            WritingStage(name: "结尾·再次致谢+礼貌结束", guidance: "再次致谢并礼貌收尾。", phraseIds: ["p21", "p12"]),
        ],
        modelEssay: """
        Dear Ms. Chen,

        I'm writing to express my heartfelt thanks for the extra time you spent helping me with English after class these past few weeks.

        Before your tutoring, I often felt lost during grammar lessons and was too shy to ask questions in front of the whole class. Through our one-on-one sessions, you patiently went through my mistakes again and again, which helped enhance not only my grammar but also my confidence in speaking up. My recent test score has improved more than I ever expected.

        Once again, thank you for your patience and dedication. I promise to keep working hard and make the most of what you've taught me.

        Yours,
        Li Hua
        """,
        rubric: sharedRubric,
        isFree: false
    )

    // MARK: 道歉信·借书未还致歉

    static let apology2 = AppliedWritingPrompt(
        id: "aw_apology2",
        genre: "道歉信",
        title: "借书未还致歉",
        scenario: "你从同学 Tom 那里借了一本重要的参考书，但不小心弄丢了。写信向 Tom 道歉，说明情况并提出补偿方案。",
        stages: [
            WritingStage(name: "开头·真诚致歉", guidance: "一句话直接道歉并点出未能归还的事项。", phraseIds: ["p26"]),
            WritingStage(name: "正文·说明理由+补救方案", guidance: "理由简洁可信，紧接着主动提出补救方案。", phraseIds: []),
            WritingStage(name: "结尾·再次致歉+礼貌结束", guidance: "再次表达歉意，礼貌收尾。", phraseIds: ["p12"]),
        ],
        modelEssay: """
        Dear Tom,

        I'm writing to sincerely apologize for losing the reference book I borrowed from you last week. I must have left it on the bus while rushing to catch my stop, and despite searching everywhere, I haven't been able to find it.

        I know how important this book was for your revision, so I would like to buy you a brand new copy as soon as possible, along with a notebook as a small token of apology for the inconvenience. Please let me know which edition you need.

        I'm really sorry for the trouble this has caused you. I hope it hasn't affected your studying too much.

        Yours,
        Li Hua
        """,
        rubric: sharedRubric,
        isFree: false
    )

    // MARK: 通知·社团招新通知

    static let notice2 = AppliedWritingPrompt(
        id: "aw_notice2",
        genre: "通知",
        title: "社团招新通知",
        scenario: "你是摄影社社长，请写一则通知，告知新学期社团招新的时间、地点、报名方式及要求。",
        stages: [
            WritingStage(name: "标题与对象", guidance: "标题居中加粗，第一句直接点出通知对象与事项。", phraseIds: ["p27"]),
            WritingStage(name: "正文·要点分行", guidance: "时间/地点/对象/要求逐条交代，每条一句话。", phraseIds: []),
            WritingStage(name: "结尾·报名方式+落款", guidance: "报名方式与截止时间放在最后一句，落款写组织者。", phraseIds: ["p28"]),
        ],
        modelEssay: """
        NOTICE

        This is to inform all students that the Photography Club is now open for new members for the new semester.

        No previous experience is required, only an interest in taking pictures and a willingness to learn. We will meet every Wednesday afternoon at 4 p.m. in Room 305, where members will share photography tips and organize small outdoor shoots together.

        Those interested are welcome to sign up by scanning the QR code on the club's poster or contacting the club at Room 305 before next Friday.

        Photography Club
        """,
        rubric: sharedRubric,
        isFree: false
    )

    // MARK: 海报·校园跳蚤市场海报

    static let poster2 = AppliedWritingPrompt(
        id: "aw_poster2",
        genre: "海报",
        title: "校园跳蚤市场海报",
        scenario: "你校学生会将举办一场校园跳蚤市场(义卖旧物)，请写一张海报进行宣传，包括活动介绍、时间地点、参与方式。",
        stages: [
            WritingStage(name: "标题与简介", guidance: "标题要醒目，开头一句话说明活动是什么、适合谁。", phraseIds: []),
            WritingStage(name: "正文·亮点+时间地点", guidance: "用 1-2 个亮点吸引人，再给出固定的时间地点信息。", phraseIds: ["p4"]),
            WritingStage(name: "结尾·参与方式+号召", guidance: "参与方式简洁清楚，最后一句用号召性语言收尾。", phraseIds: ["p28"]),
        ],
        modelEssay: """
        Campus Flea Market!

        Got books, toys, or clothes you no longer need? Why not give them a second life while making some new friends?

        This Saturday from 10 a.m. to 2 p.m. on the school playground, students are welcome to set up a small stall and sell their unwanted items at low prices. All proceeds collected from stall fees will go to support students in need, so this is a great chance to enhance both your wallet and your sense of community.

        Simply contact the Students' Union before Thursday to reserve your stall. Come and discover some hidden treasures!
        """,
        rubric: sharedRubric,
        isFree: false
    )

    static func find(_ id: String) -> AppliedWritingPrompt? { all.first { $0.id == id } }
}
