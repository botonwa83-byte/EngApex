import Foundation

/// 拔高难度补强（难度 ≥ 0.7）。原题库 240 题里拔高题仅占约 1%，冲刺 130+ 分的学生缺区分度训练。
/// 本批次集中在阅读推理/语法填空综合(两项最值得投入)，并各模块少量覆盖，难度普遍 0.75-0.85。
extension QuestionBank {

    static let hardTier: [Question] =
        hardReading + hardGrammar + hardCloze + hardSevenChoose + hardListening + hardContinuation + hardApplied

    // MARK: 阅读理解·拔高（推理/态度/写作目的）

    private static let hardPassageChoice =
    "For decades, psychologists assumed that offering people more choices would make them happier, since choice is " +
    "often equated with freedom. Yet a series of studies has quietly overturned this assumption. In one well-known " +
    "experiment, shoppers presented with twenty-four varieties of jam were far less likely to make a purchase than " +
    "those offered only six. Researchers later argued that an overwhelming number of options does not liberate " +
    "people. Instead, it burdens them with the fear of choosing wrong, and the mental cost of comparing dozens of " +
    "nearly identical options outweighs whatever extra value the choices might provide. Interestingly, this " +
    "'paradox of choice' seems to fade once people have a clear, specific goal in mind, since a strong preference " +
    "narrows the field automatically, sparing them the agony of comparison. The implication is unsettling for " +
    "marketers who have long believed that variety alone drives sales: sometimes, offering less is what truly sells more."

    private static let hardPassageFactory =
    "When the company finally announced record profits after years of losses, the CEO stood before the cheering " +
    "staff and declared, 'This success belongs to every single one of you.' He then proceeded to thank, by name, " +
    "the five senior executives who had 'masterminded the turnaround,' while the factory workers who had taken pay " +
    "cuts to keep the company afloat sat quietly near the back, unmentioned. A few of them exchanged glances but " +
    "said nothing. Later that evening, when a young intern asked one of the veteran workers whether he felt proud " +
    "of the company's recovery, the man simply shrugged and replied, 'Proud enough to keep paying my bills, I " +
    "suppose.' He picked up his toolbox and walked out without another word, leaving the intern unsure whether he " +
    "had just witnessed quiet dignity or quiet defeat."

    static let hardReading: [Question] = [
        Question(id: "hr1", module: .reading, levelId: "L4",
            stem: hardPassageChoice + "\n\nWhat can be inferred about the shoppers offered only six varieties of jam?",
            options: ["They likely found the decision easier and bought with more confidence.",
                      "They were less interested in jam in general.", "They distrusted the smaller selection.",
                      "They were unaware that more varieties existed."], answer: 0,
            pointTag: "阅读·拔高·对比推理",
            strategy: ["定位对比句：24 种远不如 6 种好卖", "推断原因是选择减少→决策负担减少", "据此推断 6 种组的顾客更容易、更自信地做决定"],
            trap: "选项 2/3 属于原文未提及的过度推断，选项 1 与原文'更容易购买'的结论方向相反。", difficulty: 0.78),
        Question(id: "hr2", module: .reading, levelId: "L4",
            stem: hardPassageChoice + "\n\nWhy does the passage mention the situation where people have \"a clear, specific goal in mind\"?",
            options: ["To show that the paradox of choice can disappear under certain conditions.",
                      "To prove that goals matter more than choices in every situation.",
                      "To suggest that marketers should ignore consumer psychology entirely.",
                      "To argue that people should always set goals before shopping."], answer: 0,
            pointTag: "阅读·拔高·论证功能推理",
            strategy: ["定位 Interestingly, this paradox...seems to fade once...", "这是对前文结论的'限定条件'补充，而非另起新论点", "选项准确概括这一让步/补充功能"],
            trap: "选项 1/3 把'例外情况'误当成全文中心论点；选项 2 无原文依据。", difficulty: 0.8),
        Question(id: "hr3", module: .reading, levelId: "L4",
            stem: hardPassageChoice + "\n\nWhat is the author's attitude toward marketers' traditional belief that variety alone drives sales?",
            options: ["Strongly supportive", "Completely neutral", "Mildly skeptical", "Enthusiastically optimistic"], answer: 2,
            pointTag: "阅读·拔高·作者态度",
            strategy: ["定位末句 unsettling for marketers...offering less is what truly sells more", "'unsettling' 带有'打破原有认知'的态度", "选 mildly skeptical，而非强烈反对或完全中立"],
            trap: "'unsettling' 不等于强烈批判，也不是完全中立——隐含质疑态度，程度判断是本题难点。", difficulty: 0.75),
        Question(id: "hr4", module: .reading, levelId: "L4",
            stem: hardPassageFactory + "\n\nWhat is the most likely reason the workers \"exchanged glances but said nothing\"?",
            options: ["They were too tired to react.",
                      "They silently recognized the gap between the CEO's words and their own experience.",
                      "They were planning to ask for a raise later.", "They did not understand what the CEO meant."], answer: 1,
            pointTag: "阅读·拔高·细节心理推理",
            strategy: ["对比 CEO 的话('属于每一个人')与后文只具体感谢高管", "工人间互相看了一眼但没说话，是一种心知肚明的无声反应", "选'对言行不一致的默契察觉'"],
            trap: "其余选项都没有原文依据，纯属编造的过度推断。", difficulty: 0.82),
        Question(id: "hr5", module: .reading, levelId: "L4",
            stem: hardPassageFactory + "\n\nWhat does the veteran worker's reply, \"Proud enough to keep paying my bills, I suppose,\" most likely suggest?",
            options: ["He is completely satisfied with how he has been treated.",
                      "He feels a mix of resignation and reserved dignity rather than genuine pride.",
                      "He is planning to quit his job immediately.", "He misunderstood the intern's question."], answer: 1,
            pointTag: "阅读·拔高·语气程度推理",
            strategy: ["注意 'proud enough to...' 这种保留性程度修饰", "'I suppose' 进一步弱化肯定语气，暗示不情愿/无奈", "结合结尾 quiet dignity or quiet defeat，选这种复杂、克制的情绪"],
            trap: "选项 0 把反讽当真；选项 2/3 脱离原文，是常见的过度引申陷阱。", difficulty: 0.85),
        Question(id: "hr6", module: .reading, levelId: "L4",
            stem: hardPassageFactory + "\n\nWhat is the author's purpose in ending the passage with \"quiet dignity or quiet defeat\"?",
            options: ["To clearly state which interpretation is correct.",
                      "To leave the worker's true feelings deliberately ambiguous, inviting the reader to reflect.",
                      "To criticize the intern for asking an inappropriate question.",
                      "To prove that the company's recovery was meaningless."], answer: 1,
            pointTag: "阅读·拔高·写作目的推理",
            strategy: ["这句话用 or 并列两种相反解读，没有给出明确答案", "作者故意留白，让读者自己判断", "选'刻意留白邀请读者思考'，而非给出明确结论"],
            trap: "选项 0 与原文'不确定(unsure)'矛盾；选项 2/3 是无原文依据的过度推断。", difficulty: 0.85),
    ]

    // MARK: 语法填空·拔高（双考点综合）

    static let hardGrammar: [Question] = [
        Question(id: "hg1", module: .grammarFill, levelId: "L1",
            stem: "___ I known about the traffic jam earlier, I would have left home before seven.",
            options: ["Had", "If", "Should", "Unless"], answer: 0,
            pointTag: "语法填空·综合·虚拟语气倒装",
            strategy: ["句意:'要是我早知道堵车……'，是与过去事实相反的虚拟语气", "可省略 if 并倒装：Had + 主语 + 过去分词", "选 Had"],
            trap: "If 后面不能直接倒装(If I had known)；本句已省略 if，结构上只能选 Had。", difficulty: 0.8),
        Question(id: "hg2", module: .grammarFill, levelId: "L1",
            stem: "___ (complete) on schedule despite the heavy rain, the bridge was officially opened last month.",
            options: ["Completing", "Having completed", "Completed", "Having been completed"], answer: 3,
            pointTag: "语法填空·综合·非谓语完成式被动",
            strategy: ["逻辑主语 the bridge 与 complete 是被动关系", "动作发生在'开放'之前，需完成式", "被动+完成 = Having been completed"],
            trap: "Completed 只表被动不表完成，丢失'已经完工在先'这层时间关系；Having completed 是主动完成式，与桥被完工的被动关系矛盾。", difficulty: 0.85),
        Question(id: "hg3", module: .grammarFill, levelId: "L1",
            stem: "It is not until you have lost something ___ you truly realize its value.",
            options: ["that", "when", "which", "then"], answer: 0,
            pointTag: "语法填空·综合·强调句+时间状语辨析",
            strategy: ["识别 It is...that... 强调句型", "被强调的是 not until you have lost something 这个时间状语", "强调句连接词固定用 that"],
            trap: "when 看似是常见的时间从句连接词，但本结构是强调句而非普通时间从句，固定只用 that。", difficulty: 0.78),
        Question(id: "hg4", module: .grammarFill, levelId: "L1",
            stem: "The reason ___ which she resigned remains unknown to most of her colleagues.",
            options: ["for", "of", "in", "by"], answer: 0,
            pointTag: "语法填空·综合·介词+关系代词",
            strategy: ["the reason for which = the reason why", "先行词 reason 与 resign 的逻辑关系是'原因'", "介词应填 for，对应 for the reason"],
            trap: "of/in/by 都不能与 reason 构成'……的原因'这一固定逻辑搭配。", difficulty: 0.82),
        Question(id: "hg5", module: .grammarFill, levelId: "L1",
            stem: "Smartphones today are capable of far more ___ their early predecessors could ever have imagined.",
            options: ["than", "that", "what", "as"], answer: 0,
            pointTag: "语法填空·综合·比较结构+省略",
            strategy: ["far more...than 是比较结构的固定搭配", "than 后面的从句省略了 doing，完整应为 than...could ever have imagined(doing)", "选 than"],
            trap: "what/that 不能用于比较结构中引出比较对象，只有 than 符合。", difficulty: 0.75),
        Question(id: "hg6", module: .grammarFill, levelId: "L1",
            stem: "So quickly ___ the rumor spread that the school had to issue an official statement by noon.",
            options: ["did", "had", "was", "has"], answer: 0,
            pointTag: "语法填空·综合·程度倒装",
            strategy: ["So + adv/adj 置于句首，引发部分倒装", "spread 是过去式行为，借助 did 倒装还原谓语动词原形", "选 did"],
            trap: "had/has/was 的时态或语态与 spread(过去式行为)不匹配，倒装应使用与原句时态一致的助动词 did。", difficulty: 0.83),
    ]

    // MARK: 完形填空·拔高（长距离语境+熟词僻义）

    static let hardCloze: [Question] = [
        Question(id: "hc1", module: .cloze, levelId: "L2",
            stem: "The committee's decision, though widely criticized at the time, ___ to be remarkably forward-thinking only a decade later.",
            options: ["turned out", "fell out", "broke out", "ran out"], answer: 0,
            pointTag: "完形·综合·动词短语辨析",
            strategy: ["语境：当时被批评，十年后才显现真实价值", "turn out to be = 结果证明是", "选 turned out"],
            trap: "fell out/broke out/ran out 都是常见固定短语，但语义与'结果证明'无关，纯粹是形近混淆。", difficulty: 0.78),
        Question(id: "hc2", module: .cloze, levelId: "L2",
            stem: "Far from ___ the criticism, the young director used it as fuel to refine her next project.",
            options: ["being discouraged by", "being satisfied with", "being known for", "being limited to"], answer: 0,
            pointTag: "完形·综合·逻辑反转+介词短语",
            strategy: ["Far from 表'远非……反而……'，提示后文与表面预期相反", "后文'把批评当作动力'说明她没有被打击", "选 being discouraged by(被……打击)"],
            trap: "其余三项语义都与'把批评当作动力'的转折逻辑不符。", difficulty: 0.8),
        Question(id: "hc3", module: .cloze, levelId: "L2",
            stem: "Her seemingly casual remark carried an edge of sarcasm that completely ___ the younger students, who took her words at face value.",
            options: ["escaped", "attracted", "satisfied", "interested"], answer: 0,
            pointTag: "完形·综合·熟词僻义",
            strategy: ["后文 took her words at face value(照字面理解)说明他们没察觉讽刺", "escape sb = 没有被某人察觉/理解(熟词僻义)", "选 escaped"],
            trap: "escape 常见义是'逃跑'，但这里取'未被注意到'的僻义，是完形填空高频陷阱。", difficulty: 0.82),
        Question(id: "hc4", module: .cloze, levelId: "L2",
            stem: "The novelist's prose, deceptively simple on the surface, ___ a depth of emotion that few critics fully appreciated until decades after her death.",
            options: ["concealed", "displayed", "lacked", "avoided"], answer: 0,
            pointTag: "完形·综合·形容词呼应+词义辨析",
            strategy: ["deceptively simple(表面看似简单实则不简单)与后文'去世后几十年才被欣赏'形成呼应", "深度情感被'隐藏'在简单的表面之下", "选 concealed(隐藏)"],
            trap: "displayed(展示)与 deceptively simple 暗含的'隐藏'语义直接矛盾。", difficulty: 0.8),
    ]

    // MARK: 七选五·拔高（长距离逻辑链）

    static let hardSevenChoose: [Question] = [
        Question(id: "hs1", module: .sevenChoose, levelId: "L3",
            stem: "Many coastal towns have begun restoring their mangrove forests after decades of clearance for shrimp farms. ___ Scientists now confirm that mangroves can absorb up to four times more carbon per hectare than tropical rainforests.",
            options: ["This shift was not driven by environmental awareness alone, but increasingly by economic necessity.",
                      "Mangroves are difficult to plant in rocky soil.", "Shrimp farming remains the most profitable coastal industry.",
                      "Coastal erosion has slowed in unrelated regions for other reasons."], answer: 0,
            pointTag: "七选五·拔高·逻辑链衔接",
            strategy: ["空处需衔接'恢复红树林'与后文'碳吸收'数据，结构是从现象到原因再到证据", "该选项交代了'转变'的深层原因(经济必要性)，为后文环境数据做了过渡", "选该项"],
            trap: "选项 2 与全文'恢复红树林'的趋势相反；选项 1/3 与上下文逻辑链无关，是话题相近的干扰项。", difficulty: 0.78),
        Question(id: "hs2", module: .sevenChoose, levelId: "L3",
            stem: "By the time historians began studying the diaries of ordinary soldiers, most of the official war records had already painted a tidy, heroic picture of the conflict. ___ The soldiers' own words revealed confusion, fear, and moments of unexpected kindness that no official account had captured.",
            options: ["These personal accounts offered a far messier, more human version of events.",
                      "Official records are generally considered more reliable than personal letters.",
                      "Few soldiers kept diaries during the war.", "Historians eventually stopped studying official war records altogether."], answer: 0,
            pointTag: "七选五·拔高·转折桥梁句",
            strategy: ["空处需承接'官方记录描绘了整洁英雄化的画面'，并引出后文'士兵的话揭示了混乱、恐惧'的反差", "该选项点出'更混乱、更真实'，恰好是转折的桥梁句", "选该项"],
            trap: "选项 1 与后文揭露官方记录局限性的倾向相反；选项 2/3 无原文依据，且与'历史学家开始研究日记'的事实矛盾。", difficulty: 0.82),
        Question(id: "hs3", module: .sevenChoose, levelId: "L3",
            stem: "The committee considered several venues for the conference, each with its own drawbacks. ___ In the end, practicality outweighed prestige, and the modest community center was chosen.",
            options: ["The grand hotel downtown was beautiful but well beyond the budget.",
                      "The conference was eventually cancelled due to low attendance.",
                      "Most committee members had never attended a conference before.",
                      "The community center had recently been renovated for unrelated reasons."], answer: 0,
            pointTag: "七选五·拔高·举例呼应",
            strategy: ["空处需呼应'每个场地都有缺点'，并为后文'实用性胜过排面'做铺垫", "该选项具体举出一个场地的缺点(预算)，且与最终选择社区中心的'实用'形成对比", "选该项"],
            trap: "选项 1 与后文'最终选定社区中心'的事实矛盾；选项 2/3 与本段讨论场地选择的逻辑链无关。", difficulty: 0.78),
    ]

    // MARK: 听力·拔高（全篇综合推理）

    private static let hardListeningScript =
    "Welcome to this special exhibition on ocean plastic pollution. The numbers can be hard to grasp: scientists " +
    "estimate that over eight million tons of plastic enter our oceans every single year. But perhaps more " +
    "troubling than the volume is the invisibility of the problem. Unlike a visible oil spill, microplastics break " +
    "down so small that they slip past the eye, entering the food chain through fish, and eventually, our own " +
    "dinner plates. Interestingly, the cities producing the most ocean plastic are not always the wealthiest; many " +
    "are rapidly developing coastal regions where waste management systems haven't kept pace with population " +
    "growth. This exhibition does not ask you to feel guilty. Instead, it asks you to notice, because once you " +
    "start noticing plastic in your daily life, you can't easily look away again."

    static let hardListening: [Question] = [
        Question(id: "hl1", module: .listening, levelId: "L7",
            stem: "What does the speaker imply by comparing ocean plastic to an oil spill?",
            listeningScript: hardListeningScript,
            options: ["Ocean plastic is actually a more visible and easily noticed problem.",
                      "Ocean plastic is harder to notice and therefore easier for people to ignore.",
                      "Oil spills are a far more serious environmental issue than plastic.",
                      "Both problems are equally easy to detect and clean up."], answer: 1,
            pointTag: "听力·拔高·对比暗示推理",
            strategy: ["听到对比结构 Unlike a visible oil spill", "结合后文 microplastics...slip past the eye", "推断:塑料问题比漏油更难被察觉，因此更容易被忽视"],
            trap: "选项 0/3 与'微塑料难以被肉眼察觉'的描述直接矛盾。", difficulty: 0.75),
        Question(id: "hl2", module: .listening, levelId: "L7",
            stem: "What does the speaker suggest about the cities producing the most ocean plastic?",
            listeningScript: hardListeningScript,
            options: ["They are mostly poor and underdeveloped regions.",
                      "They are mostly wealthy nations with strict regulations.",
                      "They are often fast-growing coastal areas where infrastructure lags behind growth.",
                      "They are mainly small island nations."], answer: 2,
            pointTag: "听力·拔高·细节综合",
            strategy: ["听到 not always the wealthiest", "紧跟 rapidly developing coastal regions where waste management hasn't kept pace", "准确概括'快速发展但基础设施跟不上'"],
            trap: "选项 0 过度简化为'贫穷'，原文强调的是'快速发展中'而非单纯贫穷；选项 1 与原文'不一定是最富裕'矛盾。", difficulty: 0.78),
        Question(id: "hl3", module: .listening, levelId: "L7",
            stem: "What is the speaker's main purpose in the final sentence?",
            listeningScript: hardListeningScript,
            options: ["To make listeners feel guilty about using plastic.",
                      "To encourage listeners to become more aware of plastic in their own lives.",
                      "To ask listeners to donate to the exhibition.", "To criticize cities that produce the most plastic waste."], answer: 1,
            pointTag: "听力·拔高·主旨/语用推理",
            strategy: ["听到 This exhibition does not ask you to feel guilty. Instead, it asks you to notice", "明确否定'内疚'这一目的，转而强调'注意/意识到'", "选项准确对应 notice 这一核心诉求"],
            trap: "选项 0 与原文'不是要你内疚'直接矛盾；选项 2/3 原文未提及。", difficulty: 0.8),
    ]

    // MARK: 读后续写·拔高（高阶句式辨析，四项皆通顺，比精度）

    static let hardContinuation: [Question] = [
        Question(id: "hk1", module: .continuation, levelId: "L6",
            stem: "想表达'他犹豫了片刻，最终还是决定说出真相'，下列哪句画面感和措辞最贴切？",
            options: ["After a brief pause that felt like an eternity, he chose, at last, to let the truth speak for itself.",
                      "He hesitated for a moment and then decided to tell the truth.",
                      "He paused, thought about it, and then said the truth out loud.",
                      "Hesitating only briefly, he eventually told the truth to everyone."], answer: 0,
            pointTag: "续写·拔高·心理时间夸张+委婉表达",
            strategy: ["四个选项都'语法正确'，需比较画面感和文学性", "该项用 felt like an eternity 夸张放大犹豫的心理时间，且 let the truth speak for itself 是含蓄的高级表达", "其余选项平实但缺乏画面，或搭配生硬(said the truth 应为 told the truth)"],
            trap: "本题陷阱是'四个选项都说得通'，容易随便选——真正的高分句要在画面感和措辞精度上都更胜一筹。", difficulty: 0.8),
        Question(id: "hk2", module: .continuation, levelId: "L6",
            stem: "想描写'比赛结束的那一刻，全场陷入了短暂的寂静，随后爆发出雷鸣般的掌声'，下列哪句节奏和画面感最强？",
            options: ["For one fleeting heartbeat, the stadium fell utterly silent — and then the roar of applause broke loose like a tidal wave.",
                      "The stadium was quiet for a second, and then everyone started clapping loudly.",
                      "There was a short silence in the stadium, followed by very loud and long applause.",
                      "The crowd stayed silent for a while before clapping with great excitement."], answer: 0,
            pointTag: "续写·拔高·节奏停顿+比喻",
            strategy: ["对比四句的画面密度：该项用 heartbeat 量化瞬间，破折号制造停顿后的爆发感，tidal wave 比喻雷鸣掌声", "其余选项都只是平铺直叙的'安静然后掌声'，没有节奏设计"],
            trap: "其余选项语法和意思都对，但读起来'流水账'，缺少调用感官和节奏的高级技巧。", difficulty: 0.82),
        Question(id: "hk3", module: .continuation, levelId: "L6",
            stem: "想表达'她意识到，成长有时就是学会在失去中依然心怀感激'，下列哪句逻辑衔接和措辞最高级？",
            options: ["She realized that growing up sometimes meant learning to stay grateful even in the face of loss.",
                      "She knew that growing up is sometimes about being thankful even if you lose something.",
                      "She understood growing up could mean to be grateful when losing things.",
                      "She found out that becoming an adult means staying thankful during hard times losing something."], answer: 0,
            pointTag: "续写·拔高·书面语域+语法精度",
            strategy: ["四个选项核心意思接近，但语域和语法精度差异大", "该项用 in the face of 和 meant...的非谓语结构最书面、最准确", "其余选项分别有人称跳脱(you)、搭配错误(mean to be)、语法混乱(losing things 悬空)等问题"],
            trap: "这类题容易因为'大意都对'而随便选——真正高分续写要求语域统一(全篇第三人称书面语)且语法精确无破绽。", difficulty: 0.85),
    ]

    // MARK: 应用文·拔高（正式度与分寸感辨析）

    static let hardApplied: [Question] = [
        Question(id: "ha1", module: .appliedWriting, levelId: "L5",
            stem: "写信向校长反映食堂卫生问题并提出改进建议，下列哪种开头在'得体'与'有效'之间平衡得最好？",
            options: ["I am writing to bring to your attention a hygiene issue in the school canteen that I believe deserves prompt action.",
                      "I'm writing to let you know the canteen is pretty dirty and someone should do something about it.",
                      "I am writing to formally and respectfully submit my most sincere and urgent concerns regarding the canteen's hygienic conditions.",
                      "This letter is to inform you that the canteen has hygiene problems which need to be solved as soon as possible."], answer: 0,
            pointTag: "应用文·拔高·正式度与行动力平衡",
            strategy: ["对比四句在'正式'与'自然'之间的平衡", "该项用 bring to your attention + deserves prompt action，既正式又不生硬，行动导向明确", "对比项堆砌 formally/respectfully/most sincere/urgent 反而显得用力过猛"],
            trap: "正式语域不等于堆砌更多'正式词汇'——过度正式是常见陷阱，实际显得不自然。", difficulty: 0.78),
        Question(id: "ha2", module: .appliedWriting, levelId: "L5",
            stem: "建议信中想提出'比起增加新设施，更应该先维护好现有设施'，下列哪句逻辑表达最精准？",
            options: ["Rather than investing in new facilities, the school might first focus on properly maintaining the ones it already has.",
                      "The school should not buy new facilities, and should maintain old ones.",
                      "Instead of new facilities, maintaining is more important for the school to do.",
                      "New facilities are not as good as maintaining the old ones for the school."], answer: 0,
            pointTag: "应用文·拔高·优先级逻辑表达",
            strategy: ["四句都想表达'优先顺序'，但只有该项用 Rather than...might first... 精准传递'对比+建议'的双重逻辑", "对比项用 and 并列，丢失了'优先于'的对比关系；另一项的比较结构把意思偷换成'新设施不如维护好'，逻辑跑偏"],
            trap: "这类题的陷阱是选项意思'看起来差不多'，但精确的逻辑连接词(rather than)才能不丢分。", difficulty: 0.8),
        Question(id: "ha3", module: .appliedWriting, levelId: "L5",
            stem: "感谢信结尾，既想表达感谢又不想显得过于隆重，下列哪句的'分寸感'最好？",
            options: ["Thank you again for your kindness — it really made a difference.",
                      "I cannot thank you enough for your extraordinarily generous and most invaluable assistance.",
                      "Thanks a lot, you really helped me out a ton.",
                      "Please accept my deepest and most heartfelt gratitude for everything you've done for me."], answer: 0,
            pointTag: "应用文·拔高·分寸感与语域精度",
            strategy: ["应用文得体不等于词越'高级'越好，过度堆砌(extraordinarily/most invaluable/deepest and most heartfelt)反而显得不真诚", "该项简洁但用 it really made a difference 具体化感谢的份量，分寸感最佳"],
            trap: "两个对比项是'过度正式'陷阱，另一项是'过于随意'陷阱——应用文真正的得体在两者之间。", difficulty: 0.75),
    ]
}
