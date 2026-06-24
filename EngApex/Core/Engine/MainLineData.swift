import Foundation

/// 主线「提分之路」的关卡定义（提分七关）。
/// 顺序按"规则强、易提分"在前排布；提分雷达会叠加在其上动态推荐先打哪关。
enum MainLineData {

    static let levels: [MainLevel] = [
        MainLevel(id: "L1", order: 1, module: .grammarFill,
            title: "语法的骨架", subtitle: "语法填空 · 15 分",
            modelNote: "决策树：先判有无提示词。有提示词→改词形(时态/语态/非谓语/比较级)；无提示词→填连词/介词/冠词/代词。规则最强、最易提分，所以排第一关。",
            questionIds: ["g1", "g2", "g3", "g4"], isFree: true),
        MainLevel(id: "L2", order: 2, module: .cloze,
            title: "词块与逻辑", subtitle: "完形填空 · 15 分",
            modelNote: "三类考点：①逻辑词(转折/因果/递进) ②固定搭配 ③语境复现。四步法：看空格前后→定词性→定逻辑方向→用复现/搭配排除。",
            questionIds: ["c1", "c2", "c3", "c4"], isFree: true),
        MainLevel(id: "L3", order: 3, module: .sevenChoose,
            title: "衔接的信号", subtitle: "七选五 · 12.5 分",
            modelNote: "靠三类衔接信号定位：代词指代(them/it)、连接词(However/For example)、复现词。空前空后的信号词，往往直接锁定答案。",
            questionIds: ["s1", "s2", "s3"], isFree: true),
        MainLevel(id: "L4", order: 4, module: .reading,
            title: "阅读的定位", subtitle: "阅读理解 · 37.5 分",
            modelNote: "四题型四套打法：细节题回原文定位+同义改写；主旨题抓首尾高频词；推理题‘有据可依’不臆造；词义猜测靠上下文。权重最大，值得重投。",
            questionIds: ["r1", "r2", "r3", "r4"], isFree: false),
        MainLevel(id: "L5", order: 5, module: .appliedWriting,
            title: "模板与亮点", subtitle: "应用文写作 · 15 分",
            modelNote: "骨架=三段式(目的→细节→期待)+礼貌语域。提分靠亮点句:I'm writing to…/I would appreciate it if…/精准动词 improve。",
            questionIds: ["a1", "a2", "a3"], isFree: false),
        MainLevel(id: "L6", order: 6, module: .continuation,
            title: "情节与续写", subtitle: "读后续写 · 25 分",
            modelNote: "情节链:环境→动作→心理→转机。高分技巧:化情绪为身体反应(A chill ran down his spine)、用 as 制造伴随画面、承接上文不跳脱。",
            questionIds: ["k1", "k2", "k3"], isFree: false),
        MainLevel(id: "L7", order: 7, module: .listening,
            title: "听力的预判", subtitle: "听力 · 30 分",
            modelNote: "决策树：听前先扫一遍选项，预判设问类型(地点/数字/态度/原因)，并激活对应场景词；听音频时只抓与设问匹配的信号词，听到即锁定答案，不等全文放完。常见陷阱：同音词干扰、先提及的信息被后文修正、转折词(but/actually)之后才是真正答案。",
            questionIds: ["ln1", "ln2", "ln3", "ln4", "ln5"], isFree: false),
    ]

    static func level(id: String) -> MainLevel? { levels.first { $0.id == id } }
    static func level(for module: ExamModule) -> MainLevel? { levels.first { $0.module == module } }
}
