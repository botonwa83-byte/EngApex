import Foundation

/// "整篇实战"：完形填空(20空)/语法填空(10空)各一篇连贯短文，弥补单句精练缺的语境连贯训练。
/// 每空仍建模为一道 Question（levelId 复用 L2/L1，自动并入题型靶场），stem 里其余空格已替换为正确词，
/// 只留当前空格为 "___"，让你始终在完整语境下判断——而不是孤立看一句话。
extension QuestionBank {

    static let passageDrillCloze: [Question] = makeClozePassage()
    static let passageDrillGrammar: [Question] = makeGrammarPassage()

    // MARK: 完形填空·整篇语境（一次意外的善举，20 空）

    private static let clozeTemplate = """
    Last winter, Daniel was waiting for a bus on a {1} evening when he noticed an old man sitting alone on a bench, {2} in a thin jacket. Most people hurried past, too busy to {3} him, but something made Daniel stop and look closer.

    He {4} the man and asked if he was alright. The man {5} that he had lost his way home and had no money for a taxi. Without {6}, Daniel took off his own coat and {7} it around the man's shoulders. Then he sat down beside him and waited for the next bus together.

    During the ride, Daniel learned that the man, named Mr. Harris, had lived {8} since his wife passed away. He {9} had anyone to talk to, and the simple conversation seemed to {10} his evening {11}. When they reached his stop, Mr. Harris thanked Daniel again and again, his eyes filled with {12}.

    The next morning, Daniel received an {13} phone call. It was Mr. Harris, who wanted to {14} the coat and {15} Daniel for a cup of tea. Over the {16} months, the two became {17} friends, often sharing stories and laughter. Daniel realized that a small act of kindness, one he had almost {18}, had completely changed both of their lives. What had begun as an ordinary evening turned into a friendship neither of them had {19}.

    Looking back, Daniel often {20} how differently that night might have ended if he had simply walked on, like everyone else.
    """

    private struct ClozeBlank {
        let word: String
        let options: [String]
        let answer: Int
        let pointTag: String
        let strategy: [String]
        let trap: String
        let difficulty: Double
    }

    private static let clozeBlanks: [ClozeBlank] = [
        ClozeBlank(word: "freezing", options: ["mild", "warm", "freezing", "pleasant"], answer: 2,
            pointTag: "完形·整篇语境·形容词辨析",
            strategy: ["先通读全文定基调：老人在长椅上发抖、穿薄外套", "天气形容词须与后文'发抖'同向", "选 freezing(严寒的)"],
            trap: "mild/warm/pleasant 都与下文老人发抖的状态矛盾。", difficulty: 0.4),
        ClozeBlank(word: "shivering", options: ["resting", "shivering", "smiling", "singing"], answer: 1,
            pointTag: "完形·整篇语境·动词辨析",
            strategy: ["承接上一句'严寒的夜晚'", "穿着薄外套+严寒→应是在发抖", "选 shivering"],
            trap: "resting/smiling/singing 与全文'可怜的老人'基调不符。", difficulty: 0.4),
        ClozeBlank(word: "notice", options: ["forget", "blame", "photograph", "notice"], answer: 3,
            pointTag: "完形·整篇语境·动词辨析",
            strategy: ["后文 Daniel stop and look closer 形成对比", "大多数人'太忙而没有______他'，与 Daniel 的反应相反", "选 notice(注意到)"],
            trap: "全文主题是'被忽视的善举'，notice 与主题呼应，其余词破坏对比关系。", difficulty: 0.45),
        ClozeBlank(word: "approached", options: ["approached", "avoided", "ignored", "escaped"], answer: 0,
            pointTag: "完形·整篇语境·动词辨析",
            strategy: ["承接上文 Daniel stop and look closer", "他停下并走近，才能问'你还好吗'", "选 approached(走近)"],
            trap: "avoided/ignored/escaped 与后文'主动问询'的动作矛盾。", difficulty: 0.4),
        ClozeBlank(word: "explained", options: ["denied", "forgot", "explained", "doubted"], answer: 2,
            pointTag: "完形·整篇语境·动词辨析",
            strategy: ["后文紧跟 that 从句说明具体情况(迷路、没钱)", "这是在'说明情况'而非否认/怀疑", "选 explained"],
            trap: "denied/doubted 语义方向相反，forgot 与给出具体细节矛盾。", difficulty: 0.45),
        ClozeBlank(word: "hesitating", options: ["complaining", "hesitating", "celebrating", "laughing"], answer: 1,
            pointTag: "完形·整篇语境·固定搭配",
            strategy: ["without ___ 后接动名词，且与'立刻脱下外套'的果断动作呼应", "果断行动=没有犹豫", "选 hesitating"],
            trap: "其余三词与'立刻脱下外套帮助陌生人'的果断场景不搭。", difficulty: 0.5),
        ClozeBlank(word: "wrapped", options: ["threw", "hid", "sold", "wrapped"], answer: 3,
            pointTag: "完形·整篇语境·动词辨析",
            strategy: ["宾语是'外套'，动作对象是'裹在老人肩上'", "wrap...around... 才能体现'裹住保暖'的画面", "选 wrapped"],
            trap: "threw(扔)虽然语法可以，但与'体贴地帮老人保暖'的情感基调不符。", difficulty: 0.45),
        ClozeBlank(word: "alone", options: ["alone", "happily", "freely", "comfortably"], answer: 0,
            pointTag: "完形·整篇语境·语境复现",
            strategy: ["后文 since his wife passed away 给出原因", "妻子去世后他是独自生活", "选 alone"],
            trap: "happily/comfortably 与'妻子去世'的悲伤背景矛盾。", difficulty: 0.4),
        ClozeBlank(word: "rarely", options: ["always", "often", "rarely", "usually"], answer: 2,
            pointTag: "完形·整篇语境·副词辨析",
            strategy: ["承接'独自生活'，再看后文'这次简单的交谈让他很开心'", "如果经常有人陪伴，这次交谈就不会显得特别", "选 rarely(很少)"],
            trap: "always/often/usually 都会让后文'这次谈话让他很开心'失去意义。", difficulty: 0.55),
        ClozeBlank(word: "brighten", options: ["darken", "brighten", "shorten", "waste"], answer: 1,
            pointTag: "完形·整篇语境·动词辨析",
            strategy: ["主语是'简单的交谈'，宾语是'他的夜晚'", "交谈带来的应是积极影响", "选 brighten(使明朗/愉快)"],
            trap: "darken/waste 语义负面，与全文温暖基调相反。", difficulty: 0.45),
        ClozeBlank(word: "considerably", options: ["barely", "hardly", "rudely", "considerably"], answer: 3,
            pointTag: "完形·整篇语境·副词辨析",
            strategy: ["修饰 brighten his evening，且后文老人'感激不已'", "效果应是程度较大", "选 considerably(相当大程度地)"],
            trap: "barely/hardly 表示'几乎不'，与后文强烈的感激反应矛盾。", difficulty: 0.5),
        ClozeBlank(word: "gratitude", options: ["gratitude", "anger", "confusion", "embarrassment"], answer: 0,
            pointTag: "完形·整篇语境·名词辨析",
            strategy: ["前文 thanked Daniel again and again", "反复道谢对应的情绪是感激", "选 gratitude"],
            trap: "anger/confusion/embarrassment 与'反复道谢'的动作矛盾。", difficulty: 0.35),
        ClozeBlank(word: "unexpected", options: ["boring", "routine", "unexpected", "familiar"], answer: 2,
            pointTag: "完形·整篇语境·形容词辨析",
            strategy: ["前一晚才偶遇陌生老人，次日突然接到他的电话", "这通电话显然出人意料", "选 unexpected"],
            trap: "routine/familiar 暗示'常规/熟悉'，与刚认识一天的关系矛盾。", difficulty: 0.45),
        ClozeBlank(word: "return", options: ["sell", "return", "hide", "forget"], answer: 1,
            pointTag: "完形·整篇语境·动词辨析",
            strategy: ["宾语是'外套'，且外套本不属于 Mr. Harris", "他打电话的目的是还外套", "选 return(归还)"],
            trap: "sell/hide/forget 都与'归还借来的东西'这一礼貌行为不符。", difficulty: 0.4),
        ClozeBlank(word: "invite", options: ["warn", "blame", "refuse", "invite"], answer: 3,
            pointTag: "完形·整篇语境·动词辨析",
            strategy: ["and 连接的并列动作，宾语是 Daniel for a cup of tea", "请人喝茶=邀请", "选 invite"],
            trap: "warn/blame/refuse 与'请喝茶'的友好邀约场景矛盾。", difficulty: 0.4),
        ClozeBlank(word: "following", options: ["following", "previous", "same", "final"], answer: 0,
            pointTag: "完形·整篇语境·形容词辨析",
            strategy: ["上文是'次日接到电话'，此处指此后的几个月", "时间方向是向后延伸，不是向前", "选 following(随后的)"],
            trap: "previous(之前的)与时间方向相反。", difficulty: 0.45),
        ClozeBlank(word: "close", options: ["distant", "strange", "close", "former"], answer: 2,
            pointTag: "完形·整篇语境·形容词辨析",
            strategy: ["后文 often sharing stories and laughter 说明关系亲密", "亲密分享=close friends", "选 close"],
            trap: "distant/strange/former 都与'常分享故事和笑声'的亲密关系矛盾。", difficulty: 0.4),
        ClozeBlank(word: "overlooked", options: ["planned", "overlooked", "regretted", "treasured"], answer: 1,
            pointTag: "完形·整篇语境·动词辨析",
            strategy: ["主语 a small act of kindness，宾语为 one(指代这件善举)", "一件'几乎被______'的小事，却改变了两人的生活——形成对比", "选 overlooked(忽视)"],
            trap: "planned(计划好的)与文章强调'偶然/差点错过'的语境相反。", difficulty: 0.55),
        ClozeBlank(word: "expected", options: ["avoided", "deserved", "imagined", "expected"], answer: 3,
            pointTag: "完形·整篇语境·动词辨析",
            strategy: ["主句 neither of them had ___", "和开头'平凡的一晚'对比，友谊的发展超出预料", "选 expected(预料)"],
            trap: "avoided/deserved/imagined 都不能准确表达'谁都没有预料到'。", difficulty: 0.5),
        ClozeBlank(word: "wondered", options: ["wondered", "complained", "forgot", "regretted"], answer: 0,
            pointTag: "完形·整篇语境·动词辨析",
            strategy: ["后接 how differently...的从句，表达对'假如当初...'的思考", "wonder + 从句=思考、琢磨", "选 wondered"],
            trap: "complained/regretted 隐含负面情绪，与全文温暖的结尾基调不符。", difficulty: 0.5),
    ]

    private static func makeClozePassage() -> [Question] {
        let words = clozeBlanks.map(\.word)
        return clozeBlanks.enumerated().map { i, blank in
            var text = clozeTemplate
            for (j, word) in words.enumerated() {
                let token = "{\(j + 1)}"
                let replacement = (j == i) ? "___\(j + 1)___" : word
                text = text.replacingOccurrences(of: token, with: replacement)
            }
            return Question(id: "cz\(i + 1)", module: .cloze, levelId: "L2",
                stem: text + "\n\n第 \(i + 1)/20 空：本空应填？",
                options: blank.options, answer: blank.answer,
                pointTag: blank.pointTag, strategy: blank.strategy, trap: blank.trap, difficulty: blank.difficulty)
        }
    }

    // MARK: 语法填空·整篇语境（校园义卖，10 空）

    private static let grammarTemplate = """
    Every spring, our school {1} a charity sale to raise money for children in need. Last year, more than five hundred students {2} part, making it the biggest sale so far. {3} the weather was rainy that morning, nobody seemed to mind.

    Students sold handmade cards and snacks {4} by volunteers the night before. By noon, the sale had already {5} over three thousand yuan, {6} surprised even the organizers. One girl, {7} to sell every item on her table, stayed until {8} very last customer left.

    It was this spirit of generosity {9} made the event truly memorable. {10} all who took part, the sale was not just about money, but about learning to care for others.
    """

    private struct GrammarBlank {
        let answer: String
        let hint: String?      // 词根提示，real 高考语法填空里约一半空格有提示词
        let options: [String]
        let answerIndex: Int
        let pointTag: String
        let strategy: [String]
        let trap: String
        let difficulty: Double
    }

    private static let grammarBlanks: [GrammarBlank] = [
        GrammarBlank(answer: "holds", hint: "hold", options: ["hold", "holds", "held", "holding"], answerIndex: 1,
            pointTag: "语法填空·整篇语境·主谓一致/时态",
            strategy: ["Every spring 提示一般现在时的反复动作", "主语 our school 第三人称单数", "选 holds"],
            trap: "held 误用过去时——本空说的是'每年都举行'的反复动作，不是去年那一次。", difficulty: 0.45),
        GrammarBlank(answer: "took", hint: "take", options: ["take", "takes", "took", "taken"], answerIndex: 2,
            pointTag: "语法填空·整篇语境·时态",
            strategy: ["时间标志词 Last year", "对应一般过去时", "选 took"],
            trap: "taken 是过去分词，前面没有助动词 had/have，不能单独作谓语。", difficulty: 0.4),
        GrammarBlank(answer: "Although", hint: nil, options: ["Because", "Although", "Unless", "Whether"], answerIndex: 1,
            pointTag: "语法填空·整篇语境·状语从句·让步",
            strategy: ["前句'下雨'，后句'没人在意'——语义相反", "让步关系用 Although", "选 Although"],
            trap: "Because 表因果，但'下雨'不是'没人在意'的原因，是转折关系。", difficulty: 0.5),
        GrammarBlank(answer: "baked", hint: "bake", options: ["baked", "bake", "baking", "bakes"], answerIndex: 0,
            pointTag: "语法填空·整篇语境·非谓语·过去分词",
            strategy: ["snacks 与 bake 是被动关系(零食被烤制)", "作后置定语，逻辑主语是 snacks", "选过去分词 baked"],
            trap: "baking(主动)用在这里说成'零食在烤'，但应是'被烤制的零食'，需被动。", difficulty: 0.6),
        GrammarBlank(answer: "raised", hint: "raise", options: ["raise", "raising", "rose", "raised"], answerIndex: 3,
            pointTag: "语法填空·整篇语境·时态+动词辨析",
            strategy: ["By noon...had already ___ 提示过去完成时", "raise(及物，筹集)与 rise(不及物，上升)易混", "此处带宾语 three thousand yuan，须用 raise 的过去分词 raised"],
            trap: "rose 是 rise 的过去式，rise 不能直接接宾语，与本句结构不符。", difficulty: 0.65),
        GrammarBlank(answer: "which", hint: nil, options: ["that", "who", "which", "what"], answerIndex: 2,
            pointTag: "语法填空·整篇语境·非限制性定语从句",
            strategy: ["逗号后，先行词是前面整个句子(筹到三千多元这件事)", "非限制性定语从句不能用 that", "选 which"],
            trap: "that 不能引导非限制性定语从句(逗号+从句)，这是常见误区。", difficulty: 0.6),
        GrammarBlank(answer: "determined", hint: "determine", options: ["determined", "determine", "determining", "determines"], answerIndex: 0,
            pointTag: "语法填空·整篇语境·非谓语·过去分词作状语",
            strategy: ["One girl 与 determine 是被动/状态关系(她'下定决心'，被决心驱动)", "作伴随状语，逗号隔开的插入成分", "选 determined(下定决心的)"],
            trap: "determine 是动词原形，不能直接在逗号间作状语，需用过去分词。", difficulty: 0.6),
        GrammarBlank(answer: "the", hint: nil, options: ["a", "the", "an", "some"], answerIndex: 1,
            pointTag: "语法填空·整篇语境·冠词",
            strategy: ["very last customer 特指'最后一位顾客'，独一无二", "特指用 the", "选 the"],
            trap: "a/an 表泛指，但'最后一位顾客'是特指、唯一的，必须用 the。", difficulty: 0.4),
        GrammarBlank(answer: "that", hint: nil, options: ["which", "what", "who", "that"], answerIndex: 3,
            pointTag: "语法填空·整篇语境·强调句",
            strategy: ["识别 It was...___ 结构", "被强调的是主语 this spirit of generosity", "强调句的连接词只用 that"],
            trap: "which/who 容易让人误以为是定语从句，但 It was...that 是强调句固定结构。", difficulty: 0.55),
        GrammarBlank(answer: "For", hint: nil, options: ["With", "By", "To", "For"], answerIndex: 3,
            pointTag: "语法填空·整篇语境·介词",
            strategy: ["For all who took part = 对所有参与的人来说", "固定表达，引出'对……而言'", "选 For"],
            trap: "To 也能表'对...而言'但通常接人称代词(to me)，此处 For all who... 更自然、更常考。", difficulty: 0.5),
    ]

    private static func makeGrammarPassage() -> [Question] {
        let answers = grammarBlanks.map(\.answer)
        return grammarBlanks.enumerated().map { i, blank in
            var text = grammarTemplate
            for (j, word) in answers.enumerated() {
                let token = "{\(j + 1)}"
                let replacement: String
                if j == i {
                    replacement = blank.hint != nil ? "___\(j + 1)___ (\(blank.hint!))" : "___\(j + 1)___"
                } else {
                    replacement = word
                }
                text = text.replacingOccurrences(of: token, with: replacement)
            }
            return Question(id: "gp\(i + 1)", module: .grammarFill, levelId: "L1",
                stem: text + "\n\n第 \(i + 1)/10 空：本空应填？",
                options: blank.options, answer: blank.answerIndex,
                pointTag: blank.pointTag, strategy: blank.strategy, trap: blank.trap, difficulty: blank.difficulty)
        }
    }
}
