import Foundation

/// 三期扩充（第六批）。阅读理解补两篇较长的说明文/议论文(r31-r39)，弥补现有阅读材料偏短、偏记叙文的缺口。
extension QuestionBank {

    static let extended6: [Question] = reading6 + reading6Part2

    // MARK: 阅读理解·说明文(城市热岛效应) r31-r35

    private static let passageHeatIsland =
    "Step into any major city on a summer afternoon, and you will likely notice something curious: it feels " +
    "noticeably hotter than the countryside just a few kilometers away, even though both areas receive the same " +
    "sunlight. This phenomenon, known as the urban heat island effect, occurs because cities are covered with " +
    "concrete, asphalt, and glass—materials that absorb and retain heat far more efficiently than soil, grass, or trees.\n\n" +
    "During the day, these surfaces soak up solar energy like a sponge. At night, instead of cooling down quickly, " +
    "they slowly release that stored heat back into the air, keeping urban temperatures uncomfortably high long " +
    "after sunset. Tall buildings make the problem worse by blocking wind that would otherwise help disperse the " +
    "trapped heat, while the lack of vegetation means less natural cooling through shade and evaporation.\n\n" +
    "The consequences go beyond simple discomfort. Higher temperatures increase electricity demand for air " +
    "conditioning, which in turn raises emissions from power plants—creating a frustrating cycle. Some cities have " +
    "begun fighting back by painting rooftops white to reflect sunlight, planting more street trees, and designing " +
    "parks that double as cooling corridors. These small changes, researchers say, can lower local temperatures by " +
    "several degrees, proving that thoughtful design can make a real difference in how a city feels to live in."

    static let reading6: [Question] = [
        Question(id: "r31", module: .reading, levelId: "L4",
            stem: passageHeatIsland + "\n\nWhat causes cities to retain more heat than the countryside?",
            options: ["Concrete, asphalt, and glass absorb and release heat more than natural surfaces.",
                      "Cities receive more direct sunlight than rural areas.",
                      "Cities have fewer clouds blocking the sun.", "Cities are built closer to the equator."], answer: 0,
            pointTag: "阅读·细节·原因定位",
            strategy: ["回原文 cities are covered with concrete, asphalt, and glass...absorb and retain heat", "对比城乡材料差异即为原因", "选材料吸热散热慢"],
            trap: "其余选项都是编造的伪原因，原文从未提及日照量或纬度差异。", difficulty: 0.4),
        Question(id: "r32", module: .reading, levelId: "L4",
            stem: passageHeatIsland + "\n\nWhy does the passage mention tall buildings blocking wind?",
            options: ["To explain another factor that worsens the heat island effect.",
                      "To suggest that tall buildings should be banned in cities.",
                      "To argue that wind power cannot work in cities.", "To prove that tall buildings are visually unattractive."], answer: 0,
            pointTag: "阅读·推理·论证功能",
            strategy: ["定位 Tall buildings make the problem worse by blocking wind", "这是在补充另一个加剧热岛效应的因素", "选'解释加剧因素'而非政策建议或外貌评价"],
            trap: "其余选项都是过度引申，原文只是说明原因，没有提出禁令或评价美观。", difficulty: 0.6),
        Question(id: "r33", module: .reading, levelId: "L4",
            stem: passageHeatIsland + "\n\nThe underlined word \"sponge\" in the second paragraph is used to illustrate ___.",
            options: ["how surfaces absorb heat the way a sponge absorbs water.", "how cities are shaped like sponges.",
                      "how sponges are used to clean streets.", "how heat is invisible like water in a sponge."], answer: 0,
            pointTag: "阅读·词义猜测·比喻",
            strategy: ["soak up solar energy like a sponge 是比喻", "本体是'表面吸收太阳能'，喻体是'海绵吸水'", "选'表面像海绵一样吸热'"],
            trap: "其余选项把比喻字面化或答非所问，没有抓住'吸收'这一类比核心。", difficulty: 0.5),
        Question(id: "r34", module: .reading, levelId: "L4",
            stem: passageHeatIsland + "\n\nWhat is the main idea of the last paragraph?",
            options: ["Cities are taking practical steps to reduce the urban heat island effect.",
                      "Air conditioning is the only solution to urban heat.",
                      "The heat island effect cannot be solved by design changes.", "Painting rooftops white has no real effect on temperature."], answer: 0,
            pointTag: "阅读·主旨·段落概括",
            strategy: ["抓首句 The consequences go beyond simple discomfort 与后续例证", "末段列举了多种缓解措施(白色屋顶/种树/公园)", "概括为'城市正采取实际措施缓解热岛效应'"],
            trap: "其余选项都与段落'列举有效措施'的内容相反或片面。", difficulty: 0.55),
        Question(id: "r35", module: .reading, levelId: "L4",
            stem: passageHeatIsland + "\n\nWhat can be inferred about the relationship between higher temperatures and electricity use?",
            options: ["They reinforce each other in a cycle that is hard to break.",
                      "Electricity use causes the urban heat island effect directly.",
                      "Higher temperatures always lead to power outages.", "Electricity demand decreases as cities get hotter."], answer: 0,
            pointTag: "阅读·推理·因果链",
            strategy: ["定位 raises emissions...creating a frustrating cycle", "气温升高→空调需求增加→排放增加→气温升高，是循环关系", "选'相互强化的循环'"],
            trap: "其余选项把因果关系简化或扭曲，均无原文依据。", difficulty: 0.6),
    ]

    // MARK: 阅读理解·议论文(失败的价值) r36-r39

    private static let passageFailure =
    "There is a quiet but persistent belief in many classrooms that failure is something to be avoided at all " +
    "costs. Parents praise high marks, schools reward consistency, and students learn early on to fear the red " +
    "ink of a wrong answer. Yet a growing number of educators now argue that this fear of failure may be doing " +
    "more harm than good.\n\n" +
    "Consider how scientists work: a single successful experiment is usually built upon dozens of failed ones. " +
    "Each failed attempt narrows down what doesn't work, gradually pointing the way toward what does. If students " +
    "are taught to see every mistake as a disaster rather than a clue, they lose access to one of learning's most " +
    "powerful tools.\n\n" +
    "Critics of this view argue that constant failure can crush a student's confidence, especially for those who " +
    "are already struggling. This is a fair concern, but it misses an important distinction: it is not failure " +
    "itself that damages confidence, but failure without guidance or support. When a teacher helps a student " +
    "understand exactly why an answer was wrong, the same mistake becomes a stepping stone rather than a dead end.\n\n" +
    "Rather than eliminating failure from education, perhaps it is time to redesign how we respond to it—treating " +
    "each wrong answer not as a verdict on a student's worth, but as a piece of useful information on the road to mastery."

    static let reading6Part2: [Question] = [
        Question(id: "r36", module: .reading, levelId: "L4",
            stem: passageFailure + "\n\nWhat is the author's main argument in this passage?",
            options: ["Failure, when properly guided, can be a valuable part of learning.",
                      "Schools should stop grading students' work.", "Scientists never fail during their experiments.",
                      "Students who fail often lack the ability to succeed."], answer: 0,
            pointTag: "阅读·主旨·议论文中心论点",
            strategy: ["抓首尾段：开头质疑'惧怕失败'，结尾提出'重新设计应对失败的方式'", "全文围绕'失败可以是学习工具'展开论证", "选'引导得当的失败是学习的宝贵部分'"],
            trap: "其余选项都偏离或歪曲了作者的真实立场。", difficulty: 0.5),
        Question(id: "r37", module: .reading, levelId: "L4",
            stem: passageFailure + "\n\nWhy does the author mention how scientists work?",
            options: ["To use a real-world example that supports the idea that failure leads to progress.",
                      "To suggest that only scientists benefit from failure.", "To prove that science is more important than other subjects.",
                      "To criticize scientists for failing too often."], answer: 0,
            pointTag: "阅读·推理·论证方法",
            strategy: ["科学家的例子紧跟在'惧怕失败有害'这一论点后", "用具体领域的事实支撑抽象论点", "选'用真实例子支持失败推动进步的观点'"],
            trap: "其余选项把举例的论证功能误解为对科学家的评价或学科比较。", difficulty: 0.6),
        Question(id: "r38", module: .reading, levelId: "L4",
            stem: passageFailure + "\n\nAccording to the author, what truly damages a student's confidence?",
            options: ["Failure without guidance or support, not failure itself.",
                      "Receiving too much praise from teachers.", "Taking too many exams in a single year.",
                      "Comparing oneself to high-achieving classmates."], answer: 0,
            pointTag: "阅读·细节·概念辨析",
            strategy: ["定位 it is not failure itself...but failure without guidance or support", "原文明确区分'失败本身'与'缺乏引导的失败'", "选后者"],
            trap: "其余选项都是原文未提及的编造细节。", difficulty: 0.55),
        Question(id: "r39", module: .reading, levelId: "L4",
            stem: passageFailure + "\n\nWhat does the phrase \"a stepping stone rather than a dead end\" suggest about the author's attitude toward mistakes?",
            options: ["Mistakes can lead to further progress if handled well, rather than blocking it entirely.",
                      "Mistakes always end a student's chance to improve.", "Mistakes are stones that should be removed from the classroom.",
                      "Mistakes are dead ends that cannot be avoided."], answer: 0,
            pointTag: "阅读·词义猜测·比喻+态度",
            strategy: ["stepping stone(垫脚石) vs dead end(死胡同) 是对比比喻", "垫脚石=帮助前进；死胡同=无法继续", "结合上下文'引导得当'，选'处理得当则能促进进步'"],
            trap: "其余选项都把比喻理解反了或字面化。", difficulty: 0.6),
    ]
}
