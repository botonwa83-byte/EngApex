import Foundation

/// 题库。每题带考点标签 + 解题决策树 + 陷阱。每题型已扩充到 ~30 题。
enum QuestionBank {

    static let all: [Question] = {
        var result: [Question] = []
        result += grammarFill
        result += cloze
        result += sevenChoose
        result += reading
        result += applied
        result += continuation
        result += extended
        result += extended2
        result += extended3
        result += extended4
        result += extended5
        result += listening
        return result
    }()

    static func byLevel(_ levelId: String) -> [Question] {
        all.filter { $0.levelId == levelId }
    }
    static func find(_ id: String) -> Question? { all.first { $0.id == id } }

    // MARK: 语法填空（规则最强，主线第一关）

    static let grammarFill: [Question] = [
        Question(id: "g1", module: .grammarFill, levelId: "L1",
            stem: "It was not until midnight ___ the firefighters brought the blaze under control.",
            options: ["that", "when", "which", "then"], answer: 0,
            pointTag: "强调句·not until",
            strategy: ["识别 It was ... that 强调结构", "被强调的是时间状语 not until midnight", "强调句连接词只用 that，不用 when"],
            trap: "看到时间就填 when——强调句一律填 that。", difficulty: 0.6),
        Question(id: "g2", module: .grammarFill, levelId: "L1",
            stem: "___ from the hilltop, the village looks like a painting.",
            options: ["Seen", "Seeing", "To see", "See"], answer: 0,
            pointTag: "非谓语·过去分词",
            strategy: ["找逻辑主语：the village", "village 与 see 是被动关系", "被动用过去分词 Seen"],
            trap: "误填 Seeing（主动）——村庄是被看，不是去看。", difficulty: 0.55),
        Question(id: "g3", module: .grammarFill, levelId: "L1",
            stem: "Neither the teacher nor the students ___ aware of the schedule change.",
            options: ["was", "were", "is", "being"], answer: 1,
            pointTag: "主谓一致·就近原则",
            strategy: ["neither...nor 连接两个主语", "谓语与最近的主语 students 一致", "students 复数→were"],
            trap: "按 teacher 取单数 was——就近原则看最后一个名词。", difficulty: 0.5),
        Question(id: "g4", module: .grammarFill, levelId: "L1",
            stem: "___ hard he tried, he could not work out the puzzle.",
            options: ["However", "Whatever", "No matter", "Although"], answer: 0,
            pointTag: "让步状语·however",
            strategy: ["空后紧跟 adj/adv (hard)", "However + adj/adv + 主谓 = 无论多么…", "No matter 需配 how"],
            trap: "填 No matter 后面缺 how；Although 不接 hard 倒装。", difficulty: 0.6),
    ]

    // MARK: 完形填空

    static let cloze: [Question] = [
        Question(id: "c1", module: .cloze, levelId: "L2",
            stem: "She had prepared for weeks; ___, she still felt nervous before the speech.",
            options: ["therefore", "however", "besides", "otherwise"], answer: 1,
            pointTag: "逻辑·转折",
            strategy: ["前句：准备充分；后句：依然紧张", "语义相反→转折", "选 however"],
            trap: "therefore 表因果，与‘依然紧张’矛盾。", difficulty: 0.45),
        Question(id: "c2", module: .cloze, levelId: "L2",
            stem: "The volunteers made every ___ to comfort the survivors after the flood.",
            options: ["effort", "mistake", "promise", "excuse"], answer: 0,
            pointTag: "固定搭配·make every effort",
            strategy: ["make every ___ to do 固定搭配", "语境是尽力安慰", "effort = 努力"],
            trap: "promise 不与 make every 搭配成‘尽力’。", difficulty: 0.5),
        Question(id: "c3", module: .cloze, levelId: "L2",
            stem: "The boy was about to give up, but his coach's ___ words made him try once more.",
            options: ["harsh", "encouraging", "careless", "empty"], answer: 1,
            pointTag: "语境复现",
            strategy: ["后文 made him try once more = 被鼓励", "形容词须与‘再试一次’同向", "encouraging"],
            trap: "harsh/careless 与‘再试一次’的积极结果矛盾。", difficulty: 0.5),
        Question(id: "c4", module: .cloze, levelId: "L2",
            stem: "Not only did she finish the project ahead of time, ___ she also trained two newcomers.",
            options: ["and", "but", "so", "for"], answer: 1,
            pointTag: "关联词·not only…but also",
            strategy: ["句首 Not only 倒装", "固定关联 not only…but also", "选 but"],
            trap: "not only 不与 and 搭配。", difficulty: 0.55),
    ]

    // MARK: 七选五（建模为：选最契合上下文衔接的句子）

    static let sevenChoose: [Question] = [
        Question(id: "s1", module: .sevenChoose, levelId: "L3",
            stem: "___ For example, doing twenty minutes of exercise a day improves both body and mood.",
            options: ["Good habits benefit us in many ways.", "Exercise can be dangerous.",
                      "I am not a morning person.", "The weather is fine today."], answer: 0,
            pointTag: "衔接·For example 指向总起句",
            strategy: ["空后 For example 引出例证", "空处应是被举例支撑的总起观点", "选概括性主题句"],
            trap: "选具体句会与后面的 For example 重复举例。", difficulty: 0.5),
        Question(id: "s2", module: .sevenChoose, levelId: "L3",
            stem: "Tourists flock to the Great Wall every year. ___ Many of them climb to the highest watchtower for a better view.",
            options: ["They come from all over the world.", "The wall was built long ago.",
                      "Few people have heard of it.", "It is closed to visitors."], answer: 0,
            pointTag: "衔接·them 指代",
            strategy: ["空后 Many of them 需要复数先行词", "them 指代‘游客’", "选含游客且复数的句子"],
            trap: "选‘城墙建造’会让 them 失去指代对象。", difficulty: 0.55),
        Question(id: "s3", module: .sevenChoose, levelId: "L3",
            stem: "Reading widens our view of the world. ___ However, too much screen reading may tire the eyes.",
            options: ["It also builds our vocabulary over time.", "Nobody likes reading.",
                      "Screens are always harmful.", "Books are out of date."], answer: 0,
            pointTag: "衔接·However 前后对比",
            strategy: ["空后 However 表转折", "空处应延续‘阅读的好处’，与后句形成对比", "选正面好处句"],
            trap: "选负面句会与 However 后的负面句重复，失去转折。", difficulty: 0.6),
    ]

    // MARK: 阅读理解（短文 + 四题型）

    private static let readingPassage =
    "When Maria moved to a new town, she knew no one. Instead of staying home, she joined a community garden. " +
    "Every Saturday she planted vegetables beside her neighbors. Slowly, strangers became friends, and the once-quiet newcomer " +
    "found herself laughing over shared tomatoes. The garden gave her more than food—it gave her a place to belong."

    static let reading: [Question] = [
        Question(id: "r1", module: .reading, levelId: "L4",
            stem: readingPassage + "\n\nWhat did Maria do every Saturday?",
            options: ["Stayed at home alone", "Planted vegetables with neighbors",
                      "Travelled to another town", "Sold tomatoes at a market"], answer: 1,
            pointTag: "细节·定位",
            strategy: ["回原文找 Every Saturday", "定位句：planted vegetables beside her neighbors", "同义改写 with neighbors"],
            trap: "‘sold tomatoes’ 是过度推断，原文是 shared。", difficulty: 0.4),
        Question(id: "r2", module: .reading, levelId: "L4",
            stem: readingPassage + "\n\nThe passage is mainly about ___.",
            options: ["how to grow tomatoes", "how Maria found a sense of belonging",
                      "the history of community gardens", "why gardening is hard work"], answer: 1,
            pointTag: "主旨·归纳",
            strategy: ["抓首尾句与高频词 friends/belong", "全文围绕‘融入新环境’", "选含‘归属感’的概括项"],
            trap: "‘how to grow tomatoes’ 只是细节，非主旨。", difficulty: 0.6),
        Question(id: "r3", module: .reading, levelId: "L4",
            stem: readingPassage + "\n\nWe can infer that before joining the garden, Maria felt ___.",
            options: ["lonely", "proud", "bored with gardening", "angry at her neighbors"], answer: 0,
            pointTag: "推理·有据",
            strategy: ["原文 knew no one / once-quiet newcomer", "推断初到时孤独", "选 lonely，且有原文支撑"],
            trap: "推理不能脱离原文——angry 无任何依据。", difficulty: 0.6),
        Question(id: "r4", module: .reading, levelId: "L4",
            stem: readingPassage + "\n\nThe underlined phrase \"a place to belong\" most likely means ___.",
            options: ["a piece of land she bought", "a feeling of being accepted",
                      "a job in the town", "a house near the garden"], answer: 1,
            pointTag: "词义猜测·语境",
            strategy: ["看上下文 friends/laughing together", "belong 指情感归属而非地产", "选‘被接纳的感觉’"],
            trap: "字面理解成‘一块地’，忽略情感语境。", difficulty: 0.55),
    ]

    // MARK: 应用文写作（选最佳表达 / 亮点句）

    static let applied: [Question] = [
        Question(id: "a1", module: .appliedWriting, levelId: "L5",
            stem: "邀请外教参加社团活动，下列开头哪句更得体、更符合应用文语域？",
            options: ["I'm writing to invite you to our English Corner this Friday.",
                      "Hey, come to our club, ok?",
                      "You must come to our activity.",
                      "I want you come to English Corner."], answer: 0,
            pointTag: "应用文·礼貌邀请句",
            strategy: ["应用文需正式、礼貌", "I'm writing to invite you to… 是标准邀请框架", "排除口语化/命令/语法错"],
            trap: "‘You must come’ 语气强硬；‘I want you come’ 缺 to。", difficulty: 0.4),
        Question(id: "a2", module: .appliedWriting, levelId: "L5",
            stem: "想表达‘这次活动能提升我们的口语’，哪句更高级、更地道？",
            options: ["The activity will help us improve our spoken English.",
                      "The activity is good for English.",
                      "We can speak English good in the activity.",
                      "The activity makes English better."], answer: 0,
            pointTag: "应用文·亮点动词 improve",
            strategy: ["选具体且搭配正确的动词 improve", "improve our spoken English 精准", "排除模糊/语法错"],
            trap: "‘speak English good’ 应为 well，且表达笼统。", difficulty: 0.45),
        Question(id: "a3", module: .appliedWriting, levelId: "L5",
            stem: "结尾想用一个加分句式表达期待，哪句最佳？",
            options: ["I would appreciate it if you could join us.",
                      "Please join, thanks.",
                      "If you join I am happy.",
                      "Join us or not is up to you."], answer: 0,
            pointTag: "应用文·虚拟语气结尾",
            strategy: ["I would appreciate it if you could… 是高分礼貌句式", "含虚拟语气，语域正式", "排除简单句/失礼句"],
            trap: "‘up to you’ 显得不真诚，降低得体度。", difficulty: 0.5),
    ]

    // MARK: 读后续写（情节链 + 高分句式选择）

    static let continuation: [Question] = [
        Question(id: "k1", module: .continuation, levelId: "L6",
            stem: "续写段首：主人公在暴雨中迷路。下列开头哪句更能制造画面感、符合高分续写？",
            options: ["Rain poured down as Tom stumbled along the muddy path, his heart pounding.",
                      "Tom was lost. It was raining. He was sad.",
                      "Then something happened to Tom in the rain.",
                      "Tom walked and walked in the big rain very much."], answer: 0,
            pointTag: "续写·环境+动作+心理",
            strategy: ["高分续写=环境描写+动作细节+心理", "as 引导伴随，pounding 传递紧张", "排除流水账/笼统句"],
            trap: "短句堆砌(‘It was raining. He was sad.’)缺乏画面与张力。", difficulty: 0.6),
        Question(id: "k2", module: .continuation, levelId: "L6",
            stem: "想把‘他很害怕’升级为高分描写，选哪句？",
            options: ["A chill ran down his spine as the shadows closed in.",
                      "He was very afraid of the dark.",
                      "He felt afraid and scared and fearful.",
                      "He was afraid very much in his heart."], answer: 0,
            pointTag: "续写·化情绪为身体反应",
            strategy: ["高分技巧：用身体反应替代直白‘害怕’", "A chill ran down his spine 是经典表达", "排除直白/堆叠近义词"],
            trap: "罗列 afraid/scared/fearful 是低效堆砌，不加分。", difficulty: 0.65),
        Question(id: "k3", module: .continuation, levelId: "L6",
            stem: "续写需承接上文的‘求救’并推进情节，下列哪句逻辑衔接最自然？",
            options: ["Just then, a flashlight beam cut through the darkness ahead.",
                      "The next day he went to school happily.",
                      "Suddenly the story ended well for everyone.",
                      "He decided to buy a new umbrella later."], answer: 0,
            pointTag: "续写·情节链衔接",
            strategy: ["承接‘求救’应给出回应/转机", "Just then 推进当下情节", "排除跳脱时间线/草草收尾"],
            trap: "‘第二天去上学’脱离当下危机，断裂情节链。", difficulty: 0.6),
    ]
}
