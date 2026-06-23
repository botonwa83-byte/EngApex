import Foundation

/// 二期扩充题（第三批）。补齐语法填空缺失子考点 + 第四篇阅读，客观题各关推到 ~18-20 题。
extension QuestionBank {

    static let extended3: [Question] =
        grammarFill3 + cloze3 + sevenChoose3 + reading3 + applied3 + continuation3

    // MARK: 语法填空 g16–g20（补：情态动词/冠词/形式主语/时态/代词）

    static let grammarFill3: [Question] = [
        Question(id: "g16", module: .grammarFill, levelId: "L1",
            stem: "The light in her office is still on; she ___ be working late tonight.",
            options: ["must", "can", "need", "shall"], answer: 0,
            pointTag: "情态动词·肯定推测 must",
            strategy: ["有确凿依据(灯还亮着)作肯定推测", "must + 动词原形 = 一定", "选 must"],
            trap: "can 表能力/可能性，不用于此处的肯定推测。", difficulty: 0.5),
        Question(id: "g17", module: .grammarFill, levelId: "L1",
            stem: "What ___ useful piece of advice your teacher gave you!",
            options: ["a", "an", "the", "/"], answer: 0,
            pointTag: "冠词·a/an 看读音",
            strategy: ["useful 以辅音音素 /j/ 开头", "辅音音素前用 a", "a useful piece"],
            trap: "凭字母 u 误用 an——要看读音不是字母。", difficulty: 0.55),
        Question(id: "g18", module: .grammarFill, levelId: "L1",
            stem: "___ is no use crying over spilt milk; just move on.",
            options: ["It", "That", "This", "There"], answer: 0,
            pointTag: "形式主语 it",
            strategy: ["It is no use doing sth 固定句型", "it 作形式主语，真正主语是 crying…", "选 It"],
            trap: "There is no use 不成立；真正主语是动名词。", difficulty: 0.5),
        Question(id: "g19", module: .grammarFill, levelId: "L1",
            stem: "They ___ for the bus for half an hour, and it still hasn't arrived.",
            options: ["have been waiting", "waited", "are waiting", "will wait"], answer: 0,
            pointTag: "时态·现在完成进行",
            strategy: ["动作从过去持续到现在且仍在继续", "for half an hour + still hasn't = 持续未停", "用现在完成进行 have been waiting"],
            trap: "一般过去 waited 体现不出‘持续到现在仍在等’。", difficulty: 0.55),
        Question(id: "g20", module: .grammarFill, levelId: "L1",
            stem: "Through online videos, she taught ___ to play the guitar.",
            options: ["herself", "her", "hers", "she"], answer: 0,
            pointTag: "反身代词",
            strategy: ["动作的发出者与承受者是同一人", "用反身代词 herself", "teach oneself = 自学"],
            trap: "用宾格 her 指代他人，改变了句意。", difficulty: 0.4),
    ]

    // MARK: 完形填空 c16–c18

    static let cloze3: [Question] = [
        Question(id: "c16", module: .cloze, levelId: "L2",
            stem: "The project finally succeeded, ___ the whole team's joint effort.",
            options: ["thanks to", "instead of", "regardless of", "apart from"], answer: 0,
            pointTag: "介词短语·thanks to",
            strategy: ["成功的原因是团队努力", "thanks to = 多亏、由于", "选 thanks to"],
            trap: "instead of(而不是)/regardless of(不顾) 逻辑相反。", difficulty: 0.5),
        Question(id: "c17", module: .cloze, levelId: "L2",
            stem: "His ___ for music drove him to practice six hours a day.",
            options: ["passion", "doubt", "fear", "boredom"], answer: 0,
            pointTag: "名词辨析·语境正向",
            strategy: ["每天苦练六小时→强烈的热爱", "passion for = 对…的热情", "排除负面名词"],
            trap: "doubt/fear 无法解释‘主动苦练’的动机。", difficulty: 0.5),
        Question(id: "c18", module: .cloze, levelId: "L2",
            stem: "A few words of praise from the teacher greatly ___ the shy boy's confidence.",
            options: ["boosted", "reduced", "ignored", "doubted"], answer: 0,
            pointTag: "动词辨析·语境",
            strategy: ["表扬对自信的作用是正向的", "boost one's confidence = 增强自信", "选 boosted"],
            trap: "reduced(降低)与‘表扬’的积极作用矛盾。", difficulty: 0.5),
    ]

    // MARK: 七选五 s15–s16

    static let sevenChoose3: [Question] = [
        Question(id: "s15", module: .sevenChoose, levelId: "L3",
            stem: "___ For example, keeping a tidy desk helps you concentrate on your work.",
            options: ["A good study environment matters more than you think.", "A messy room is perfectly fine.",
                      "I really dislike studying at home.", "Desks are far too expensive these days."], answer: 0,
            pointTag: "衔接·For example 指向总起句",
            strategy: ["空后举‘整洁书桌’的例子", "空处是被例证支撑的总起观点", "选‘学习环境很重要’"],
            trap: "选‘凌乱也没关系’与后面的正面例子冲突。", difficulty: 0.5),
        Question(id: "s16", module: .sevenChoose, levelId: "L3",
            stem: "Many people set new goals every January. ___ However, only a few actually keep them.",
            options: ["They are full of motivation at the very start.", "Goals are completely pointless.",
                      "Nobody ever sets any goals.", "January is a very cold month."], answer: 0,
            pointTag: "衔接·They 指代 + However 转折",
            strategy: ["空后 They 指代 many people", "However 转折到‘很少坚持’", "空处应说‘起初满怀干劲’"],
            trap: "选‘目标无意义’与后句的转折逻辑断裂。", difficulty: 0.6),
    ]

    // MARK: 阅读理解 r16–r20（第四篇短文）

    private static let passage4 =
    "A small bookstore in the old town was about to close. Sales had fallen for years, and the owner, Mr. Chen, " +
    "could no longer afford the rent. When the news spread online, something unexpected happened. Former customers, " +
    "many now living far away, sent letters, shared old memories, and ordered books by mail. Within two weeks, the shop " +
    "sold more books than it had in the past six months. \"I thought people had forgotten us,\" Mr. Chen said, wiping his eyes. \"I was wrong.\""

    static let reading3: [Question] = [
        Question(id: "r16", module: .reading, levelId: "L4",
            stem: passage4 + "\n\nWhy was the bookstore about to close?",
            options: ["Falling sales and unaffordable rent", "It was always too crowded",
                      "Mr. Chen wanted to retire", "A fire had damaged it"], answer: 0,
            pointTag: "细节·原因定位",
            strategy: ["回原文找关闭原因", "定位:Sales had fallen…could no longer afford the rent", "选 Falling sales and unaffordable rent"],
            trap: "其余选项原文均无依据。", difficulty: 0.4),
        Question(id: "r17", module: .reading, levelId: "L4",
            stem: passage4 + "\n\nWhat did former customers do after the news spread online?",
            options: ["Sent letters and ordered books by mail", "Asked the shop for refunds",
                      "Ignored the news completely", "Opened a rival bookstore"], answer: 0,
            pointTag: "细节·定位",
            strategy: ["回原文 When the news spread", "定位:sent letters…ordered books by mail", "选第一项"],
            trap: "‘要求退款/开竞品店’原文未提及。", difficulty: 0.4),
        Question(id: "r18", module: .reading, levelId: "L4",
            stem: passage4 + "\n\nHow did Mr. Chen most likely feel at the end?",
            options: ["Moved and grateful", "Angry and bitter", "Bored and tired", "Calm and indifferent"], answer: 0,
            pointTag: "推理·情感态度",
            strategy: ["wiping his eyes + ‘I was wrong’", "被顾客的支持打动", "选 Moved and grateful"],
            trap: "擦眼泪在此是感动落泪，非愤怒。", difficulty: 0.55),
        Question(id: "r19", module: .reading, levelId: "L4",
            stem: passage4 + "\n\nWhat is the main message of the passage?",
            options: ["Community support can save what people truly value", "Bookstores are hopelessly outdated",
                      "Online shopping ruins small shops", "Old towns are always quiet"], answer: 0,
            pointTag: "主旨·归纳",
            strategy: ["老顾客自发相助让书店重生", "主题=社区/人情的力量", "选‘社区支持能挽救珍视之物’"],
            trap: "‘网购毁掉小店’与正面结局相反。", difficulty: 0.6),
        Question(id: "r20", module: .reading, levelId: "L4",
            stem: passage4 + "\n\nThe phrase \"something unexpected happened\" refers to ___.",
            options: ["customers rushing to support the shop", "the shop closing the very next day",
                      "the rent suddenly rising", "the owner leaving the town"], answer: 0,
            pointTag: "词义/指代·语境",
            strategy: ["看其后具体说明", "下文:老顾客寄信、买书相助", "‘意想不到的事’即顾客踊跃支持"],
            trap: "选‘关门/涨租’与下文的暖心情节矛盾。", difficulty: 0.55),
    ]

    // MARK: 应用文 a13–a15

    static let applied3: [Question] = [
        Question(id: "a13", module: .appliedWriting, levelId: "L5",
            stem: "因故无法赴约，写信致歉，开头哪句最得体？",
            options: ["I'm writing to apologize for not being able to make it to your party.",
                      "Sorry I can't come.", "I can't come, sorry you.", "Apologize to you now."], answer: 0,
            pointTag: "应用文·道歉信开头",
            strategy: ["apologize for (not) doing 固定框架", "点明致歉事由", "排除口语化/语法错"],
            trap: "‘sorry you’ 不成句，语域过随意。", difficulty: 0.45),
        Question(id: "a14", module: .appliedWriting, levelId: "L5",
            stem: "介绍活动安排，自然列举第二项，哪句最佳？",
            options: ["In addition, we will visit the local science museum in the afternoon.",
                      "Two is the museum.", "Also museum we go.", "And museum too go there."], answer: 0,
            pointTag: "应用文·In addition 列举",
            strategy: ["补充信息用 In addition / Besides", "后接完整句，结构正确", "排除残缺/语病句"],
            trap: "‘Two is the museum’ 中式直译，不成文。", difficulty: 0.45),
        Question(id: "a15", module: .appliedWriting, levelId: "L5",
            stem: "回信接受对方邀请，哪句最得体？",
            options: ["I would be delighted to accept your kind invitation.",
                      "Ok I come.", "Yes invitation accept.", "I accept you invite."], answer: 0,
            pointTag: "应用文·接受邀请句",
            strategy: ["be delighted to accept… 礼貌且正式", "kind invitation 体现礼貌", "排除口语/语法错"],
            trap: "‘I accept you invite’ 语法错误且生硬。", difficulty: 0.45),
    ]

    // MARK: 读后续写 k13–k15

    static let continuation3: [Question] = [
        Question(id: "k13", module: .continuation, levelId: "L6",
            stem: "用比喻把‘她的笑容’写得更生动，选哪句？",
            options: ["Her smile was like sunshine breaking through the clouds.",
                      "Her smile was very nice.", "She smiled nicely and good.", "Her smile is good like sun."], answer: 0,
            pointTag: "续写·比喻修辞",
            strategy: ["用 like + 意象(阳光破云)作比喻", "化抽象的‘笑’为可感画面", "排除直白/语病"],
            trap: "‘very nice’ 平淡，毫无画面感。", difficulty: 0.6),
        Question(id: "k14", module: .continuation, levelId: "L6",
            stem: "续写结尾想留下悬念，哪句最佳？",
            options: ["As the train pulled away, a single question lingered in her mind.",
                      "The train went away. She thought a lot.", "Then she thought about it on the train.", "The train left and she had a question maybe."], answer: 0,
            pointTag: "续写·悬念结尾",
            strategy: ["用未解的疑问留白制造悬念", "lingered in her mind 含蓄有余味", "排除平铺/含糊句"],
            trap: "‘想了很多’说尽反而失去悬念。", difficulty: 0.6),
        Question(id: "k15", module: .continuation, levelId: "L6",
            stem: "写‘全场爆发欢呼’更有感染力，选哪句？",
            options: ["The whole crowd burst into cheers, their voices echoing through the hall.",
                      "Everyone was happy and cheered.", "The crowd cheered very loudly much.", "People in the hall cheered for him."], answer: 0,
            pointTag: "续写·群体反应烘托",
            strategy: ["burst into cheers 写爆发感", "their voices echoing 补声音细节", "用群体反应烘托高潮"],
            trap: "‘cheered very loudly much’ 堆叠副词，不地道。", difficulty: 0.6),
    ]
}
