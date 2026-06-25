import Foundation

/// 五期扩充：专为"完整模考·套卷六"新增的原创题目，覆盖全部 7 模块。题库自此扩展到 ~377 题，
/// 套卷一~五维持三期扩充后的固定分割不变，套卷六是这批新题整体打包成的第 6 套(见 QuestionBank.paper6)。
extension QuestionBank {

    static let extended8: [Question] = grammarFill8 + cloze8 + sevenChoose8 + reading8 + reading8Part2 + applied8 + continuation8 + listening8b + listening9b

    /// 套卷六的固定题目集合：就是这批新增题目本身，按真实考场顺序排列。
    static let paper6: [Question] = extended8.sorted { $0.module.examOrderIndex < $1.module.examOrderIndex }

    // MARK: 语法填空 g31-g40

    static let grammarFill8: [Question] = [
        Question(id: "g31", module: .grammarFill, levelId: "L1",
            stem: "By the time the rescue team arrived, the hikers ___ (wait) in the cave for over six hours.",
            options: ["had been waiting", "waited", "were waiting", "have waited"], answer: 0,
            pointTag: "时态·过去完成进行时",
            strategy: ["By the time+过去时→主句用过去完成时态", "wait是持续性动作，强调'一直在等待'用完成进行", "选 had been waiting"],
            trap: "误填waited(一般过去)——丢失'持续等待'的强调。", difficulty: 0.6),
        Question(id: "g32", module: .grammarFill, levelId: "L1",
            stem: "These ancient documents are so fragile that they ___ (handle) with special gloves.",
            options: ["must be handled", "must handle", "must have handled", "must being handled"], answer: 0,
            pointTag: "被动语态·情态动词+被动",
            strategy: ["documents是被处理的对象，是被动关系", "情态动词+被动态= must be done", "选 must be handled"],
            trap: "误填must handle——documents不会主动'处理'，应为被动。", difficulty: 0.55),
        Question(id: "g33", module: .grammarFill, levelId: "L1",
            stem: "___ (collect) stamps from different countries has been her hobby since childhood.",
            options: ["Collecting", "To collect", "Collected", "Collect"], answer: 0,
            pointTag: "非谓语·动名词作主语",
            strategy: ["空格在句首作主语，且后面是'一直是她的爱好'(强调长期习惯性动作)", "动名词作主语表'(一直进行的)这一行为/活动'", "选 Collecting"],
            trap: "To collect 强调具体一次性的目的或计划，不如动名词适合表达'长期爱好'这一持续性活动。", difficulty: 0.6),
        Question(id: "g34", module: .grammarFill, levelId: "L1",
            stem: "I still remember the way ___ she comforted the crying child.",
            options: ["in which", "where", "which", "what"], answer: 0,
            pointTag: "定语从句·the way in which",
            strategy: ["the way 后接定语从句，介词+which表方式，避免重复使用way", "the way in which = the way that，方式状语用 in which", "选 in which"],
            trap: "where只用于地点，the way不是地点，不能用where。", difficulty: 0.55),
        Question(id: "g35", module: .grammarFill, levelId: "L1",
            stem: "___ the new policy will succeed remains to be seen.",
            options: ["Whether", "That", "If", "What"], answer: 0,
            pointTag: "名词性从句·whether作主语",
            strategy: ["句首主语从句，且句末remains to be seen表'尚不确定'", "whether表'是否'，适合表达不确定的结果，且可用于句首", "选 Whether"],
            trap: "If 引导主语从句时不能放在句首，只能用whether。", difficulty: 0.6),
        Question(id: "g36", module: .grammarFill, levelId: "L1",
            stem: "Only when she finally read his letter ___ how much he had sacrificed for the family.",
            options: ["did she realize", "she realized", "she did realize", "did she realized"], answer: 0,
            pointTag: "倒装·only when+状语前置",
            strategy: ["Only when...位于句首触发主句部分倒装", "主句用助动词did提前+动词原形realize", "选 did she realize"],
            trap: "误用did she realized——倒装后跟的动词应为原形，不能再加-ed。", difficulty: 0.65),
        Question(id: "g37", module: .grammarFill, levelId: "L1",
            stem: "I wish I ___ (study) harder last term instead of wasting so much time playing games.",
            options: ["had studied", "studied", "would study", "have studied"], answer: 0,
            pointTag: "虚拟语气·wish+过去完成",
            strategy: ["wish后接与过去事实相反的虚拟，用过去完成时", "last term提示过去发生的事，是对过去的遗憾", "选 had studied"],
            trap: "误填studied(一般过去)——wish虚拟过去时态需用过去完成，而非简单过去。", difficulty: 0.6),
        Question(id: "g38", module: .grammarFill, levelId: "L1",
            stem: "He is no more capable of speaking French ___ I am of speaking Japanese.",
            options: ["than", "as", "that", "when"], answer: 0,
            pointTag: "比较结构·no more...than",
            strategy: ["no more...than 表'同样不'，是固定比较结构", "前后都是否定意味(他不会法语，我也不会日语)", "选 than"],
            trap: "误用as——no more搭配than，不与as连用。", difficulty: 0.6),
        Question(id: "g39", module: .grammarFill, levelId: "L1",
            stem: "The number of students who ___ interested in studying abroad has increased dramatically this year.",
            options: ["are", "is", "has", "have"], answer: 0,
            pointTag: "主谓一致·who引导从句内的一致",
            strategy: ["空格在who引导的定语从句内，先行词是students(复数)", "定语从句的动词要与先行词students保持一致，用are", "选 are"],
            trap: "易受The number of(单数)干扰误填is——但本空在who从句内，先行词是students不是number。", difficulty: 0.65),
        Question(id: "g40", module: .grammarFill, levelId: "L1",
            stem: "She looked at the broken vase ___ , unable to believe what had just happened.",
            options: ["disbelievingly", "disbelieving", "disbelief", "disbeliever"], answer: 0,
            pointTag: "词性转换·副词修饰动词",
            strategy: ["looked是动词，空格修饰动作方式，需要副词", "disbelievingly = 难以置信地，副词形式", "选 disbelievingly"],
            trap: "disbelieving是形容词/分词，不能直接修饰动词looked的方式。", difficulty: 0.6),
    ]

    // MARK: 完形填空 c31-c41

    static let cloze8: [Question] = [
        Question(id: "c31", module: .cloze, levelId: "L2",
            stem: "The bridge had been closed for repairs for months; ___, drivers had to take a long detour every day.",
            options: ["as a result", "for example", "in contrast", "meanwhile"], answer: 0,
            pointTag: "逻辑·因果",
            strategy: ["前因:桥关闭维修；后果:绕远路", "因果关系", "as a result = 因此"],
            trap: "in contrast表对比，与因果语境不符。", difficulty: 0.45),
        Question(id: "c32", module: .cloze, levelId: "L2",
            stem: "The new safety regulations aim to ___ the risk of accidents in the factory.",
            options: ["minimize", "minor", "minimum", "minimal"], answer: 0,
            pointTag: "词性辨析·动词minimize",
            strategy: ["空格在aim to后，需要动词原形", "minimize=使减到最小(动词)；minor/minimum/minimal都是形容词或名词", "选 minimize"],
            trap: "minimal/minor都是形容词，不能直接作aim to后的实义动词。", difficulty: 0.4),
        Question(id: "c33", module: .cloze, levelId: "L2",
            stem: "___ the heavy snowstorm, the marathon went ahead as scheduled without any delay.",
            options: ["Despite", "Because of", "Due to", "Owing to"], answer: 0,
            pointTag: "逻辑·让步despite",
            strategy: ["大雪 vs 照常进行→让步关系", "Despite = 尽管，表让步", "其余三个均表原因，逻辑相反"],
            trap: "Because of/Due to/Owing to都表原因，与'照常进行'的让步逻辑相反。", difficulty: 0.45),
        Question(id: "c34", module: .cloze, levelId: "L2",
            stem: "Her constant ___ to detail is what makes her reports so reliable.",
            options: ["attention", "intention", "attendance", "attempt"], answer: 0,
            pointTag: "名词辨析·attention to detail",
            strategy: ["attention to detail = 注重细节，固定搭配", "与'报告可靠'语义吻合", "排除形近词intention/attendance/attempt"],
            trap: "attendance(出席)/attempt(尝试)与detail搭配不成立，是形近词干扰。", difficulty: 0.4),
        Question(id: "c35", module: .cloze, levelId: "L2",
            stem: "Although the hotel room was small, it was clean and ___ , so we didn't complain.",
            options: ["comfortable", "crowded", "noisy", "shabby"], answer: 0,
            pointTag: "形容词辨析·语境正向",
            strategy: ["'没有抱怨'暗示整体感受正面", "comfortable(舒适的)与clean并列，语义一致为正面", "排除三个负面形容词"],
            trap: "crowded/noisy/shabby都是负面描述，与'没有抱怨'的语境矛盾。", difficulty: 0.4),
        Question(id: "c36", module: .cloze, levelId: "L2",
            stem: "The negotiations proceeded ___ , with both sides making one concession after another.",
            options: ["smoothly", "rapidly", "strictly", "narrowly"], answer: 0,
            pointTag: "副词辨析·smoothly",
            strategy: ["'双方相继让步'暗示进展顺利", "smoothly=顺利地，与让步的描述相符", "排除与语境不符的副词"],
            trap: "rapidly(快速地)与'相继让步'的渐进感不完全吻合，strictly/narrowly语义不搭。", difficulty: 0.5),
        Question(id: "c37", module: .cloze, levelId: "L2",
            stem: "The charity relies heavily ___ volunteers to keep its programs running.",
            options: ["on", "in", "for", "with"], answer: 0,
            pointTag: "固定搭配·rely on",
            strategy: ["rely on = 依赖，固定搭配", "charity依赖志愿者运转项目", "选 on"],
            trap: "rely in/for/with均不成立。", difficulty: 0.3),
        Question(id: "c38", module: .cloze, levelId: "L2",
            stem: "___ the weather forecast predicted rain, the school picnic was not cancelled.",
            options: ["Although", "Unless", "Once", "Whereas"], answer: 0,
            pointTag: "让步逻辑·although",
            strategy: ["天气预报有雨 vs 春游没取消→让步关系", "Although=尽管，表让步", "其余选项逻辑不符"],
            trap: "Unless(除非)/Once(一旦)与让步逻辑不符。", difficulty: 0.45),
        Question(id: "c39", module: .cloze, levelId: "L2",
            stem: "By the end of this month, the volunteers ___ over five hundred trees in the park.",
            options: ["will have planted", "plant", "planted", "will plant"], answer: 0,
            pointTag: "时态·将来完成时",
            strategy: ["By the end of this month提示将来某时间点之前完成的动作", "用将来完成时will have done", "选 will have planted"],
            trap: "will plant(一般将来)不能体现'到某时间点已完成'的含义。", difficulty: 0.55),
        Question(id: "c40", module: .cloze, levelId: "L2",
            stem: "___ how tired she felt, she always finished her homework before going to bed.",
            options: ["Regardless of", "Instead of", "Because of", "Except for"], answer: 0,
            pointTag: "介词短语·regardless of",
            strategy: ["regardless of = 不管，表让步", "'无论多累都坚持完成作业'体现让步语气", "选 Regardless of"],
            trap: "Because of表原因，与'尽管很累却坚持'的让步逻辑相反。", difficulty: 0.5),
        Question(id: "c41", module: .cloze, levelId: "L2",
            stem: "He remained ___ throughout the interview, even when asked some very difficult questions.",
            options: ["composed", "anxious", "confused", "irritated"], answer: 0,
            pointTag: "形容词辨析·情感正负",
            strategy: ["even when...提示尽管被问难题，仍保持某状态，与'被难住'相反", "composed=镇定的，符合'面对难题仍从容'的语境", "排除三个负面情绪词"],
            trap: "anxious/confused/irritated都是负面状态，与'remained...even when'暗示的'保持冷静'相反。", difficulty: 0.5),
    ]

    // MARK: 七选五 s31-s37

    static let sevenChoose8: [Question] = [
        Question(id: "s31", module: .sevenChoose, levelId: "L3",
            stem: "Many simple habits can improve memory. ___ For example, writing things down by hand helps information stick better than typing it.",
            options: ["One of the easiest is to engage multiple senses while learning.", "Memory cannot be trained at all.",
                      "Typing is the best way to remember things.", "Most people have naturally excellent memory."], answer: 0,
            pointTag: "衔接·For example 前的概括句",
            strategy: ["空后 For example 引出具体例子(手写记笔记)", "空处应是被例子支撑的概括性论点", "选'调动多种感官是最简单的方法之一'"],
            trap: "其余选项与后文'手写比打字更利于记忆'这一例子无法呼应。", difficulty: 0.55),
        Question(id: "s32", module: .sevenChoose, levelId: "L3",
            stem: "The old wooden bridge had not been inspected for over a decade. ___ As a result, the local government decided to close it immediately for safety reasons.",
            options: ["Engineers found several cracks in its main supports.", "The bridge had always been perfectly safe.",
                      "Many tourists enjoyed walking across it.", "The river beneath it had dried up completely."], answer: 0,
            pointTag: "衔接·As a result 前的起因句",
            strategy: ["空后 As a result 引出'立即关闭桥梁'的结果", "空处应是导致关闭的直接原因", "选'工程师发现主支撑结构有裂缝'"],
            trap: "选'桥一直很安全'与后文'立即关闭'的结果直接矛盾。", difficulty: 0.5),
        Question(id: "s33", module: .sevenChoose, levelId: "L3",
            stem: "The startup's first product failed to attract any customers. ___ However, the founders refused to give up and began redesigning it from scratch.",
            options: ["They could have simply shut the company down.", "The product became an instant hit nationwide.",
                      "Investors rushed to offer them more funding.", "The team celebrated their early success."], answer: 0,
            pointTag: "衔接·However 前的反向铺垫",
            strategy: ["空后 However 提示转折，'拒绝放弃'与前文应形成对比", "空处应铺垫一个'本可以......但没有'的反向选择", "选'他们本可以直接关闭公司'"],
            trap: "选'产品立刻爆红'与首句'未能吸引任何顾客'直接矛盾。", difficulty: 0.6),
        Question(id: "s34", module: .sevenChoose, levelId: "L3",
            stem: "Start by setting a realistic goal. Then break it into small, manageable steps. Finally, track your progress every week. ___",
            options: ["These three habits can help anyone build self-discipline.", "Self-discipline is impossible to learn.",
                      "Most people fail no matter what they try.", "Goals are usually a waste of time."], answer: 0,
            pointTag: "衔接·段尾总结句",
            strategy: ["前文列举了三个具体步骤(设定目标/分解/追踪)", "空处应是对这三个步骤的总结归纳", "选'这三个习惯能帮助任何人建立自律'"],
            trap: "其余选项否定了前文列举步骤的价值，与积极列举的语气矛盾。", difficulty: 0.5),
        Question(id: "s35", module: .sevenChoose, levelId: "L3",
            stem: "The museum recently acquired a 200-year-old painting. ___ It had been damaged by sunlight and needed weeks of repair work.",
            options: ["However, the painting was in poor condition.", "The museum is located downtown.",
                      "Many other paintings were already on display.", "The painting was donated by a local family."], answer: 0,
            pointTag: "衔接·it 指代一致",
            strategy: ["空后 It 指代某物，需在空处先引入这个'受损'的对象", "空格内容须与'被阳光损坏、需要数周修复'的描述呼应", "选'然而这幅画状况不佳'"],
            trap: "其余选项虽然合理，但与后句'它受损、需要修复'缺乏直接的指代呼应。", difficulty: 0.55),
        Question(id: "s36", module: .sevenChoose, levelId: "L3",
            stem: "The company launched its app in 2018 with only a few thousand users. ___ By last year, that number had grown to over ten million.",
            options: ["Growth was slow at first but steadily picked up speed.", "The app was shut down after just one year.",
                      "User numbers stayed exactly the same for years.", "The company switched to a completely different product."], answer: 0,
            pointTag: "衔接·数字增长对应",
            strategy: ["首句给出起点(几千用户)，空后给出终点(上千万)，需要承接增长的过程", "空处应描述这一增长趋势", "选'起初增长缓慢，但后来逐渐加快'"],
            trap: "选'应用一年后就关闭了'与后文'去年用户数已增长到一千万'直接矛盾。", difficulty: 0.55),
        Question(id: "s37", module: .sevenChoose, levelId: "L3",
            stem: "Plastic waste in the ocean breaks down into tiny pieces called microplastics. ___ These particles are now found in fish, salt, and even drinking water.",
            options: ["These pieces are nearly impossible to remove from the water.", "Ocean plastic has decreased significantly in recent years.",
                      "Fish never come into contact with plastic.", "Microplastics dissolve completely within days."], answer: 0,
            pointTag: "衔接·因果链+干扰项排除",
            strategy: ["空后'这些颗粒出现在鱼类、盐和饮用水中'说明微塑料难以清除、广泛存在", "空处应承接'微塑料难以去除'这一事实，引出后文的普遍存在", "排除与后文事实矛盾的选项"],
            trap: "选'塑料污染近年明显减少'或'微塑料几天内完全溶解'都与后文'广泛存在于鱼类/盐/饮用水'的事实矛盾。", difficulty: 0.6),
    ]

    // MARK: 阅读理解·记叙文(老琴师与徒弟) r50-r55

    private static let passageViolinMaker =
    "In a small workshop tucked behind a quiet street in Cremona, eighty-two-year-old Marco Bellini has spent " +
    "over six decades shaping wood into violins. Each instrument takes him nearly three months to complete, from " +
    "selecting the right piece of spruce to applying the final coat of varnish.\n\n" +
    "For years, Marco worked alone, insisting that violin-making could only be learned through endless repetition, " +
    "not through shortcuts. Last spring, however, he reluctantly agreed to take on an apprentice, a restless " +
    "nineteen-year-old named Elena who had dropped out of university to pursue woodworking.\n\n" +
    "At first, Marco gave her only the simplest tasks: sanding wood, cleaning tools, sweeping sawdust from the " +
    "floor. Elena grew frustrated, wondering when she would ever touch an actual violin. It was not until her " +
    "third month that Marco finally let her shape her first piece of wood, watching closely as her hands trembled " +
    "with nervous excitement.\n\n" +
    "What changed Marco's mind about teaching was not a sudden burst of patience, but a quiet realization: if no " +
    "one learned this craft, generations of knowledge built up over centuries would simply vanish. Elena, for her " +
    "part, came to understand that the months of seemingly pointless tasks had taught her something the textbooks " +
    "never could: patience, and respect for the material in her hands."

    static let reading8: [Question] = [
        Question(id: "r50", module: .reading, levelId: "L4",
            stem: passageViolinMaker + "\n\nWhich is the best title for the passage?",
            options: ["An Old Craftsman Finds a Reason to Teach", "How to Build a Violin in Three Months",
                      "University Life Versus Woodworking", "The History of Cremona's Workshops"], answer: 0,
            pointTag: "阅读·主旨·标题归纳",
            strategy: ["全文写Marco从拒绝教学到接受徒弟、并意识到传承的意义", "标题需概括人物转变与传承主题", "选'一位老工匠找到教学的理由'"],
            trap: "'如何三个月做出小提琴'只是细节描述，非主旨。", difficulty: 0.5),
        Question(id: "r51", module: .reading, levelId: "L4",
            stem: passageViolinMaker + "\n\nWhat was Elena's background before becoming an apprentice?",
            options: ["She had dropped out of university to pursue woodworking.", "She had studied violin-making in Cremona for years.",
                      "She was a professional violinist.", "She had inherited Marco's workshop."], answer: 0,
            pointTag: "阅读·细节定位",
            strategy: ["定位 a restless nineteen-year-old named Elena who had dropped out of university", "直接给出背景信息", "选'退学追求木工'"],
            trap: "其余选项均为原文未提及的编造细节。", difficulty: 0.35),
        Question(id: "r52", module: .reading, levelId: "L4",
            stem: passageViolinMaker + "\n\nWhy did Marco only give Elena simple tasks at first?",
            options: ["He believed the craft could only be learned through repetition and patience.", "He did not trust Elena's woodworking skills at all.",
                      "He wanted to test whether she would quit early.", "He had no real violin-making tasks available."], answer: 0,
            pointTag: "阅读·推理·动机",
            strategy: ["定位 insisting that violin-making could only be learned through endless repetition, not through shortcuts", "这是Marco一贯的教学理念，并非针对Elena的测试或不信任", "选'他认为这门手艺只能靠反复练习和耐心学会'"],
            trap: "'测试她是否会早早放弃'属于过度推断，原文强调的是教学理念而非考验意图。", difficulty: 0.6),
        Question(id: "r53", module: .reading, levelId: "L4",
            stem: passageViolinMaker + "\n\nThe word \"vanish\" in the fourth paragraph most likely means ___.",
            options: ["disappear completely", "become more valuable", "spread to other places", "improve over time"], answer: 0,
            pointTag: "阅读·词义猜测",
            strategy: ["语境:如果没人学习这门手艺，几百年积累的知识会怎样", "vanish与'消失'相关，对应generations of knowledge...vanish", "选 disappear completely"],
            trap: "其余选项均与'知识失传'的语境方向相反或无关。", difficulty: 0.45),
        Question(id: "r54", module: .reading, levelId: "L4",
            stem: passageViolinMaker + "\n\nHow did Elena feel during her first three months as an apprentice?",
            options: ["Frustrated, because she wanted to do more meaningful work.", "Confident, because she mastered the craft quickly.",
                      "Indifferent, because she didn't care about the outcome.", "Proud, because Marco praised her constantly."], answer: 0,
            pointTag: "阅读·态度推断",
            strategy: ["定位 Elena grew frustrated, wondering when she would ever touch an actual violin", "直接给出她当时的情绪状态", "选'感到沮丧，因为她想做更有意义的工作'"],
            trap: "其余选项均与原文'沮丧、急于上手'的描述不符。", difficulty: 0.4),
        Question(id: "r55", module: .reading, levelId: "L4",
            stem: passageViolinMaker + "\n\nWhat did Elena eventually learn from the months of simple tasks?",
            options: ["Patience and respect for the material she worked with.", "How to run a violin workshop on her own.",
                      "That woodworking was not the right career for her.", "How to sell violins to international customers."], answer: 0,
            pointTag: "阅读·细节·末段概括",
            strategy: ["定位末句 taught her something the textbooks never could: patience, and respect for the material", "直接给出她的收获", "选'耐心以及对材料的尊重'"],
            trap: "其余选项均为原文未提及的编造细节。", difficulty: 0.45),
    ]

    // MARK: 阅读理解·说明文(多任务的隐性代价) r56-r60

    private static let passageMultitasking =
    "Many people pride themselves on their ability to multitask, answering emails while on a phone call, or " +
    "scrolling through messages during a meeting. Yet decades of research in cognitive psychology suggest that " +
    "what we call multitasking is rarely what it seems.\n\n" +
    "In reality, the human brain cannot focus on two demanding tasks at the same moment. Instead, it rapidly " +
    "switches back and forth between them, a process researchers call \"task switching.\" Each switch, however " +
    "small, carries a hidden cost: it takes the brain a moment to disengage from one task and fully re-engage " +
    "with another.\n\n" +
    "These costs add up. Studies have found that people who frequently switch between tasks take significantly " +
    "longer to complete their work overall, compared with those who focus on one task at a time. Worse still, " +
    "the quality of the work often suffers, with more careless mistakes slipping through unnoticed.\n\n" +
    "Perhaps the most surprising finding is that heavy multitaskers often believe they are more productive than " +
    "they actually are. The constant sense of being busy creates an illusion of efficiency, even as actual " +
    "output quietly declines. Recognizing this gap between feeling productive and being productive may be the " +
    "first step toward working, and thinking, more clearly."

    static let reading8Part2: [Question] = [
        Question(id: "r56", module: .reading, levelId: "L4",
            stem: passageMultitasking + "\n\nWhat is the main idea of the passage?",
            options: ["Multitasking often costs more time and quality than people realize.", "Multitasking is the most efficient way to work.",
                      "The brain can easily handle several tasks at once.", "Task switching always improves the quality of work."], answer: 0,
            pointTag: "阅读·主旨·中心论点",
            strategy: ["首段引出'多任务并非看起来那样'，中间论证切换的隐性代价，末段指出'感觉高效'的错觉", "全文核心是'多任务的代价常被低估'", "选'多任务常常比人们以为的更耗时间和质量'"],
            trap: "其余选项与原文论证方向相反。", difficulty: 0.5),
        Question(id: "r57", module: .reading, levelId: "L4",
            stem: passageMultitasking + "\n\nAccording to the passage, what actually happens when people \"multitask\"?",
            options: ["The brain rapidly switches between tasks rather than handling them at once.", "The brain processes both tasks simultaneously without any cost.",
                      "The brain shuts down one task completely while doing the other.", "The brain becomes more efficient with each task switch."], answer: 0,
            pointTag: "阅读·细节定位",
            strategy: ["定位 it rapidly switches back and forth between them, a process researchers call task switching", "直接说明多任务的真实机制", "选'大脑在任务间快速切换'"],
            trap: "其余选项均与'同时处理'或'零代价'的错误印象相符，但与原文矛盾。", difficulty: 0.4),
        Question(id: "r58", module: .reading, levelId: "L4",
            stem: passageMultitasking + "\n\nWhat can be inferred about people who frequently switch between tasks?",
            options: ["They tend to take longer and make more mistakes than focused workers.", "They always finish their work faster than others.",
                      "They never make any careless mistakes.", "They are immune to the costs of task switching."], answer: 0,
            pointTag: "阅读·推理·细节综合",
            strategy: ["定位 take significantly longer...quality of the work often suffers, with more careless mistakes", "综合两点:更慢+更多错误", "选'比专注工作的人花更长时间、犯更多错误'"],
            trap: "其余选项与原文论证的'代价'方向相反。", difficulty: 0.55),
        Question(id: "r59", module: .reading, levelId: "L4",
            stem: passageMultitasking + "\n\nThe word \"illusion\" in the last paragraph refers to ___.",
            options: ["a false impression that doesn't match reality", "a scientific method for measuring productivity",
                      "a type of mental exercise", "an accurate measurement of output"], answer: 0,
            pointTag: "阅读·词义猜测",
            strategy: ["语境:'忙碌感'创造了一种效率的illusion，但实际产出却在下降", "illusion与'感觉与实际不符'相关", "选'与现实不符的错误印象'"],
            trap: "其余选项把illusion误解为真实的方法或准确的衡量，与'错觉'的核心含义相反。", difficulty: 0.5),
        Question(id: "r60", module: .reading, levelId: "L4",
            stem: passageMultitasking + "\n\nWhat does the author suggest as a first step toward clearer thinking?",
            options: ["Recognizing the gap between feeling productive and actually being productive.", "Multitasking even more frequently throughout the day.",
                      "Avoiding all forms of mental effort entirely.", "Measuring productivity only by how busy one feels."], answer: 0,
            pointTag: "阅读·推理·态度应用",
            strategy: ["定位末句 Recognizing this gap...may be the first step toward working, and thinking, more clearly", "直接给出作者建议的第一步", "选'认识到感觉高效和真正高效之间的差距'"],
            trap: "其余选项与作者论证的方向(减少多任务、关注真实产出)相反。", difficulty: 0.5),
    ]

    // MARK: 应用文·正文内容/语域细节补强 a35-a42

    static let applied8: [Question] = [
        Question(id: "a35", module: .appliedWriting, levelId: "L5",
            stem: "投诉信中举证产品问题，哪句最具体有力？",
            options: ["The phone's battery drained from full to zero within just two hours of light use.", "The phone's battery is not very good and dies fast.",
                      "The battery problem is quite serious and annoying.", "I think the battery has some kind of issue probably."], answer: 0,
            pointTag: "应用文·投诉信·具体证据",
            strategy: ["用具体数据(两小时内耗尽)替代笼统描述(不好、很快)", "具体证据比模糊抱怨更有说服力", "排除空泛、犹豫不定的表达"],
            trap: "'probably/quite serious'这类模糊表达缺乏说服力，投诉信需要具体可核实的细节。", difficulty: 0.5),
        Question(id: "a36", module: .appliedWriting, levelId: "L5",
            stem: "写求助信请教如何准备演讲比赛，哪句最能让对方快速理解你的具体困难？",
            options: ["I struggle most with controlling my nervousness when speaking in front of a large audience.", "I have some problems with the speech contest, please help.",
                      "Speech contest is hard for me, I don't know what to do.", "I need help about speaking, it's difficult somehow."], answer: 0,
            pointTag: "应用文·求助信·困难具体化",
            strategy: ["明确指出具体困难(在大观众前控制紧张)，而非笼统说'有问题'", "具体的困难描述让对方能给出针对性建议", "排除空泛、口语化的表达"],
            trap: "笼统的'有些问题/有点难'无法让对方知道具体该如何帮助。", difficulty: 0.5),
        Question(id: "a37", module: .appliedWriting, levelId: "L5",
            stem: "建议信中提出多条建议并排出优先级，哪句衔接最佳？",
            options: ["Of all these suggestions, improving the cafeteria's food quality should be addressed first.", "All these suggestions are good and should be done.",
                      "Many suggestions are here for you to think about.", "These are some ideas, pick what you like maybe."], answer: 0,
            pointTag: "应用文·建议信·优先级表达",
            strategy: ["Of all these suggestions...should be addressed first 明确点出优先级", "让建议信更有条理、更易被采纳", "排除笼统列举、缺乏轻重之分的表达"],
            trap: "'pick what you like maybe'语气随意，且没有体现建议的优先级排序。", difficulty: 0.5),
        Question(id: "a38", module: .appliedWriting, levelId: "L5",
            stem: "面向全校学生的通知，开头称呼哪种最规范？",
            options: ["To all students:", "Hey guys,", "Dear my friends,", "Hi everybody!"], answer: 0,
            pointTag: "应用文·通知称呼格式",
            strategy: ["正式通知的称呼应简洁规范，常用 To + 对象 + 冒号", "排除口语化的问候式称呼"],
            trap: "'Hey guys/Hi everybody'过于口语化，不符合正式通知的语域。", difficulty: 0.35),
        Question(id: "a39", module: .appliedWriting, levelId: "L5",
            stem: "感谢信开头提到'感谢你在我生病时的照顾'，结尾如何呼应最好？",
            options: ["I will always remember your kindness during those difficult days when I was ill.", "Thank you again, bye for now.",
                      "I hope you are also healthy now.", "Being sick was not a good experience for me."], answer: 0,
            pointTag: "应用文·感谢信·首尾呼应",
            strategy: ["结尾重提开头的具体情境(生病时的照顾)，形成呼应", "呼应使全文结构更完整、情感更连贯", "排除与开头情境无关的结尾"],
            trap: "'希望你也健康'/'生病不是好经历'都没有呼应开头'感谢照顾'这一核心内容。", difficulty: 0.55),
        Question(id: "a40", module: .appliedWriting, levelId: "L5",
            stem: "写信向交换生介绍本校社团活动，哪句信息最完整？",
            options: ["Our school has over twenty clubs, ranging from robotics to drama, that meet every Wednesday afternoon.", "Our school has clubs, they are good, you should join one.",
                      "There are many clubs here for students like sports ones.", "Clubs are fun and happen sometimes after class I think."], answer: 0,
            pointTag: "应用文·介绍信·信息完整",
            strategy: ["具体给出数量(二十多个)、举例(机器人/戏剧)、时间(周三下午)三类信息", "信息要素齐全比笼统描述更有效传达内容", "排除信息模糊、不确定的表达"],
            trap: "'sometimes/I think'这类不确定表达削弱了介绍信应有的清晰度。", difficulty: 0.5),
        Question(id: "a41", module: .appliedWriting, levelId: "L5",
            stem: "倡议书结尾号召大家行动，哪句最有感召力？",
            options: ["Let us all take one small step today and make our school a greener place to learn.", "People should maybe think about doing something green.",
                      "Green action is good, everyone knows that probably.", "Doing green things would be nice for school I guess."], answer: 0,
            pointTag: "应用文·倡议书·行动号召",
            strategy: ["Let us all + 具体行动(take one small step) 直接、有力地号召行动", "排除犹豫不定、缺乏行动指向的表达"],
            trap: "'maybe/probably/I guess'这类犹豫词削弱了倡议书应有的号召力。", difficulty: 0.5),
        Question(id: "a42", module: .appliedWriting, levelId: "L5",
            stem: "设计海报强调活动'限额报名，先到先得'，哪句表达最简洁有力？",
            options: ["Limited spots available, first come, first served!", "If you want to come, you can try to sign up sometime.",
                      "There might be some limit on how many people can join.", "Some spots may possibly run out eventually."], answer: 0,
            pointTag: "应用文·海报·简洁有力用词",
            strategy: ["海报语言要简短、有冲击力，避免冗长模糊的表达", "Limited spots...first come, first served 是英文海报的标准简洁表达", "排除冗长、含糊的选项"],
            trap: "'might/may possibly'等模糊词与海报需要的简洁感召力相悖。", difficulty: 0.45),
    ]

    // MARK: 读后续写·新技巧角度补强(二) k37-k44

    static let continuation8: [Question] = [
        Question(id: "k37", module: .continuation, levelId: "L6",
            stem: "想让内心独白与外部动作自然交织，描写'她犹豫着是否要敲门'，哪句最佳？",
            options: ["Her hand hovered over the door, every part of her screaming to just turn around and leave.", "She wanted to knock but also didn't want to, she was not sure.",
                      "She thought about knocking the door but was unsure really.", "Her hand was near door, she think maybe should not knock."], answer: 0,
            pointTag: "续写·内心独白与动作交织",
            strategy: ["hand hovered(外部动作)+ every part of her screaming(内心独白)自然融合在一句里", "用具体的身体动作呈现抽象的犹豫，而非直接说'不确定'", "排除直白陈述、语病句"],
            trap: "'she was not sure'直接说破犹豫，缺乏画面感，是续写最容易踩的'说明而非展示'陷阱。", difficulty: 0.6),
        Question(id: "k38", module: .continuation, levelId: "L6",
            stem: "想用短句制造紧迫感，描写'她必须马上做出选择'，哪种处理最佳？",
            options: ["No time to think. No time to doubt. She had to choose, now.", "She needed to make a choice very quickly without thinking too much about it.",
                      "There was not much time for her to think about the choice she needed to make.", "She had only a little time to decide what she was going to choose."], answer: 0,
            pointTag: "续写·短句节奏·紧迫感",
            strategy: ["连续的短句(No time to think. No time to doubt.)模拟急促的心跳与思维节奏", "短句堆叠比长句更能传递紧迫感", "排除冗长、节奏舒缓的长句"],
            trap: "其余选项虽语法正确，但句子冗长舒缓，与'紧迫感'的节奏需求不符。", difficulty: 0.6),
        Question(id: "k39", module: .continuation, levelId: "L6",
            stem: "想概括'接下来的几个月里她渐渐适应了新生活'，哪句最佳？",
            options: ["Slowly, over the following months, the unfamiliar streets began to feel like home.", "In the next few months, she got used to her new life little by little.",
                      "After some months passed, she became used to living there eventually.", "Some months later, her new life was not strange to her anymore."], answer: 0,
            pointTag: "续写·时间跨度概括句",
            strategy: ["unfamiliar streets...began to feel like home 用具体意象(街道变得熟悉)代替直白的'适应了'", "概括句仍需画面感，不能只是平铺时间和结论", "排除直白笼统的陈述"],
            trap: "'got used to/became used to'都是直白陈述，缺少续写需要的意象与画面。", difficulty: 0.55),
        Question(id: "k40", module: .continuation, levelId: "L6",
            stem: "想用长短句结合写出'她冲下楼梯，却在最后一级猛然停住'的节奏感，哪句最佳？",
            options: ["She raced down the stairs two at a time. Then, at the very last step, she froze.", "She ran down the stairs fast and then suddenly stopped at the last step suddenly.",
                      "She went down stairs quickly and stopped at last step very suddenly indeed.", "Running down the stairs, she stopped suddenly at the last step quickly."], answer: 0,
            pointTag: "续写·长短句节奏控制",
            strategy: ["前句稍长描写冲下楼梯的连续动作，后接极短句'she froze'制造突然定格的效果", "长短对比强化'冲'与'停'的反差", "排除重复使用suddenly、语病堆砌的选项"],
            trap: "重复使用'suddenly'(如第二、三个选项)显得啰嗦，削弱了突然定格的效果。", difficulty: 0.6),
        Question(id: "k41", module: .continuation, levelId: "L6",
            stem: "想从'他凝视窗外'自然过渡到环境描写，哪句衔接最佳？",
            options: ["He turned to the window, where the last leaves of autumn were letting go, one by one.", "He looked out of window and saw some leaves falling down outside.",
                      "Outside the window, there were leaves, and he was looking at them.", "He saw leaves outside while looking through the window glass."], answer: 0,
            pointTag: "续写·视角过渡·人物到环境",
            strategy: ["He turned to the window 引出视角转移，where引导的从句自然带入环境描写", "leaves letting go, one by one 用拟人化动词写景，呼应人物的心理状态", "排除平铺直叙、缺乏意象的选项"],
            trap: "其余选项只是客观陈述'看到了叶子'，没有借景物烘托人物心理的效果。", difficulty: 0.6),
        Question(id: "k42", module: .continuation, levelId: "L6",
            stem: "想用'沉默'本身制造戏剧张力，描写两人对视无言的瞬间，哪句最佳？",
            options: ["Neither of them spoke. The silence said more than words ever could.", "They did not say anything to each other for some time.",
                      "Nobody talked, it was quiet between them for a while.", "There was no talking, just silence between the two people."], answer: 0,
            pointTag: "续写·沉默的戏剧效果",
            strategy: ["The silence said more than words ever could 把'沉默'本身处理成有意义的'语言'", "用矛盾修辞强化沉默的张力，而非单纯陈述'没说话'", "排除平淡陈述沉默事实的选项"],
            trap: "其余选项只是客观描述'没人说话'，没有赋予沉默本身戏剧意义。", difficulty: 0.6),
        Question(id: "k43", module: .continuation, levelId: "L6",
            stem: "续写忌讳把动作流水账式罗列，下面哪种处理最有提炼感(描写'她准备出门')？",
            options: ["She grabbed her keys and was gone before the door had even finished closing.", "She found her keys, put on her shoes, opened the door, and then went out.",
                      "She got her keys, then her shoes, then opened door, then left the house.", "First she took keys, then shoes, then she opened the door and exited."], answer: 0,
            pointTag: "续写·避免流水账·提炼感",
            strategy: ["用'门还没关好人就已经走了'这一夸张细节浓缩'迅速出门'的整个过程", "提炼一个传神细节，胜过逐步罗列每个动作", "排除逐一罗列动作的流水账式选项"],
            trap: "其余选项都是'找钥匙→穿鞋→开门→出门'的逐步罗列，是典型的流水账写法，缺乏提炼。", difficulty: 0.6),
        Question(id: "k44", module: .continuation, levelId: "L6",
            stem: "想用层层递进的比喻写'她的紧张感越来越强烈'，哪句最佳？",
            options: ["The knot in her stomach tightened with every step, until it felt like a fist clenching around her lungs.", "She felt more and more nervous as she walked, very nervous indeed.",
                      "Her nervous feeling grew bigger and bigger the more she walked along.", "She was nervous, then very nervous, then extremely nervous quickly."], answer: 0,
            pointTag: "续写·比喻递进·情绪强化",
            strategy: ["knot tightening → fist clenching around her lungs 两个比喻层层递进，把抽象的紧张具象化", "用身体感受的比喻链条替代直白堆砌'nervous'", "排除直接重复nervous程度副词的选项"],
            trap: "反复堆砌'nervous/very nervous/extremely nervous'是直白的情绪标签，缺乏续写需要的意象与递进感。", difficulty: 0.65),
    ]

    // MARK: 听力·第十段·酒店预订对话 ln46-ln50

    private static let script10 =
    "M: Good afternoon, Lakeview Hotel, how may I help you? " +
    "W: Hi, I'd like to book a double room for this weekend, just Saturday night. " +
    "M: Let me check... we have a double room available for one hundred and twenty dollars a night, breakfast included. " +
    "W: That sounds good. Does the room have a view of the lake? " +
    "M: I'm afraid the lake-view rooms are already fully booked, but we do have a garden-view room at the same price. " +
    "W: That's fine. Oh, one more thing, is there a swimming pool at the hotel? " +
    "M: Yes, there is, but it's currently closed for maintenance and will reopen next Monday. " +
    "W: I see, that's a bit unfortunate, but I'll still take the room. Can I pay when I arrive? " +
    "M: Of course, you can pay at check-in. We'll see you Saturday, then."

    static let listening8b: [Question] = [
        Question(id: "ln46", module: .listening, levelId: "L7",
            stem: "What does the woman want to do?",
            listeningScript: script10,
            options: ["Book a double room for one night", "Cancel a previous reservation", "Ask about hotel job openings", "Complain about a previous stay"], answer: 0,
            pointTag: "听力·主旨判断",
            strategy: ["预判主旨题，激活book a room", "开头 I'd like to book a double room for this weekend, just Saturday night", "锁定'预订双人房一晚'"],
            trap: "后文提到游泳池/付款只是补充细节，核心需求是订房。", difficulty: 0.3),
        Question(id: "ln47", module: .listening, levelId: "L7",
            stem: "How much does the room cost per night?",
            listeningScript: script10,
            options: ["120 dollars", "100 dollars", "150 dollars", "80 dollars"], answer: 0,
            pointTag: "听力·数字信息",
            strategy: ["预判数字题，激活price表达", "听到 one hundred and twenty dollars a night", "锁定 120 dollars"],
            trap: "其余数字均为编造干扰项。", difficulty: 0.3),
        Question(id: "ln48", module: .listening, levelId: "L7",
            stem: "Why can't the woman get a lake-view room?",
            listeningScript: script10,
            options: ["The lake-view rooms are already fully booked", "The lake-view rooms cost extra money", "The hotel doesn't have any lake-view rooms", "The lake view is currently being repaired"], answer: 0,
            pointTag: "听力·原因捕捉",
            strategy: ["预判原因题，激活信号词I'm afraid", "听到 the lake-view rooms are already fully booked", "锁定'已被订满'"],
            trap: "其余选项都是合理但原文未提及的猜测。", difficulty: 0.4),
        Question(id: "ln49", module: .listening, levelId: "L7",
            stem: "What is the current situation with the swimming pool?",
            listeningScript: script10,
            options: ["It's closed for maintenance and will reopen next Monday", "It's open but very crowded", "It's permanently closed", "It's open only for hotel staff"], answer: 0,
            pointTag: "听力·细节捕捉",
            strategy: ["预判细节题，激活currently信号词", "听到 closed for maintenance and will reopen next Monday", "锁定'维护关闭，下周一重开'"],
            trap: "其余选项均为编造细节。", difficulty: 0.4),
        Question(id: "ln50", module: .listening, levelId: "L7",
            stem: "When will the woman pay for the room?",
            listeningScript: script10,
            options: ["When she checks in", "Right now over the phone", "One week in advance", "After she checks out"], answer: 0,
            pointTag: "听力·下一步行动预判",
            strategy: ["预判行动题，留意对话结尾的安排", "听到 Can I pay when I arrive?...Of course, you can pay at check-in", "锁定'入住时付款'"],
            trap: "行动题答案在对话最后，不能停在提问处就选。", difficulty: 0.4),
    ]

    // MARK: 听力·第十一段·校园运动会广播(独白) ln51-ln55

    private static let script11 =
    "Good morning, students. This is a quick reminder about our annual Sports Day this Thursday. Events will " +
    "begin at nine in the morning on the main field, rain or shine. If it does rain heavily, the event will be " +
    "moved indoors to the gymnasium instead. Each class should arrive by eight forty-five to set up their banners " +
    "and team areas. There will be a total of six events this year, including the new addition of a tug-of-war " +
    "competition, which students have been asking for since last year. Lunch will be provided for all participants " +
    "at no extra cost, but spectators should bring their own snacks. Please remember to wear comfortable sports " +
    "shoes, and apply sunscreen if the weather is sunny. We look forward to seeing everyone's team spirit on the " +
    "field this Thursday."

    static let listening9b: [Question] = [
        Question(id: "ln51", module: .listening, levelId: "L7",
            stem: "What is this announcement mainly about?",
            listeningScript: script11,
            options: ["A reminder about this Thursday's Sports Day", "A change in the exam schedule", "A new school dress code", "A request for volunteer teachers"], answer: 0,
            pointTag: "听力·主旨判断",
            strategy: ["预判主旨题，激活首句signal", "开头 This is a quick reminder about our annual Sports Day", "锁定'运动会提醒'"],
            trap: "后文提到的午餐/防晒只是细节，主题是运动会。", difficulty: 0.3),
        Question(id: "ln52", module: .listening, levelId: "L7",
            stem: "What will happen if it rains heavily?",
            listeningScript: script11,
            options: ["The event will be moved to the gymnasium", "The event will be cancelled completely", "The event will be postponed to next week", "The event will continue outdoors as planned"], answer: 0,
            pointTag: "听力·条件信息捕捉",
            strategy: ["预判条件题，激活if信号词", "听到 if it does rain heavily, the event will be moved indoors to the gymnasium", "锁定'移至体育馆'"],
            trap: "其余选项均与原文'移至室内'的安排不符。", difficulty: 0.4),
        Question(id: "ln53", module: .listening, levelId: "L7",
            stem: "What time should each class arrive?",
            listeningScript: script11,
            options: ["By eight forty-five", "By nine o'clock", "By eight o'clock", "By nine fifteen"], answer: 0,
            pointTag: "听力·数字信息",
            strategy: ["预判数字题，激活arrive by信号词", "听到 Each class should arrive by eight forty-five", "锁定 eight forty-five"],
            trap: "nine是活动正式开始时间，不是到场时间，容易混淆。", difficulty: 0.4),
        Question(id: "ln54", module: .listening, levelId: "L7",
            stem: "What is new about this year's Sports Day?",
            listeningScript: script11,
            options: ["A tug-of-war competition has been added", "The event has been moved to a new location", "Lunch is no longer provided", "The number of events has been reduced"], answer: 0,
            pointTag: "听力·细节捕捉",
            strategy: ["预判细节题，激活new addition信号词", "听到 the new addition of a tug-of-war competition", "锁定'新增拔河比赛'"],
            trap: "其余选项均与原文'新增项目/提供午餐'等细节相反或无关。", difficulty: 0.45),
        Question(id: "ln55", module: .listening, levelId: "L7",
            stem: "Who needs to bring their own snacks?",
            listeningScript: script11,
            options: ["Spectators", "All participants", "Teachers only", "No one, snacks are provided for everyone"], answer: 0,
            pointTag: "听力·细节定位",
            strategy: ["预判细节题，激活spectators信号词", "听到 spectators should bring their own snacks，而participants的午餐已提供", "锁定'观众需自带零食'"],
            trap: "participants(参与者)的午餐已包含，别与spectators(观众)搞混。", difficulty: 0.45),
    ]
}
