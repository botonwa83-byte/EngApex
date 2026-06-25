import Foundation

/// 四期扩充：优先加厚内购解锁后的模块(阅读37.5分/听力30分/读后续写25分/应用文15分)，
/// 免费的语法填空/完形/七选五题量已充足，故本批次聚焦阅读+听力+读后续写+应用文。
extension QuestionBank {

    static let extended7: [Question] = reading7 + reading7Part2 + listening7 + listening8 + listening9 + continuation7 + applied7

    // MARK: 阅读理解·实用文(夏令营信息比对) r40-r44

    private static let passageSummerPrograms =
    "Are you looking for something exciting to do this summer? Check out these four programs designed for " +
    "students aged thirteen to eighteen.\n\n" +
    "Code Innovators Camp — July 3rd to 14th, two weeks, 320 dollars. No programming experience needed, just " +
    "bring a laptop and curiosity. Students build their own mobile app by the end of the camp. Limited to twenty " +
    "students per session.\n\n" +
    "Wild Lens Photography Workshop — July 10th to 17th, one week, 280 dollars. Open to anyone with a camera, " +
    "phone cameras welcome. Participants spend mornings hiking through Cedar Valley Nature Reserve and afternoons " +
    "learning photo editing. A basic photography class is recommended but not required.\n\n" +
    "Voices That Matter: Public Speaking Bootcamp — August 1st to 5th, five days, 150 dollars. Designed for " +
    "students who freeze up in front of an audience. Daily practice speeches, video feedback, and a final " +
    "showcase in front of family and friends. No prior experience necessary.\n\n" +
    "Ocean Explorers Marine Biology Expedition — July 20th to 30th, ten days, 450 dollars, including boat trips " +
    "and equipment. Applicants must be at least fifteen years old and complete a short swimming test before the " +
    "program begins. Students collect real data on local marine life under the guidance of university researchers."

    static let reading7: [Question] = [
        Question(id: "r40", module: .reading, levelId: "L4",
            stem: passageSummerPrograms + "\n\nA 13-year-old who has never used a real camera but owns a smartphone would best fit which program?",
            options: ["Wild Lens Photography Workshop", "Code Innovators Camp", "Voices That Matter", "Ocean Explorers Marine Biology Expedition"], answer: 0,
            pointTag: "阅读·实用文·细节匹配",
            strategy: ["定位 phone cameras welcome 且'A basic photography class is recommended but not required'", "13岁符合该项目年龄要求，无需相机经验", "选 Wild Lens Photography Workshop"],
            trap: "Ocean Explorers 要求至少15岁，13岁的学生不符合年龄门槛，直接排除。", difficulty: 0.45),
        Question(id: "r41", module: .reading, levelId: "L4",
            stem: passageSummerPrograms + "\n\nWhich program has a requirement that applicants must meet before the program begins?",
            options: ["Ocean Explorers Marine Biology Expedition", "Code Innovators Camp", "Wild Lens Photography Workshop", "Voices That Matter"], answer: 0,
            pointTag: "阅读·实用文·细节定位",
            strategy: ["逐项扫描资格要求", "Ocean Explorers 明确要求 at least fifteen years old and complete a short swimming test", "其余三项均明确'no experience necessary/needed'"],
            trap: "其余三项都强调'无需经验'，唯有海洋项目设有年龄和技能门槛。", difficulty: 0.4),
        Question(id: "r42", module: .reading, levelId: "L4",
            stem: passageSummerPrograms + "\n\nHow much would a family pay for the public speaking bootcamp?",
            options: ["150 dollars", "280 dollars", "320 dollars", "450 dollars"], answer: 0,
            pointTag: "阅读·实用文·数字定位",
            strategy: ["回原文定位 Voices That Matter 对应价格", "150 dollars 紧跟在该项目名称之后", "排除其余项目的价格干扰"],
            trap: "四个项目价格相近，需仔细对应项目名称与金额，不能凭印象选。", difficulty: 0.35),
        Question(id: "r43", module: .reading, levelId: "L4",
            stem: passageSummerPrograms + "\n\nWhat do Code Innovators Camp and Voices That Matter have in common?",
            options: ["Neither requires any prior experience.", "Both take place in July.", "Both cost over 300 dollars.", "Both require a swimming test."], answer: 0,
            pointTag: "阅读·实用文·信息整合",
            strategy: ["分别定位两个项目的描述", "Code Innovators: No programming experience needed；Voices That Matter: No prior experience necessary", "归纳共同点为'都无需经验'"],
            trap: "Voices That Matter 在八月而非七月，价格也远低于300美元，其余选项均不成立。", difficulty: 0.55),
        Question(id: "r44", module: .reading, levelId: "L4",
            stem: passageSummerPrograms + "\n\nWhich program runs for the longest period of time?",
            options: ["Code Innovators Camp", "Wild Lens Photography Workshop", "Voices That Matter", "Ocean Explorers Marine Biology Expedition"], answer: 0,
            pointTag: "阅读·实用文·细节计算",
            strategy: ["逐项换算天数：two weeks=14天，one week=7天，five days=5天，ten days=10天", "比较四个数值，14天最长", "选 Code Innovators Camp"],
            trap: "Ocean Explorers 标注的天数(ten days)看起来很长，但 two weeks(14天)实际更长，需要换算比较。", difficulty: 0.5),
    ]

    // MARK: 阅读理解·说明文(遗忘曲线/记忆科学) r45-r49

    private static let passageForgettingCurve =
    "In the late nineteenth century, a German psychologist named Hermann Ebbinghaus carried out a simple but " +
    "revealing experiment on himself. He memorized lists of meaningless syllables and then tested how much he " +
    "could recall after different periods of time. What he discovered came to be known as the \"forgetting " +
    "curve\": without any review, we lose the majority of newly learned information within the first day, and " +
    "the rate of forgetting then slows down gradually over the following weeks.\n\n" +
    "For decades, this curve was treated mainly as bad news, proof that the brain is leaky and unreliable. More " +
    "recent research, however, suggests that forgetting is not simply a flaw in the system but an active and " +
    "useful process. Neuroscientists have found that the brain appears to deliberately weaken certain memories, " +
    "especially ones that are rarely used or that conflict with more important, frequently accessed information. " +
    "In other words, the brain is constantly making decisions about what is worth keeping.\n\n" +
    "This shift in understanding has practical implications for how students study. Cramming the night before " +
    "an exam may feel productive, but it fights against the forgetting curve rather than working with it. Spacing " +
    "out review sessions, revisiting material after a day, then a week, then a month, takes advantage of the fact " +
    "that each successful recall makes a memory more resistant to future forgetting. Rather than trying to " +
    "prevent forgetting altogether, the smarter strategy may be to interrupt it at just the right moments."

    static let reading7Part2: [Question] = [
        Question(id: "r45", module: .reading, levelId: "L4",
            stem: passageForgettingCurve + "\n\nWhich is the best title for the passage?",
            options: ["The Forgetting Curve: Why Memory Fades and How to Outsmart It", "Ebbinghaus: Father of Modern Psychology",
                      "Why Cramming Is the Best Way to Study", "The Brain's Many Flaws"], answer: 0,
            pointTag: "阅读·主旨·标题归纳",
            strategy: ["全文围绕'遗忘曲线'这一概念展开，从发现到新认识再到学习启示", "标题需概括核心概念而非只提人物或单一观点", "选'遗忘曲线：为何记忆消退及如何应对'"],
            trap: "‘Ebbinghaus’只是引出概念的人物，‘填鸭式学习最好’与原文观点相反，均不能概括全文。", difficulty: 0.5),
        Question(id: "r46", module: .reading, levelId: "L4",
            stem: passageForgettingCurve + "\n\nHow did Ebbinghaus discover the forgetting curve?",
            options: ["By memorizing meaningless syllables and testing his own recall over time.", "By interviewing thousands of students about their study habits.",
                      "By scanning people's brains while they slept.", "By analyzing exam scores from several schools."], answer: 0,
            pointTag: "阅读·细节·研究方法",
            strategy: ["定位 He memorized lists of meaningless syllables and then tested how much he could recall", "这是他对自己进行的实验方法", "选'记忆无意义音节并测试回忆'"],
            trap: "其余选项都是原文未提及的虚构研究方法。", difficulty: 0.35),
        Question(id: "r47", module: .reading, levelId: "L4",
            stem: passageForgettingCurve + "\n\nHow has scientific understanding of forgetting changed over time?",
            options: ["From seeing it as a flaw to seeing it as a useful, active process.", "From seeing it as useful to seeing it as completely harmful.",
                      "Scientists have always agreed that forgetting is harmful.", "From a psychological topic to a purely medical one."], answer: 0,
            pointTag: "阅读·推理·观点演变对比",
            strategy: ["对比两段：'treated mainly as bad news' vs 'an active and useful process'", "这是观点从旧到新的转变", "选'从缺陷到有用的主动过程'"],
            trap: "其余选项颠倒了变化方向或编造了原文没有的转变。", difficulty: 0.6),
        Question(id: "r48", module: .reading, levelId: "L4",
            stem: passageForgettingCurve + "\n\nThe underlined word \"leaky\" in the second paragraph suggests that the brain was once thought to ___.",
            options: ["fail to hold on to information well", "physically leak water", "store too much information", "work faster than necessary"], answer: 0,
            pointTag: "阅读·词义猜测·比喻",
            strategy: ["leaky 常用于'漏水的容器'，此处是比喻", "本体是'大脑'，喻体是'漏水的容器'，强调'留不住东西'", "选'无法很好地保留信息'"],
            trap: "不能把比喻词'leaky'按字面'漏水'理解，要抓住其'留不住'的核心含义。", difficulty: 0.55),
        Question(id: "r49", module: .reading, levelId: "L4",
            stem: passageForgettingCurve + "\n\nWhat study strategy would the author most likely recommend?",
            options: ["Spacing out review sessions over days, weeks, and months.", "Cramming all the material the night before an exam.",
                      "Avoiding review altogether to let the brain rest.", "Memorizing meaningless syllables to train the brain."], answer: 0,
            pointTag: "阅读·推理·态度应用",
            strategy: ["定位末段 Spacing out review sessions...takes advantage of...resistant to future forgetting", "这是作者基于遗忘曲线给出的学习建议", "选'分散式复习'"],
            trap: "‘临时抱佛脚’在原文中被明确否定(fights against the forgetting curve)，与作者观点相反。", difficulty: 0.5),
    ]

    // MARK: 听力·第七段·问路对话 ln31-ln35

    private static let script7 =
    "W: Excuse me, could you tell me how to get to the City Science Museum from here? " +
    "M: Sure. Go straight along this street for about two blocks, then turn left at the traffic lights. " +
    "W: Turn left at the lights, got it. Then what? " +
    "M: After that, you'll see a large park on your right. The museum is just past the park, next to the public library. " +
    "W: How long does it usually take to walk there? " +
    "M: Probably about fifteen minutes if you walk at a normal pace. " +
    "W: Great, thank you so much for your help. " +
    "M: No problem. Oh, and if it starts raining, there's a bus, the number twelve bus, that stops right outside the museum."

    static let listening7: [Question] = [
        Question(id: "ln31", module: .listening, levelId: "L7",
            stem: "What does the woman want to know?",
            listeningScript: script7,
            options: ["How to get to the City Science Museum", "Where the nearest bus stop is", "What time the museum opens", "How much the museum ticket costs"], answer: 0,
            pointTag: "听力·主旨判断",
            strategy: ["预判主旨题，先听首句定话题", "开头 could you tell me how to get to the City Science Museum 直接点出主题", "锁定'问路去科学博物馆'"],
            trap: "后文提到 bus 只是补充信息，整段对话的核心仍是问路。", difficulty: 0.3),
        Question(id: "ln32", module: .listening, levelId: "L7",
            stem: "Where should the woman turn left?",
            listeningScript: script7,
            options: ["At the traffic lights", "At the park entrance", "At the library", "At the museum gate"], answer: 0,
            pointTag: "听力·细节捕捉",
            strategy: ["预判细节题，激活方向指示词 turn left", "听到 turn left at the traffic lights", "锁定 At the traffic lights"],
            trap: "park/library 都是后文提到的地标，不是转弯地点，别张冠李戴。", difficulty: 0.35),
        Question(id: "ln33", module: .listening, levelId: "L7",
            stem: "What is located next to the museum?",
            listeningScript: script7,
            options: ["The public library", "A bus station", "A large park", "A traffic light"], answer: 0,
            pointTag: "听力·细节定位",
            strategy: ["预判细节题，留意 next to 这一方位信号词", "听到 the museum is just past the park, next to the public library", "锁定 the public library"],
            trap: "公园(park)是博物馆前面经过的地标，'紧邻'博物馆的是图书馆，别混淆两个地标的位置关系。", difficulty: 0.45),
        Question(id: "ln34", module: .listening, levelId: "L7",
            stem: "How long will it probably take the woman to walk to the museum?",
            listeningScript: script7,
            options: ["About fifteen minutes", "About five minutes", "About thirty minutes", "About one hour"], answer: 0,
            pointTag: "听力·数字信息",
            strategy: ["预判数字题，激活时长表达", "听到 probably about fifteen minutes if you walk at a normal pace", "锁定 about fifteen minutes"],
            trap: "其余时长均为编造的干扰项，原文只给出了'十五分钟'这一个数字。", difficulty: 0.3),
        Question(id: "ln35", module: .listening, levelId: "L7",
            stem: "What does the man suggest the woman do if it starts raining?",
            listeningScript: script7,
            options: ["Take the number twelve bus", "Wait at the park until the rain stops", "Call a taxi", "Go back home"], answer: 0,
            pointTag: "听力·条件信息捕捉",
            strategy: ["预判条件题，激活 if it starts raining 这一信号词", "听到 there's a bus, the number twelve bus, that stops right outside the museum", "锁定'坐12路公交'"],
            trap: "这是一个'如果……就……'的条件信息，要听清条件触发后的具体建议，不能只停在'下雨'这个条件上。", difficulty: 0.45),
    ]

    // MARK: 听力·第八段·服装换货对话 ln36-ln40

    private static let script8 =
    "W: Hi, I bought this jacket here yesterday, but I'd like to exchange it for a larger size. " +
    "M: No problem, do you have the receipt with you? " +
    "W: Yes, here it is. Actually, the color seems a bit different in this light than it did yesterday, is that normal? " +
    "M: Some of our jackets do look slightly different under store lighting versus daylight, so that's quite normal. " +
    "W: I see. Also, will I need to pay anything extra for the larger size? " +
    "M: Let me check... no, the medium and the large are priced the same, so there won't be any extra charge. " +
    "W: That's good to hear. One more thing, how long do I have to make exchanges in general? " +
    "M: You can exchange or return items within thirty days of purchase, as long as you keep the receipt."

    static let listening8: [Question] = [
        Question(id: "ln36", module: .listening, levelId: "L7",
            stem: "What does the woman want to do?",
            listeningScript: script8,
            options: ["Exchange the jacket for a larger size", "Return the jacket for a refund", "Buy a second jacket", "Complain about the jacket's quality"], answer: 0,
            pointTag: "听力·主旨判断",
            strategy: ["预判主旨题，先听首句定话题", "开头 I'd like to exchange it for a larger size 直接点出目的", "锁定'换大一号的尺码'"],
            trap: "后文出现的颜色疑问和费用疑问都只是补充对话，核心需求是换尺码。", difficulty: 0.3),
        Question(id: "ln37", module: .listening, levelId: "L7",
            stem: "What does the woman need to show the man?",
            listeningScript: script8,
            options: ["The receipt", "Her ID card", "A membership card", "The original bag"], answer: 0,
            pointTag: "听力·细节捕捉",
            strategy: ["预判细节题，激活 do you have...with you 这一问句", "听到 do you have the receipt with you", "锁定 the receipt"],
            trap: "其余证件均为编造的干扰项，原文只要求小票。", difficulty: 0.3),
        Question(id: "ln38", module: .listening, levelId: "L7",
            stem: "Why does the jacket look slightly different in color?",
            listeningScript: script8,
            options: ["Store lighting differs from daylight", "The jacket faded after washing", "The woman bought the wrong color", "The shop changed the design"], answer: 0,
            pointTag: "听力·原因捕捉",
            strategy: ["预判原因题，激活 versus 这一对比信号词", "听到 look slightly different under store lighting versus daylight", "锁定'店内灯光与日光不同'"],
            trap: "其余选项都是常见的'颜色问题'干扰项，原文明确归因于灯光差异。", difficulty: 0.4),
        Question(id: "ln39", module: .listening, levelId: "L7",
            stem: "How much extra will the woman pay for the larger size?",
            listeningScript: script8,
            options: ["Nothing extra", "A small fee", "Half price", "Full price again"], answer: 0,
            pointTag: "听力·数字信息(否定)",
            strategy: ["预判数字/金额题，激活 extra charge 这一表达", "听到 there won't be any extra charge", "锁定'不需要额外付费'"],
            trap: "听到'will I need to pay extra'是疑问，真正答案在后面的否定回答里，别只听问句就误判。", difficulty: 0.45),
        Question(id: "ln40", module: .listening, levelId: "L7",
            stem: "Within how many days can items be exchanged or returned?",
            listeningScript: script8,
            options: ["Thirty days", "Seven days", "Fourteen days", "Sixty days"], answer: 0,
            pointTag: "听力·数字信息",
            strategy: ["预判数字题，激活 within...of purchase 这一期限表达", "听到 within thirty days of purchase", "锁定 thirty days"],
            trap: "其余天数均为编造的干扰项，原文只给出了'三十天'这一期限。", difficulty: 0.3),
    ]

    // MARK: 听力·第九段·博物馆讲解员开场白(独白) ln41-ln45

    private static let script9 =
    "Good morning, and welcome to the Riverside History Museum. My name is Carla, and I'll be your guide for " +
    "today's tour. Before we begin, let me quickly go over a few things. The tour will last about ninety minutes " +
    "and will cover three main exhibits: ancient pottery, traditional clothing, and our newest addition, a " +
    "collection of old maps of the city. Please note that flash photography is not allowed in the maps exhibit, " +
    "as the light can damage these delicate documents, although you're welcome to take photos without flash " +
    "anywhere else. Restrooms are located near the main entrance, to your left as you came in. If at any point " +
    "you have questions, feel free to raise your hand, and I'll pause the tour to answer them. At the end of our " +
    "visit, there will be a small gift shop where you can buy postcards and books related to today's exhibits. " +
    "Now, if everyone is ready, let's begin with the pottery collection."

    static let listening9: [Question] = [
        Question(id: "ln41", module: .listening, levelId: "L7",
            stem: "Who is Carla?",
            listeningScript: script9,
            options: ["A museum tour guide", "A history teacher", "A museum visitor", "A shop assistant"], answer: 0,
            pointTag: "听力·角色判断",
            strategy: ["预判角色题，激活 I'll be your guide for today's tour", "开头自我介绍直接点出身份", "锁定'博物馆讲解员'"],
            trap: "提到 history 不代表她是历史老师，她的身份信号词是 guide。", difficulty: 0.3),
        Question(id: "ln42", module: .listening, levelId: "L7",
            stem: "How long will the tour last?",
            listeningScript: script9,
            options: ["About ninety minutes", "About sixty minutes", "About thirty minutes", "About two hours"], answer: 0,
            pointTag: "听力·数字信息",
            strategy: ["预判数字题，激活 last about...这一时长表达", "听到 The tour will last about ninety minutes", "锁定 about ninety minutes"],
            trap: "其余时长均为编造的干扰项，原文只给出了'九十分钟'这一个数字。", difficulty: 0.3),
        Question(id: "ln43", module: .listening, levelId: "L7",
            stem: "Why is flash photography not allowed in the maps exhibit?",
            listeningScript: script9,
            options: ["The light can damage the delicate documents", "The maps are too valuable to photograph", "Other visitors might be disturbed", "The museum wants to sell its own photos"], answer: 0,
            pointTag: "听力·原因捕捉",
            strategy: ["预判原因题，激活 as 这一因果信号词", "听到 not allowed...as the light can damage these delicate documents", "锁定'灯光会损坏文件'"],
            trap: "其余选项都是合理但原文未提及的猜测，只有'损坏文件'是原文给出的真实原因。", difficulty: 0.45),
        Question(id: "ln44", module: .listening, levelId: "L7",
            stem: "Where are the restrooms located?",
            listeningScript: script9,
            options: ["Near the main entrance, to the left", "Next to the gift shop", "Inside the maps exhibit", "On the second floor"], answer: 0,
            pointTag: "听力·细节定位",
            strategy: ["预判细节题，激活 located 这一方位信号词", "听到 Restrooms are located near the main entrance, to your left", "锁定'主入口左侧'"],
            trap: "礼品店是行程最后才提到的地点，与卫生间的位置无关，别混淆两个地点。", difficulty: 0.4),
        Question(id: "ln45", module: .listening, levelId: "L7",
            stem: "What can visitors do at the end of the tour?",
            listeningScript: script9,
            options: ["Buy postcards and books at the gift shop", "Get a free guidebook", "Meet the museum director", "Take a group photo with staff"], answer: 0,
            pointTag: "听力·细节捕捉",
            strategy: ["预判细节题，留意 At the end of our visit 这一时间信号词", "听到 there will be a small gift shop where you can buy postcards and books", "锁定'在礼品店买明信片和书'"],
            trap: "其余选项都是合理但原文未提及的编造细节，只有'礼品店购物'是原文明确给出的信息。", difficulty: 0.4),
    ]

    // MARK: 读后续写·新技巧角度补强 k31-k36

    static let continuation7: [Question] = [
        Question(id: "k31", module: .continuation, levelId: "L6",
            stem: "三人对话场景中，新加入的第三人插话，哪种处理最自然、最清楚？",
            options: ["Then James spoke up too, \"Wait, I saw something different,\" he said, stepping between them.",
                      "Someone said something else then.", "And the third one talked some too about it.", "James talk too and say different thing."], answer: 0,
            pointTag: "续写·多人对话区分",
            strategy: ["先点名 James 再引出他的话，读者立刻知道是第三人插话", "stepping between them 用动作进一步坐实身份", "排除模糊指代(someone/the third one)和语病句"],
            trap: "三人对话最容易因为不点名而让读者搞混说话人，先说 who 再说 what。", difficulty: 0.6),
        Question(id: "k32", module: .continuation, levelId: "L6",
            stem: "想用天气变化象征人物心情由阴转晴，哪句最佳？",
            options: ["As the last clouds drifted away, sunlight broke through and spilled across the field.",
                      "The weather became good and the sun came out finally.", "It was sunny now after being cloudy a while ago.", "Clouds gone, sun appeared, weather nice now."], answer: 0,
            pointTag: "续写·天气意象烘托情绪",
            strategy: ["clouds drifted away + sunlight broke through 两个动态意象呼应心情转晴", "用具体动词(drifted/broke/spilled)代替笼统的'变好了'", "排除平铺直叙和语病堆砌句"],
            trap: "‘天气变好了’说尽却没有画面，续写要让景物'做动作'而非简单陈述状态。", difficulty: 0.55),
        Question(id: "k33", module: .continuation, levelId: "L6",
            stem: "想用'慢镜头'手法放大'她伸手去接掉落的杯子'这一瞬间，哪句最佳？",
            options: ["Her hand shot out, fingers stretching, as the cup tumbled through the air in what felt like slow motion.",
                      "She quickly put her hand out and caught the falling cup.", "The cup fell and she catch it fast.", "She tried to catch cup before it fell down fast."], answer: 0,
            pointTag: "续写·慢镜头/瞬间放大",
            strategy: ["把一个瞬间拆解为'手伸出→手指张开→杯子在空中坠落'三个分镜", "in what felt like slow motion 直接点出慢镜头效果", "排除一句带过、缺乏画面分解的选项"],
            trap: "‘很快接住了’把瞬间一笔带过，续写遇到关键瞬间应放慢节奏，逐步呈现细节。", difficulty: 0.65),
        Question(id: "k34", module: .continuation, levelId: "L6",
            stem: "原文开头提到她随身带着一把旧钥匙，续写想在结尾回收这个细节，哪句最佳？",
            options: ["She took out the old key one last time, finally understanding what it had always been meant to open.",
                      "She had a key and now she knew what it was for.", "The key was old and she understood it now finally.", "She still had that key from before, it was useful now."], answer: 0,
            pointTag: "续写·伏笔回收",
            strategy: ["明确呼应开头的具体物件'旧钥匙'", "one last time + finally understanding 给细节一个情感收束", "排除平淡复述、缺乏情感升华的选项"],
            trap: "伏笔回收不是简单重提物件，而要给它一个新的意义或情感落点。", difficulty: 0.6),
        Question(id: "k35", module: .continuation, levelId: "L6",
            stem: "续写想设计一个意外反转(她以为对方生气，其实对方在策划惊喜)，哪种铺垫最合理？",
            options: ["She braced herself for his anger, only to see him pull out a small wrapped box with a shy smile.",
                      "She thought he was angry but actually he was happy and had a surprise for her suddenly.", "He was not angry, he was planning surprise, she did not know.", "Actually he had a gift and was not angry like she think."], answer: 0,
            pointTag: "续写·反转铺垫",
            strategy: ["braced herself for his anger 先强化读者的错误预期", "only to see...box with a shy smile 用具体画面揭示反转", "排除直接说破'其实是...'的平铺解释式反转"],
            trap: "反转要靠画面揭示，不能直接用'actually'把谜底说破，那样毫无惊喜感。", difficulty: 0.65),
        Question(id: "k36", module: .continuation, levelId: "L6",
            stem: "想在同一句里调动视觉+听觉+嗅觉，写'她走进厨房'的画面，哪句最佳？",
            options: ["She stepped into the kitchen, where warm light spilled over the counters, a kettle whistled softly, and the smell of fresh bread filled the air.",
                      "She went into the kitchen and saw light, heard kettle and smelled bread there.", "The kitchen had light, sound, and smell when she walked in it.", "She walked in the kitchen, it was light, noisy, and smell good."], answer: 0,
            pointTag: "续写·多感官综合描写",
            strategy: ["三个独立分句分别呈现视觉(warm light)、听觉(kettle whistled)、嗅觉(smell of fresh bread)", "用从句 where 自然串联三种感官，避免堆砌感", "排除罗列式、语病句"],
            trap: "多感官描写最容易写成'看到…听到…闻到…'的生硬罗列，要用从句/分词自然融合。", difficulty: 0.6),
    ]

    // MARK: 应用文·正文内容要素补强 a31-a34

    static let applied7: [Question] = [
        Question(id: "a31", module: .appliedWriting, levelId: "L5",
            stem: "给建议信提具体可执行的建议，哪句最佳？",
            options: ["I suggest setting up a recycling bin in every classroom, with clear labels for paper, plastic, and cans.",
                      "I think we should be more environmentally friendly in general.", "We need to care about environment more, it is important.", "Environment protection should be done well by everyone always."], answer: 0,
            pointTag: "应用文·建议具体化",
            strategy: ["具体到'每班一个分类回收箱+清晰标签'，而非泛泛而谈", "可执行的建议要包含 WHO/WHAT/HOW 的细节", "排除空泛口号式表达"],
            trap: "‘要环保/要重视’这类口号式建议没有可执行性，阅卷会判定内容空洞。", difficulty: 0.5),
        Question(id: "a32", module: .appliedWriting, levelId: "L5",
            stem: "正式通知的标题格式，哪种最规范？",
            options: ["Notice", "Hi everyone, notice for you", "important notice!!!", "This is a Notice."], answer: 0,
            pointTag: "应用文·通知标题格式",
            strategy: ["正式通知标题应简洁居中，常用 Notice 或'具体事项+Notice'", "不需要问候语或多余标点", "排除口语化或滥用标点的选项"],
            trap: "通知标题不是正文，不需要'Hi everyone'这类问候语，也不该用多个感叹号。", difficulty: 0.4),
        Question(id: "a33", module: .appliedWriting, levelId: "L5",
            stem: "感谢信中具体说明'对方帮助带来的实际影响'，哪句最佳？",
            options: ["Thanks to your patient explanation, I finally understood the concept and improved my grade by ten points.",
                      "Your help was very useful to me and I am thankful for it.", "I want to say thanks because you helped me a lot really.", "Your help, it was good, thank you so much for that."], answer: 0,
            pointTag: "应用文·感谢信·具体影响支撑",
            strategy: ["用具体结果(理解了概念+提高十分)证明帮助的实际价值", "比泛泛的'很有用/很感激'更有说服力", "排除空泛感谢、缺乏具体支撑的选项"],
            trap: "空说'很感激'缺乏说服力，感谢信加分点在于用具体结果证明帮助确实有效。", difficulty: 0.5),
        Question(id: "a34", module: .appliedWriting, levelId: "L5",
            stem: "设计一张活动海报，正文最核心的信息要素是哪一组？",
            options: ["Event name, date and time, location, and contact information.",
                      "A long paragraph describing the history of the event.", "A detailed personal opinion about why the event matters.", "A list of past years' attendance numbers."], answer: 0,
            pointTag: "应用文·海报核心要素",
            strategy: ["海报读者需要快速获取关键信息：活动名+时间地点+联系方式", "排除长段落描述性内容，海报忌大段文字", "选信息要素而非叙述性内容"],
            trap: "海报不是作文，大段历史描述或个人观点会让关键信息被淹没，核心是让人一眼获取要点。", difficulty: 0.45),
    ]
}
