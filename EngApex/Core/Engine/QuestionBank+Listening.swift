import Foundation

/// 听力模块（L7）。stem 只放设问本身，材料原文放 listeningScript，由 SpeechPlayer 离线朗读。
/// 6 段材料 × 5 题，覆盖高考听力高频场景。
extension QuestionBank {

    static let listening: [Question] =
        passage1Questions + passage2Questions + passage3Questions + passage4Questions
        + passage5Questions + passage6Questions

    // MARK: 第一段·餐厅订位对话 ln1–ln5

    private static let script1 =
    "W: Good evening, this is Lakeside Restaurant. How can I help you? " +
    "M: Hi, I'd like to book a table for four people this Friday at seven thirty. " +
    "W: I'm sorry, seven thirty is fully booked. We do have a table free at eight fifteen. " +
    "M: That's fine. Could we also get a table by the window? " +
    "W: Of course, I'll note that down. Can I have your name, please? " +
    "M: It's David. " +
    "W: Great, see you on Friday, David."

    static let passage1Questions: [Question] = [
        Question(id: "ln1", module: .listening, levelId: "L7",
            stem: "Where does this conversation most likely take place?",
            listeningScript: script1,
            options: ["At a restaurant", "At a hotel", "At a travel agency", "At a cinema"], answer: 0,
            pointTag: "听力·场景定位",
            strategy: ["听前看选项判断这是场景题", "激活‘餐厅’场景词：book a table, window seat", "开头 this is Lakeside Restaurant 直接给出场景"],
            trap: "M 在打电话订位，别被‘打电话’误导成‘旅行社订机票’。", difficulty: 0.3),
        Question(id: "ln2", module: .listening, levelId: "L7",
            stem: "What time will David's table actually be?",
            listeningScript: script1,
            options: ["7:30", "7:45", "8:00", "8:15"], answer: 3,
            pointTag: "听力·数字信息(被修正)",
            strategy: ["听前预判这是数字题，激活时间词", "先听到 seven thirty，但紧跟 fully booked 被否定", "真正信号词是后面的 eight fifteen"],
            trap: "第一次出现的数字(7:30)是被否定的干扰项，真正答案在修正之后。", difficulty: 0.45),
        Question(id: "ln3", module: .listening, levelId: "L7",
            stem: "How many people will be having dinner?",
            listeningScript: script1,
            options: ["Two", "Three", "Four", "Five"], answer: 2,
            pointTag: "听力·数字信息",
            strategy: ["预判为数字题，激活人数相关表达 for…people", "听到 a table for four people", "锁定 four 即为人数"],
            trap: "数字题只锁未被修正的信号词，不要和电话号码、时间等其他数字混淆。", difficulty: 0.3),
        Question(id: "ln4", module: .listening, levelId: "L7",
            stem: "What extra request does David make?",
            listeningScript: script1,
            options: ["A table by the window", "A birthday cake", "A private room", "A discount"], answer: 0,
            pointTag: "听力·细节捕捉",
            strategy: ["预判为细节题，听清楚谁提出了额外要求", "信号词 Could we also get…", "锁定 a table by the window"],
            trap: "‘also’这类递进信号词后面往往是细节题答案，别漏听。", difficulty: 0.35),
        Question(id: "ln5", module: .listening, levelId: "L7",
            stem: "What is David's attitude when told 7:30 is unavailable?",
            listeningScript: script1,
            options: ["He calmly accepts the new time", "He gets angry and hangs up", "He cancels the booking", "He insists on 7:30"], answer: 0,
            pointTag: "听力·态度推断",
            strategy: ["预判为态度题，留意语气和后续反应", "听到 I'm sorry…eight fifteen 后，David 直接说 That's fine", "由顺从的回应推断态度平和"],
            trap: "态度题要听完整段反应，不能只看到‘被拒绝’就猜生气。", difficulty: 0.5),
    ]

    // MARK: 第二段·机场延误广播 ln6–ln10

    private static let script2 =
    "Attention passengers. Flight CA982 to Chicago, originally scheduled to depart at ten fifteen, " +
    "has been delayed due to heavy fog. The new departure time is eleven forty. We apologize for the " +
    "inconvenience. Passengers are invited to enjoy a complimentary drink at the café near gate twelve " +
    "while waiting. Boarding will begin thirty minutes before the new departure time. Thank you for your patience."

    static let passage2Questions: [Question] = [
        Question(id: "ln6", module: .listening, levelId: "L7",
            stem: "Where is this announcement most likely being made?",
            listeningScript: script2,
            options: ["At an airport", "At a train station", "At a bus stop", "At a hotel"], answer: 0,
            pointTag: "听力·场景定位",
            strategy: ["预判场景题，激活‘机场’场景词：flight, gate, boarding", "开头 Flight CA982…depart 直接点出场景", "锁定 At an airport"],
            trap: "出现 café 不代表是餐厅广播，要看整体场景主线。", difficulty: 0.3),
        Question(id: "ln7", module: .listening, levelId: "L7",
            stem: "Why was the flight delayed?",
            listeningScript: script2,
            options: ["Heavy fog", "A mechanical problem", "A staff strike", "Bad traffic"], answer: 0,
            pointTag: "听力·原因捕捉",
            strategy: ["预判原因题，激活 due to/because of 信号词", "听到 delayed due to heavy fog", "锁定 Heavy fog"],
            trap: "原因题只认信号词 due to 后面的内容，不要自行联想其他可能原因。", difficulty: 0.3),
        Question(id: "ln8", module: .listening, levelId: "L7",
            stem: "What is the new departure time?",
            listeningScript: script2,
            options: ["10:15", "10:40", "11:10", "11:40"], answer: 3,
            pointTag: "听力·数字信息(被修正)",
            strategy: ["预判数字题，激活时间表达", "先听到 originally…ten fifteen，但被 delayed 否定", "真正信号词在 the new departure time is eleven forty"],
            trap: "originally scheduled 后面的数字是旧信息，听到 new 才是答案。", difficulty: 0.45),
        Question(id: "ln9", module: .listening, levelId: "L7",
            stem: "What can passengers do while waiting?",
            listeningScript: script2,
            options: ["Enjoy a free drink near gate twelve", "Get a full refund", "Change to another flight for free", "Check in their luggage again"], answer: 0,
            pointTag: "听力·细节捕捉",
            strategy: ["预判细节题，留意广播给出的补偿措施", "信号词 complimentary drink at the café near gate twelve", "锁定‘免费饮品’这一细节"],
            trap: "complimentary = 免费的，是常考的同义替换词，别被生词卡住。", difficulty: 0.4),
        Question(id: "ln10", module: .listening, levelId: "L7",
            stem: "When will boarding begin?",
            listeningScript: script2,
            options: ["At 10:15", "30 minutes before 11:40", "Right after this announcement", "At 12:00"], answer: 1,
            pointTag: "听力·设问预判+计算",
            strategy: ["预判这是需要结合两个数字推理的题", "激活 boarding begin…before the new departure time", "锁定信号词 thirty minutes before the new departure time，对应 11:40 之前 30 分钟"],
            trap: "这类题听到的是‘相对时间’，要换算成具体时刻，不能直接选某个绝对数字。", difficulty: 0.6),
    ]

    // MARK: 第三段·校园社团报名对话 ln11–ln15

    private static let script3 =
    "W: Hi, are you still taking sign-ups for the photography club? " +
    "M: Yes, we are. We meet every Wednesday afternoon in Room 203. " +
    "W: Great. Is there a fee to join? " +
    "M: It's twenty yuan a semester, mainly for printing photos. " +
    "W: That's reasonable. Actually, I was also thinking about the debate club, but I love taking pictures more. " +
    "M: Sounds like photography is the right choice for you, then. Can I have your name and class? " +
    "W: Sure, I'm Lily, from Class Three, Grade Two."

    static let passage3Questions: [Question] = [
        Question(id: "ln11", module: .listening, levelId: "L7",
            stem: "Where does this conversation take place?",
            listeningScript: script3,
            options: ["At a school", "At a photo studio", "At a bookstore", "At a sports center"], answer: 0,
            pointTag: "听力·场景定位",
            strategy: ["预判场景题，激活‘校园社团’场景词：club, sign-up, Room", "听到 Room 203 / Class Three, Grade Two", "锁定 At a school"],
            trap: "出现 photography 不代表是‘照相馆’，要看整体对话主线(报名社团)。", difficulty: 0.3),
        Question(id: "ln12", module: .listening, levelId: "L7",
            stem: "How much does it cost to join the photography club?",
            listeningScript: script3,
            options: ["10 yuan", "20 yuan", "30 yuan", "It's free"], answer: 1,
            pointTag: "听力·数字信息",
            strategy: ["预判数字题，激活费用相关表达 a fee", "听到 It's twenty yuan a semester", "锁定 20 yuan"],
            trap: "金额题只认明确报出的数字，不要把‘a semester’听成数字的一部分。", difficulty: 0.3),
        Question(id: "ln13", module: .listening, levelId: "L7",
            stem: "Which club did the woman also consider joining?",
            listeningScript: script3,
            options: ["The debate club", "The music club", "The art club", "The drama club"], answer: 0,
            pointTag: "听力·细节捕捉",
            strategy: ["预判细节题，留意 also/actually 这类追加信息信号词", "听到 Actually, I was also thinking about the debate club", "锁定 the debate club"],
            trap: "‘也考虑过’不是‘最终选择’，别和最终决定的社团搞混。", difficulty: 0.4),
        Question(id: "ln14", module: .listening, levelId: "L7",
            stem: "Why does the woman finally choose the photography club?",
            listeningScript: script3,
            options: ["She loves taking pictures more", "It has no membership fee", "Her friends joined it", "It meets on weekends"], answer: 0,
            pointTag: "听力·原因捕捉",
            strategy: ["预判原因题，激活对比性信号词 but/more", "听到 but I love taking pictures more", "锁定‘更喜欢拍照’为真正原因"],
            trap: "but 后面才是转折后的真实想法，转折前的内容(辩论社)只是干扰。", difficulty: 0.45),
        Question(id: "ln15", module: .listening, levelId: "L7",
            stem: "What will the woman probably do next?",
            listeningScript: script3,
            options: ["Give her name and class to join", "Pay the membership fee immediately", "Leave to think it over", "Ask for a discount"], answer: 0,
            pointTag: "听力·下一步行动预判",
            strategy: ["预判这是‘接下来做什么’的行动题", "听到男生问 Can I have your name and class?", "女生直接回答姓名班级，可推断下一步是完成报名信息登记"],
            trap: "行动题答案常在对话最后一句的回应里，要听到底，不能停在提问处。", difficulty: 0.5),
    ]

    // MARK: 第四段·校外考察天气播报 ln16–ln20

    private static let script4 =
    "Good morning, everyone. Before we set off for tomorrow's field trip to Pine Hill, let me share the " +
    "weather forecast. It will be mostly sunny in the morning, with the temperature around eighteen degrees. " +
    "However, there is a chance of light rain in the afternoon, and the temperature may drop to twelve degrees. " +
    "So please bring a light jacket and an umbrella, just in case. Also, wear comfortable shoes, since we'll be " +
    "walking for almost two hours on hill paths."

    static let passage4Questions: [Question] = [
        Question(id: "ln16", module: .listening, levelId: "L7",
            stem: "What is this talk mainly about?",
            listeningScript: script4,
            options: ["The weather forecast for tomorrow's trip", "The history of Pine Hill", "The rules of the school trip", "The cost of the field trip"], answer: 0,
            pointTag: "听力·主旨判断",
            strategy: ["预判主旨题，先听首句定话题", "开头 let me share the weather forecast 直接点出主题", "锁定‘明日出行的天气预报’"],
            trap: "出现 Pine Hill 不代表主题是‘景点历史’，要看说话人真正想传达的信息。", difficulty: 0.35),
        Question(id: "ln17", module: .listening, levelId: "L7",
            stem: "What will the weather be like in the morning?",
            listeningScript: script4,
            options: ["Mostly sunny", "Heavy rain", "Strong wind", "Snowy"], answer: 0,
            pointTag: "听力·细节捕捉",
            strategy: ["预判细节题，激活时间词 in the morning", "听到 mostly sunny in the morning", "锁定 Mostly sunny"],
            trap: "题目问的是‘上午’，别用下午的天气(light rain)来误答。", difficulty: 0.3),
        Question(id: "ln18", module: .listening, levelId: "L7",
            stem: "What is the temperature likely to be in the afternoon?",
            listeningScript: script4,
            options: ["18 degrees", "15 degrees", "12 degrees", "20 degrees"], answer: 2,
            pointTag: "听力·数字信息",
            strategy: ["预判数字题，激活 afternoon 对应的时间段", "听到 temperature may drop to twelve degrees", "锁定 12 degrees"],
            trap: "18 degrees 是上午的温度，是典型的时间错位干扰项。", difficulty: 0.4),
        Question(id: "ln19", module: .listening, levelId: "L7",
            stem: "Why are students advised to bring an umbrella?",
            listeningScript: script4,
            options: ["There may be light rain in the afternoon", "It is a souvenir of the trip", "The guide asked them to", "It will be sunny all day"], answer: 0,
            pointTag: "听力·原因捕捉",
            strategy: ["预判原因题，激活 so/just in case 这类因果信号词", "听到 chance of light rain in the afternoon, so please bring…an umbrella", "锁定‘可能下小雨’为原因"],
            trap: "‘just in case’提示的是‘以防万一’，不代表一定会下雨，但仍是带伞的原因。", difficulty: 0.45),
        Question(id: "ln20", module: .listening, levelId: "L7",
            stem: "What else are students reminded to do?",
            listeningScript: script4,
            options: ["Wear comfortable shoes", "Bring extra money", "Arrive early", "Take notes during the trip"], answer: 0,
            pointTag: "听力·细节捕捉",
            strategy: ["预判细节题，留意 also 引出的并列提醒", "信号词 Also, wear comfortable shoes", "锁定‘穿舒适的鞋子’"],
            trap: "‘Also’引出的是并列的第二条提醒，容易在听完第一条建议后漏听。", difficulty: 0.4),
    ]

    // MARK: 第五段·图书馆续借对话 ln21–ln25

    private static let script5 =
    "W: Excuse me, could I renew this book? I'm not finished reading it yet. " +
    "M: Let me check the system... You're in luck, it hasn't been reserved by anyone else, so you can renew it once for two more weeks. " +
    "W: Great, thank you. By the way, I think I returned a book three days late last month. Will there be a fine? " +
    "M: Let me see... yes, there's a fine of one yuan per day, so that would be three yuan in total. " +
    "W: That's fine, I'll pay it now. Could you also recommend a good book on space exploration? " +
    "M: Sure, we just got a new one called Journey to Mars, it's very popular right now. " +
    "W: Perfect, I'll borrow that one too."

    static let passage5Questions: [Question] = [
        Question(id: "ln21", module: .listening, levelId: "L7",
            stem: "Where does this conversation most likely take place?",
            listeningScript: script5,
            options: ["At a library", "At a bookstore", "At a school office", "At a publishing house"], answer: 0,
            pointTag: "听力·场景定位",
            strategy: ["听前预判场景题，激活‘图书馆’场景词：renew, book, fine", "开头 could I renew this book 直接点出场景", "锁定 At a library"],
            trap: "出现 Journey to Mars 这类书名不代表场景是‘书店’，要看整体对话主线(续借+罚款)。", difficulty: 0.3),
        Question(id: "ln22", module: .listening, levelId: "L7",
            stem: "How much longer can the woman keep the book she's renewing?",
            listeningScript: script5,
            options: ["One more week", "Two more weeks", "Three more weeks", "One more month"], answer: 1,
            pointTag: "听力·数字信息",
            strategy: ["预判数字题，激活续借时长表达", "听到 renew it once for two more weeks", "锁定 two more weeks"],
            trap: "别把后面‘三天迟还’的 three 和这里的续借周数搞混。", difficulty: 0.3),
        Question(id: "ln23", module: .listening, levelId: "L7",
            stem: "Why does the woman need to pay a fine?",
            listeningScript: script5,
            options: ["She returned a book late last month", "She lost a book", "She damaged a book", "She borrowed too many books"], answer: 0,
            pointTag: "听力·原因捕捉",
            strategy: ["预判原因题，激活 fine 前后的因果描述", "听到 I returned a book three days late last month", "锁定‘还书迟了’为原因"],
            trap: "选项里的丢书、损坏书都是常见干扰项，原文只提到‘迟还’。", difficulty: 0.4),
        Question(id: "ln24", module: .listening, levelId: "L7",
            stem: "How much fine does the woman need to pay?",
            listeningScript: script5,
            options: ["One yuan", "Two yuan", "Three yuan", "Five yuan"], answer: 2,
            pointTag: "听力·设问预判+计算",
            strategy: ["预判这是需要结合两个数字推理的题", "激活 a fine of one yuan per day 与 three days late", "1 元/天 × 3 天 = 3 元，锁定 three yuan"],
            trap: "听到的是‘每天 1 元’的单价，不能直接选 one yuan，要乘以迟还天数。", difficulty: 0.55),
        Question(id: "ln25", module: .listening, levelId: "L7",
            stem: "What will the woman probably do next?",
            listeningScript: script5,
            options: ["Borrow the book about space exploration", "Return the book immediately", "Ask for a refund of the fine", "Cancel her library card"], answer: 0,
            pointTag: "听力·下一步行动预判",
            strategy: ["预判行动题，留意对话结尾处的回应", "男生推荐 Journey to Mars 后，女生说 Perfect, I'll borrow that one too", "锁定‘借走这本新书’"],
            trap: "行动题答案常在对话最后一句，别停在‘交罚款’这一步就选了中间项。", difficulty: 0.45),
    ]

    // MARK: 第六段·校园广播义卖通知 ln26–ln30

    private static let script6 =
    "Good afternoon, everyone. This is a reminder about tomorrow's charity bake sale in the school hall. " +
    "All the cakes and cookies are made by Class Two students, and every item costs just five yuan. " +
    "All the money raised will go to children in need at our sister school in the mountains. " +
    "The sale starts right after lunch, at twelve thirty, and will only last for one hour, so please come early if " +
    "you want to get the best cakes. If you'd like to help out at the stall instead of just buying, please sign up " +
    "at the school office before four o'clock today. Let's all support this meaningful event."

    static let passage6Questions: [Question] = [
        Question(id: "ln26", module: .listening, levelId: "L7",
            stem: "What is this announcement mainly about?",
            listeningScript: script6,
            options: ["A charity bake sale tomorrow", "A new school rule", "A change in the lunch menu", "A class election"], answer: 0,
            pointTag: "听力·主旨判断",
            strategy: ["预判主旨题，先听首句定话题", "开头 reminder about tomorrow's charity bake sale 直接点出主题", "锁定‘明日义卖’"],
            trap: "出现 Class Two 不代表主题是‘班级事务’，要看说话人真正想传达的通知内容。", difficulty: 0.35),
        Question(id: "ln27", module: .listening, levelId: "L7",
            stem: "How much does each item cost at the sale?",
            listeningScript: script6,
            options: ["Three yuan", "Five yuan", "Eight yuan", "Ten yuan"], answer: 1,
            pointTag: "听力·数字信息",
            strategy: ["预判数字题，激活价格表达 costs", "听到 every item costs just five yuan", "锁定 five yuan"],
            trap: "其余数字均为原文未提及的干扰项，别和后面的时间数字混淆。", difficulty: 0.3),
        Question(id: "ln28", module: .listening, levelId: "L7",
            stem: "What will the money raised be used for?",
            listeningScript: script6,
            options: ["To help children at a sister school", "To buy new books for the library", "To repair the school hall", "To reward top students"], answer: 0,
            pointTag: "听力·细节捕捉",
            strategy: ["预判细节题，留意 go to 后面给出的去向", "听到 the money raised will go to children in need at our sister school", "锁定‘帮助山区姐妹学校的孩子’"],
            trap: "其余选项都是常见的‘善款用途’干扰项，原文只提到‘姐妹学校的孩子’。", difficulty: 0.4),
        Question(id: "ln29", module: .listening, levelId: "L7",
            stem: "When does the sale start?",
            listeningScript: script6,
            options: ["Right after breakfast", "At twelve thirty", "At four o'clock", "Right after school"], answer: 1,
            pointTag: "听力·数字信息",
            strategy: ["预判数字题，激活开始时间表达", "听到 the sale starts right after lunch, at twelve thirty", "锁定 at twelve thirty"],
            trap: "‘四点’是后面报名截止时间，别和开卖时间搞混。", difficulty: 0.35),
        Question(id: "ln30", module: .listening, levelId: "L7",
            stem: "What should students do if they want to help at the stall?",
            listeningScript: script6,
            options: ["Sign up at the school office before four o'clock", "Bring their own cakes to sell", "Ask their teacher for permission first", "Pay a deposit in advance"], answer: 0,
            pointTag: "听力·下一步行动预判",
            strategy: ["预判行动题，留意通知最后给出的具体步骤", "信号词 please sign up at the school office before four o'clock", "锁定‘去学校办公室报名’"],
            trap: "行动题要听到通知结尾的具体要求，不能停在‘想帮忙’这一意愿表达上。", difficulty: 0.45),
    ]
}
