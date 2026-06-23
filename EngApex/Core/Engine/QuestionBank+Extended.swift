import Foundation

/// 二期扩充题（接入 QuestionBank.all）。每题带考点标签 + 解题决策树 + 陷阱。
extension QuestionBank {

    static let extended: [Question] =
        grammarFillExt + clozeExt + sevenChooseExt + readingExt + appliedExt + continuationExt

    // MARK: 语法填空 g5–g9

    static let grammarFillExt: [Question] = [
        Question(id: "g5", module: .grammarFill, levelId: "L1",
            stem: "By the time the guide arrived, most tourists ___ for over an hour.",
            options: ["have waited", "had waited", "were waiting", "wait"], answer: 1,
            pointTag: "时态·过去完成时",
            strategy: ["By the time + 过去动作，定下过去的时间基准", "等待发生在‘到达’之前→过去的过去", "用 had + 过去分词"],
            trap: "误用 have waited(现在完成)——基准时间在过去而非现在。", difficulty: 0.55),
        Question(id: "g6", module: .grammarFill, levelId: "L1",
            stem: "The scientist ___ research changed the whole field later won a major prize.",
            options: ["whose", "who", "which", "that"], answer: 0,
            pointTag: "定语从句·whose",
            strategy: ["先行词 scientist 与 research 是‘所属’关系", "表所属用 whose 引导定语从句", "whose research = 他的研究"],
            trap: "用 who 无法表达‘谁的研究’的所属关系。", difficulty: 0.6),
        Question(id: "g7", module: .grammarFill, levelId: "L1",
            stem: "She is good ___ solving problems under pressure.",
            options: ["at", "in", "for", "with"], answer: 0,
            pointTag: "固定搭配·be good at",
            strategy: ["be good ___ doing 固定搭配", "表‘擅长做某事’用 at", "good at solving"],
            trap: "be good in/for 不表‘擅长’。", difficulty: 0.35),
        Question(id: "g8", module: .grammarFill, levelId: "L1",
            stem: "If I ___ more time yesterday, I would have finished the report.",
            options: ["had had", "have", "had", "would have"], answer: 0,
            pointTag: "虚拟语气·对过去虚拟",
            strategy: ["主句 would have finished→对过去的虚拟", "if 从句用 had + 过去分词", "had had(第一个 had 是助动词)"],
            trap: "用 had(一般过去)不构成‘与过去事实相反’的虚拟。", difficulty: 0.7),
        Question(id: "g9", module: .grammarFill, levelId: "L1",
            stem: "Only when the lights went out ___ how tired he really was.",
            options: ["did he realize", "he realized", "he did realize", "realized he"], answer: 0,
            pointTag: "倒装·Only+状语置首",
            strategy: ["Only + 状语从句置于句首", "主句须部分倒装：助动词提到主语前", "did he realize"],
            trap: "Only 引导状语置首却不倒装(he realized)是典型错误。", difficulty: 0.7),
    ]

    // MARK: 完形填空 c5–c9

    static let clozeExt: [Question] = [
        Question(id: "c5", module: .cloze, levelId: "L2",
            stem: "The road was covered with ice; ___, the driver slowed down at once.",
            options: ["however", "therefore", "instead", "meanwhile"], answer: 1,
            pointTag: "逻辑·因果",
            strategy: ["前因:路面结冰；后果:减速", "因果关系", "therefore = 因此"],
            trap: "however 表转折，与因果语境不符。", difficulty: 0.4),
        Question(id: "c6", module: .cloze, levelId: "L2",
            stem: "After years of practice, he finally ___ his fear of speaking in public.",
            options: ["overcame", "took", "kept", "missed"], answer: 0,
            pointTag: "搭配·overcome fear",
            strategy: ["overcome one's fear 固定搭配=克服恐惧", "语境是‘最终战胜’", "overcame"],
            trap: "take/keep 不与 fear 搭配成‘克服’。", difficulty: 0.45),
        Question(id: "c7", module: .cloze, levelId: "L2",
            stem: "After months of training, the once-clumsy boy now moved with surprising ___.",
            options: ["grace", "fear", "anger", "doubt"], answer: 0,
            pointTag: "语境复现·反差",
            strategy: ["once-clumsy(曾经笨拙)与 now 形成反差", "训练后应朝正面发展", "grace = 优雅"],
            trap: "fear/anger 与‘训练后进步’的正向语境矛盾。", difficulty: 0.55),
        Question(id: "c8", module: .cloze, levelId: "L2",
            stem: "___ exhausted after the long march, she refused to give up.",
            options: ["Although", "Despite", "Because", "However"], answer: 0,
            pointTag: "让步·Although + 形容词",
            strategy: ["前后语义相反(累 vs 不放弃)→让步", "Although + (being)exhausted 可省略", "Although 引导让步状语"],
            trap: "Despite 后接名词/动名词，不直接接形容词从句。", difficulty: 0.5),
        Question(id: "c9", module: .cloze, levelId: "L2",
            stem: "The instructions were so ___ that everyone understood them at once.",
            options: ["clear", "vague", "complex", "strange"], answer: 0,
            pointTag: "语境·so…that 结果推因",
            strategy: ["so…that 结果:大家立刻看懂", "由结果反推说明很清晰", "clear"],
            trap: "vague/complex 会导致‘看不懂’，与结果矛盾。", difficulty: 0.4),
    ]

    // MARK: 七选五 s4–s8

    static let sevenChooseExt: [Question] = [
        Question(id: "s4", module: .sevenChoose, levelId: "L3",
            stem: "Time management is a skill worth learning. ___ As a result, they often feel less stressed before exams.",
            options: ["Students who plan their day get much more done.", "Nobody can manage time well.",
                      "Exams are always unfair.", "Sleeping late is a waste."], answer: 0,
            pointTag: "衔接·they 指代 + As a result",
            strategy: ["空后 they 需复数先行词", "As a result 承接因果", "选含复数主语(students)且与‘高效’一致的句"],
            trap: "选否定句会让 As a result 的积极结果失去前因。", difficulty: 0.55),
        Question(id: "s5", module: .sevenChoose, levelId: "L3",
            stem: "___ First, choose a quiet place. Then, set a clear goal for each session.",
            options: ["Here are some tips for studying effectively.", "Studying is always boring.",
                      "I failed my last exam.", "The music was too loud."], answer: 0,
            pointTag: "衔接·First/Then 指向总起句",
            strategy: ["空后 First…Then… 是分步列举", "空处应是引出这些步骤的总起句", "选‘以下是一些建议’"],
            trap: "选具体抱怨句无法统领后面的步骤列举。", difficulty: 0.5),
        Question(id: "s6", module: .sevenChoose, levelId: "L3",
            stem: "Many students fear making mistakes. ___ In fact, errors show us exactly what to improve.",
            options: ["But mistakes are a natural part of learning.", "Mistakes should always be hidden.",
                      "Teachers dislike too many questions.", "Reading aloud is useless."], answer: 0,
            pointTag: "衔接·But/In fact 转折",
            strategy: ["前句‘害怕犯错’与后句‘错误有用’相反", "空处用 But 承上转折", "选为错误正名的句子"],
            trap: "选‘错误该隐藏’与后句‘错误有用’自相矛盾。", difficulty: 0.6),
        Question(id: "s7", module: .sevenChoose, levelId: "L3",
            stem: "A balanced diet keeps us energetic. ___ For instance, fruits and vegetables provide the vitamins we need.",
            options: ["It also protects us from many illnesses.", "Junk food is hard to resist.",
                      "Nobody enjoys eating vegetables.", "Energy does not matter at all."], answer: 0,
            pointTag: "衔接·For instance 前的延续句",
            strategy: ["空后 For instance 举例支持‘饮食的好处’", "空处应继续陈述好处", "选‘还能预防疾病’"],
            trap: "选负面句会与后面的正面例证脱节。", difficulty: 0.55),
        Question(id: "s8", module: .sevenChoose, levelId: "L3",
            stem: "The school library has just been renovated. ___ It now offers quiet rooms for group study.",
            options: ["Students love spending their afternoons there.", "The old building was rather ugly.",
                      "It has been closed down for good.", "Printed books are too expensive."], answer: 0,
            pointTag: "衔接·there/It 指代一致",
            strategy: ["空后 It 指代 library，须保持话题一致", "空处应正面延续‘翻新后的图书馆’", "选 there 指图书馆的句子"],
            trap: "选‘永久关闭’与后句‘现在提供自习室’矛盾。", difficulty: 0.5),
    ]

    // MARK: 阅读理解 r5–r9（第二篇短文）

    private static let passage2 =
    "Li noticed that his school threw away hundreds of plastic bottles every week. Instead of complaining, " +
    "he started a recycling club. At first, only three students joined. But Li did not give up. He designed " +
    "colorful posters and gave a short talk in every class. Within a month, the club had fifty members, and " +
    "the school's waste dropped by half."

    static let readingExt: [Question] = [
        Question(id: "r5", module: .reading, levelId: "L4",
            stem: passage2 + "\n\nHow many students joined the club at first?",
            options: ["Three", "Fifty", "Hundreds", "Half"], answer: 0,
            pointTag: "细节·数字定位",
            strategy: ["回原文找 At first", "定位句:only three students joined", "选 Three"],
            trap: "fifty 是一个月后的数字，注意时间状语。", difficulty: 0.35),
        Question(id: "r6", module: .reading, levelId: "L4",
            stem: passage2 + "\n\nWhich is the best title for the passage?",
            options: ["A Student Who Made a Difference", "How to Make Colorful Posters",
                      "The History of Plastic Bottles", "A Boring Day at School"], answer: 0,
            pointTag: "主旨·标题归纳",
            strategy: ["全文围绕 Li 发起回收、带来改变", "标题需概括人物与主题", "选‘一个带来改变的学生’"],
            trap: "‘如何做海报’只是细节手段，非主旨。", difficulty: 0.55),
        Question(id: "r7", module: .reading, levelId: "L4",
            stem: passage2 + "\n\nWhat can we learn about Li from the passage?",
            options: ["He was determined.", "He was lazy.", "He disliked his school.", "He gave up easily."], answer: 0,
            pointTag: "推理·人物品质",
            strategy: ["原文 did not give up / 设计海报 / 每班演讲", "据行为推断品质", "determined = 有决心"],
            trap: "gave up easily 与原文‘did not give up’直接相反。", difficulty: 0.5),
        Question(id: "r8", module: .reading, levelId: "L4",
            stem: passage2 + "\n\nThe underlined word \"dropped\" most likely means ___.",
            options: ["fell", "rose", "stayed the same", "spread out"], answer: 0,
            pointTag: "词义猜测·语境",
            strategy: ["waste dropped by half = 垃圾减半", "dropped 在此=下降", "选 fell"],
            trap: "rose 意为上升，与‘减半’矛盾。", difficulty: 0.45),
        Question(id: "r9", module: .reading, levelId: "L4",
            stem: passage2 + "\n\nWhy did Li give a talk in every class?",
            options: ["To attract more members", "To cancel the club",
                      "To complain to teachers", "To sell the bottles"], answer: 0,
            pointTag: "推理·目的",
            strategy: ["演讲后 within a month 成员增至五十", "由结果反推目的=招募", "选 attract more members"],
            trap: "原文没有‘抱怨/卖瓶子’的意图，属臆造。", difficulty: 0.5),
    ]

    // MARK: 应用文 a4–a6

    static let appliedExt: [Question] = [
        Question(id: "a4", module: .appliedWriting, levelId: "L5",
            stem: "向校刊投稿介绍中国茶文化，下列开头哪句最合适？",
            options: ["I'd like to share something about Chinese tea culture with our readers.",
                      "Tea is tea, you know.", "You should read about tea now.", "I write tea today."], answer: 0,
            pointTag: "应用文·投稿开头",
            strategy: ["投稿需点明主题且语域得体", "I'd like to share … with our readers 框架规范", "排除口语化/语法错"],
            trap: "‘I write tea today’ 语法与表意都不成立。", difficulty: 0.4),
        Question(id: "a5", module: .appliedWriting, levelId: "L5",
            stem: "想自然过渡到信中的第二个理由，哪个衔接更得体？",
            options: ["What's more, the activity will build our teamwork.",
                      "Also activity good for us.", "Second thing is teamwork.", "And teamwork too."], answer: 0,
            pointTag: "应用文·过渡衔接 What's more",
            strategy: ["补充论点用 What's more / In addition", "后接完整句，结构正确", "What's more, …"],
            trap: "‘Second thing is’ 生硬，且非地道过渡。", difficulty: 0.45),
        Question(id: "a6", module: .appliedWriting, levelId: "L5",
            stem: "信件结尾想表达期待回复，哪句最佳？",
            options: ["I'm looking forward to hearing from you soon.",
                      "Reply me fast please.", "You must reply.", "Wait your letter."], answer: 0,
            pointTag: "应用文·结尾礼貌句",
            strategy: ["look forward to + doing 固定结构", "hear from sb = 收到某人来信", "语域礼貌正式"],
            trap: "‘Reply me’ 缺介词且语气生硬(应为 reply to me)。", difficulty: 0.35),
    ]

    // MARK: 读后续写 k4–k6

    static let continuationExt: [Question] = [
        Question(id: "k4", module: .continuation, levelId: "L6",
            stem: "把‘他很开心’升级为高分描写，选哪句？",
            options: ["A wave of joy washed over him as he read the letter.",
                      "He was very very happy.", "He felt happy and happy.", "He was so happy in his heart."], answer: 0,
            pointTag: "续写·化情绪为画面",
            strategy: ["用‘情绪如浪涌来’的意象替代直白 happy", "A wave of joy washed over him 经典高分句", "排除堆叠/口语"],
            trap: "‘very very happy’ 重复且低级，不加分。", difficulty: 0.6),
        Question(id: "k5", module: .continuation, levelId: "L6",
            stem: "想生动描写‘他冲向终点’，哪句最佳？",
            options: ["He sprinted toward the finish line, his lungs burning.",
                      "He ran to the end very fast.", "He went to the finish quickly.", "He run to the finish line."], answer: 0,
            pointTag: "续写·精准动词+身体感受",
            strategy: ["sprint 比 run fast 更精准有力", "his lungs burning 补身体感受，画面感强", "排除笼统/语法错(run)"],
            trap: "‘run to’ 主谓不一致(应 ran)，且表达平淡。", difficulty: 0.6),
        Question(id: "k6", module: .continuation, levelId: "L6",
            stem: "续写结尾想点题‘坚持的意义’，哪句最能升华？",
            options: ["At that moment, he understood that every effort had been worth it.",
                      "The end. He was happy.", "So he went home and slept.", "Then nothing happened again."], answer: 0,
            pointTag: "续写·结尾升华点题",
            strategy: ["结尾宜由情节升华到感悟", "用 understood that … 收束主题(坚持的意义)", "排除草草收尾/无意义句"],
            trap: "‘回家睡觉’把情感主题落空，不点题。", difficulty: 0.6),
    ]
}
