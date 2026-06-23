import Foundation

/// 高频考点库（基于考纲高频统计整理）。狙击算法在此之上为你排序。
enum HighFreqData {

    static let all: [HighFreqPoint] = {
        var r: [HighFreqPoint] = []
        r += grammar; r += clozePoints; r += readingPoints
        r += sevenPoints; r += writingPoints; r += continuationPoints
        r += extra
        return r
    }()

    static let grammar: [HighFreqPoint] = [
        HighFreqPoint(id: "hf_nonfinite", module: .grammarFill, name: "非谓语动词",
            frequencyWeight: 0.95,
            digest: "句中已有谓语→空格八成填非谓语：主动进行 -ing，被动/完成 -ed，目的/将来 to do。",
            example: "___ (see) from space, the Earth looks blue. → Seen（地球被看，用过去分词）",
            linkedLevelId: "L1", linkedQuestionIds: ["g2"]),
        HighFreqPoint(id: "hf_attributive", module: .grammarFill, name: "定语从句关系词",
            frequencyWeight: 0.85,
            digest: "先行词指物 which/that、指人 who；表所属 whose；表地点/抽象语境 where。",
            example: "the scientist ___ research changed the field → whose",
            linkedLevelId: "L1", linkedQuestionIds: ["g6"]),
        HighFreqPoint(id: "hf_tense", module: .grammarFill, name: "时态呼应",
            frequencyWeight: 0.80,
            digest: "By the time + 过去 → 主句过去完成；抓 this/last/ago 等时间标志定时态。",
            example: "By the time he arrived, they ___ (wait) for an hour. → had waited",
            linkedLevelId: "L1", linkedQuestionIds: ["g5"]),
        HighFreqPoint(id: "hf_subjunctive", module: .grammarFill, name: "虚拟语气",
            frequencyWeight: 0.60,
            digest: "与过去相反：if had done, would have done；与现在相反：if did, would do。",
            example: "If I ___ (have) time, I would have finished. → had had",
            linkedLevelId: "L1", linkedQuestionIds: ["g8"]),
    ]

    static let clozePoints: [HighFreqPoint] = [
        HighFreqPoint(id: "hf_logic", module: .cloze, name: "逻辑关联词",
            frequencyWeight: 0.90,
            digest: "however 转折 / therefore 因果 / besides 递进 / otherwise 否则——先判前后语义方向再选。",
            example: "She prepared well; ___, she still felt nervous. → however",
            linkedLevelId: "L2", linkedQuestionIds: ["c1", "c5"]),
        HighFreqPoint(id: "hf_verbdiff", module: .cloze, name: "动词与固定搭配辨析",
            frequencyWeight: 0.85,
            digest: "锁定固定搭配与语境：make every effort、overcome one's fear——搭配优先于词义。",
            example: "He finally ___ his fear. → overcame",
            linkedLevelId: "L2", linkedQuestionIds: ["c2", "c6"]),
    ]

    static let readingPoints: [HighFreqPoint] = [
        HighFreqPoint(id: "hf_polysemy", module: .reading, name: "熟词僻义",
            frequencyWeight: 0.80,
            digest: "高频僻义：address 解决、last 持续、figure 人物、subject 使遭受——结合语境别用第一义。",
            example: "We must address the problem. → address = 解决（非‘地址’）",
            linkedLevelId: "L4", linkedQuestionIds: ["r4", "r8"]),
        HighFreqPoint(id: "hf_inference", module: .reading, name: "推理判断",
            frequencyWeight: 0.90,
            digest: "推理＝有据：由原文事实小步推断，拒绝过度引申与无中生有。",
            example: "原文 knew no one → 可推 lonely（有据），不可推 angry（无据）",
            linkedLevelId: "L4", linkedQuestionIds: ["r3", "r7"]),
        HighFreqPoint(id: "hf_wordguess", module: .reading, name: "词义猜测",
            frequencyWeight: 0.75,
            digest: "靠上下文、同位解释、对比、构词法猜义，别凭字面直译。",
            example: "a place to belong → 被接纳的归属感（非字面‘一块地’）",
            linkedLevelId: "L4", linkedQuestionIds: ["r4", "r8"]),
    ]

    static let sevenPoints: [HighFreqPoint] = [
        HighFreqPoint(id: "hf_cohesion", module: .sevenChoose, name: "衔接信号",
            frequencyWeight: 0.85,
            digest: "代词 them/it 找对应单复数先行词；For example/However/As a result 直接定位逻辑。",
            example: "空后 Many of them… → 前句须出现复数名词",
            linkedLevelId: "L3", linkedQuestionIds: ["s2", "s4"]),
    ]

    static let writingPoints: [HighFreqPoint] = [
        HighFreqPoint(id: "hf_advsentence", module: .appliedWriting, name: "高级句式",
            frequencyWeight: 0.85,
            digest: "强调句 It is…that、倒装 Not only…、非谓语作状语——一篇用 1-2 个即提档。",
            example: "Not only did she finish early, but she also helped others.",
            linkedLevelId: "L5", linkedQuestionIds: ["a2"]),
        HighFreqPoint(id: "hf_transition", module: .appliedWriting, name: "过渡衔接词",
            frequencyWeight: 0.80,
            digest: "What's more / In addition 递进，however 转折，as a result 结果——给文章逻辑链。",
            example: "What's more, the activity will build our teamwork.",
            linkedLevelId: "L5", linkedQuestionIds: ["a5"]),
    ]

    static let continuationPoints: [HighFreqPoint] = [
        HighFreqPoint(id: "hf_psych", module: .continuation, name: "心理描写句式",
            frequencyWeight: 0.80,
            digest: "化情绪为身体反应：A chill ran down his spine / A wave of joy washed over him。",
            example: "A wave of joy washed over him as he read the letter.",
            linkedLevelId: "L6", linkedQuestionIds: ["k2", "k4"]),
        HighFreqPoint(id: "hf_plotchain", module: .continuation, name: "情节链衔接",
            frequencyWeight: 0.70,
            digest: "Just then / At that moment 推进当下；承接上文，不跳脱时间线。",
            example: "Just then, a flashlight beam cut through the darkness.",
            linkedLevelId: "L6", linkedQuestionIds: ["k3"]),
    ]

    /// 二期补充高频考点（14 → 30）。
    static let extra: [HighFreqPoint] = extraA + extraB + extraC

    static let extraA: [HighFreqPoint] = [
        HighFreqPoint(id: "hf_svagree", module: .grammarFill, name: "主谓一致",
            frequencyWeight: 0.75,
            digest: "the number of + 单数；a number of + 复数；nor/or 连接看就近原则。",
            example: "The number of students was surprising.",
            linkedLevelId: "L1", linkedQuestionIds: ["g3", "g11"]),
        HighFreqPoint(id: "hf_inversion", module: .grammarFill, name: "倒装句",
            frequencyWeight: 0.65,
            digest: "否定副词(Never/Not until/Only)置于句首→主句部分倒装：助动词提前。",
            example: "Never before had I seen such a sight.",
            linkedLevelId: "L1", linkedQuestionIds: ["g9", "g12"]),
        HighFreqPoint(id: "hf_nounclause", module: .grammarFill, name: "名词性从句",
            frequencyWeight: 0.70,
            digest: "what 引导且充当成分；that 只连接不充当成分；whether/if 表‘是否’。",
            example: "I can't decide what to wear. （what 作 wear 的宾语）",
            linkedLevelId: "L1", linkedQuestionIds: ["g10"]),
        HighFreqPoint(id: "hf_comparison", module: .grammarFill, name: "比较结构",
            frequencyWeight: 0.60,
            digest: "the more…the more；as…as；倍数 + as…as / 比较级。",
            example: "The more you practice, the better you become.",
            linkedLevelId: "L1", linkedQuestionIds: ["g14"]),
        HighFreqPoint(id: "hf_phrasalverb", module: .cloze, name: "高频动词短语",
            frequencyWeight: 0.80,
            digest: "come up with 想出 / look after 照顾 / put off 推迟 / give up 放弃——成片记忆。",
            example: "She managed to come up with a clever solution.",
            linkedLevelId: "L2", linkedQuestionIds: ["c13"]),
    ]

    static let extraB: [HighFreqPoint] = [
        HighFreqPoint(id: "hf_advdiff", module: .cloze, name: "副词辨析",
            frequencyWeight: 0.70,
            digest: "clearly / hardly / rarely / barely 语义差异大，先判句意正负向再选。",
            example: "He spoke clearly so that everyone could follow.",
            linkedLevelId: "L2", linkedQuestionIds: ["c10"]),
        HighFreqPoint(id: "hf_mainidea", module: .reading, name: "主旨大意",
            frequencyWeight: 0.85,
            digest: "抓首段末段与反复出现的高频词，归纳主题而非纠缠细节。",
            example: "全文反复出现 friends/belong → 主旨选‘归属感’",
            linkedLevelId: "L4", linkedQuestionIds: ["r2", "r6", "r11"]),
        HighFreqPoint(id: "hf_detailloc", module: .reading, name: "细节定位",
            frequencyWeight: 0.85,
            digest: "用题干关键词回原文定位，警惕同义改写与张冠李戴。",
            example: "Every Saturday → planted vegetables with neighbors",
            linkedLevelId: "L4", linkedQuestionIds: ["r1", "r5", "r10"]),
        HighFreqPoint(id: "hf_opening", module: .appliedWriting, name: "应用文开头模板",
            frequencyWeight: 0.80,
            digest: "I'm writing to invite / express / suggest…——按写作目的选框架，开门见山。",
            example: "I'm writing to express my sincere thanks for your help.",
            linkedLevelId: "L5", linkedQuestionIds: ["a1", "a9"]),
        HighFreqPoint(id: "hf_actiondetail", module: .continuation, name: "动作细节",
            frequencyWeight: 0.75,
            digest: "连续强动词串联动作：grabbed…threw on…dashed out，节奏感即画面感。",
            example: "She grabbed her bag, threw on her coat, and dashed out.",
            linkedLevelId: "L6", linkedQuestionIds: ["k5", "k11"]),
    ]

    static let extraC: [HighFreqPoint] = [
        HighFreqPoint(id: "hf_passive", module: .grammarFill, name: "被动语态",
            frequencyWeight: 0.70,
            digest: "主语是动作承受者→被动 be + 过去分词；with 复合结构同理用过去分词。",
            example: "With the work done, she left. （work 被完成）",
            linkedLevelId: "L1", linkedQuestionIds: ["g15"]),
        HighFreqPoint(id: "hf_adjdiff", module: .cloze, name: "形容词辨析",
            frequencyWeight: 0.70,
            digest: "形容词要与语境情感同向：harsh/pleasant、willing/reluctant，先判正负再选。",
            example: "Despite the harsh weather, they pressed on.",
            linkedLevelId: "L2", linkedQuestionIds: ["c3", "c7", "c14"]),
        HighFreqPoint(id: "hf_concession", module: .cloze, name: "让步逻辑",
            frequencyWeight: 0.65,
            digest: "Although/Despite/However 表让步：前后语义相反时优先考虑。",
            example: "Although exhausted, she refused to give up.",
            linkedLevelId: "L2", linkedQuestionIds: ["c8", "c15"]),
        HighFreqPoint(id: "hf_attitude", module: .reading, name: "作者态度/情感",
            frequencyWeight: 0.70,
            digest: "抓评价性词与语气(laughed/sadly)，区分 positive/negative/objective。",
            example: "she laughed, \"but they are mine\" → 自豪(positive)",
            linkedLevelId: "L4", linkedQuestionIds: ["r13"]),
        HighFreqPoint(id: "hf_ending", module: .appliedWriting, name: "结尾礼貌句",
            frequencyWeight: 0.75,
            digest: "Looking forward to your reply / I would appreciate it if…——收束得体加分。",
            example: "I'm looking forward to hearing from you soon.",
            linkedLevelId: "L5", linkedQuestionIds: ["a3", "a6"]),
        HighFreqPoint(id: "hf_setting", module: .continuation, name: "环境描写",
            frequencyWeight: 0.70,
            digest: "用环境烘托情绪：风声/光线/天气 + 拟人化动词，as 引导伴随。",
            example: "The wind howled through the empty street as midnight drew near.",
            linkedLevelId: "L6", linkedQuestionIds: ["k1", "k7"]),
    ]

    static func find(_ id: String) -> HighFreqPoint? { all.first { $0.id == id } }
}
