import Foundation

/// 写作教练(规则版)：纯本地规则扫描学生自己写的草稿，不联网、不评官方分数，只给可执行的修改提示。
/// 守住"不做假 AI 批改"的诚信红线——所有结论都是可解释的规则触发，不是模型臆断。
enum WritingCoachEngine {

    enum Severity: Equatable { case good, tip, warning }

    struct Finding {
        let severity: Severity
        let message: String
    }

    /// `requiredLeads`：读后续写需要承接的给定首句；应用文等不需要此项检查时传空数组。
    static func diagnose(_ text: String, requiredLeads: [String] = []) -> [Finding] {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            return [Finding(severity: .warning, message: "还没有写下任何内容，先动笔试试看。")]
        }
        var findings: [Finding] = []
        findings += checkLength(trimmed)
        findings += checkMechanics(trimmed)
        findings += checkWeakWords(trimmed)
        findings += checkRepetition(trimmed)
        findings += checkAdvancedPatterns(trimmed)
        if !requiredLeads.isEmpty { findings += checkLeads(trimmed, requiredLeads) }
        return findings
    }

    // MARK: 篇幅

    private static func wordCount(_ text: String) -> Int {
        text.split(whereSeparator: { $0.isWhitespace || $0.isNewline }).count
    }

    private static func checkLength(_ text: String) -> [Finding] {
        let words = wordCount(text)
        if words < 40 {
            return [Finding(severity: .warning, message: "全文约 \(words) 词，高考续写/应用文一般需要 100 词左右，内容可能没有充分展开。")]
        }
        if words > 220 {
            return [Finding(severity: .tip, message: "全文约 \(words) 词，明显超过常规篇幅，注意考场时间分配，不必堆砌过多细节。")]
        }
        return [Finding(severity: .good, message: "篇幅约 \(words) 词，长度合适。")]
    }

    // MARK: 基本规范

    private static func checkMechanics(_ text: String) -> [Finding] {
        var findings: [Finding] = []
        if let first = text.first, !first.isUppercase {
            findings.append(Finding(severity: .warning, message: "首字母没有大写，注意开头的大小写规范。"))
        }
        if let last = text.last, !".!?\"'".contains(last) {
            findings.append(Finding(severity: .warning, message: "结尾没有标点收尾，检查是否漏掉句号/问号/感叹号。"))
        }
        if let regex = try? NSRegularExpression(pattern: "(?<![A-Za-z'])i(?![A-Za-z'])") {
            let count = regex.numberOfMatches(in: text, range: NSRange(text.startIndex..., in: text))
            if count > 0 {
                findings.append(Finding(severity: .warning, message: "发现 \(count) 处独立的小写 \"i\"，作主语的 I 必须大写。"))
            }
        }
        return findings
    }

    // MARK: 弱词/直白表达

    private struct WeakWord { let word: String; let suggestion: String }

    private static let weakWords: [WeakWord] = [
        WeakWord(word: "very", suggestion: "very + 形容词较笼统，可换成更精准的形容词，或用 extremely/remarkably 等程度副词。"),
        WeakWord(word: "good", suggestion: "good 较笼统，可视语境换成 wonderful/remarkable/outstanding。"),
        WeakWord(word: "happy", suggestion: "直接说 happy 不如化情绪为身体反应，如 A wave of joy washed over him。"),
        WeakWord(word: "sad", suggestion: "直接说 sad 不如用画面表达，如 Her heart sank。"),
        WeakWord(word: "afraid", suggestion: "直接说 afraid 不如用身体反应，如 A chill ran down his spine。"),
        WeakWord(word: "said", suggestion: "said 反复出现可换成 whispered/murmured/exclaimed，区分语气。"),
        WeakWord(word: "get", suggestion: "get 含义模糊，可换成更精准的动词，如 obtain/achieve/receive。"),
        WeakWord(word: "thing", suggestion: "thing 过于笼统，尽量换成具体名词。"),
    ]

    private static func occurrenceCount(of word: String, in lowercasedText: String) -> Int {
        guard let regex = try? NSRegularExpression(pattern: "\\b\(NSRegularExpression.escapedPattern(for: word))\\b") else { return 0 }
        return regex.numberOfMatches(in: lowercasedText, range: NSRange(lowercasedText.startIndex..., in: lowercasedText))
    }

    private static func checkWeakWords(_ text: String) -> [Finding] {
        let lower = text.lowercased()
        return weakWords.compactMap { ww in
            let count = occurrenceCount(of: ww.word, in: lower)
            guard count >= 2 else { return nil }
            return Finding(severity: .tip, message: "\"\(ww.word)\" 出现了 \(count) 次——\(ww.suggestion)")
        }
    }

    // MARK: 用词重复

    private static let stopwords: Set<String> = [
        "that", "this", "with", "from", "they", "their", "were", "have", "what", "when", "then", "than",
        "there", "which", "while", "about", "into", "such", "some", "more", "most", "very", "also", "just",
        "like", "upon", "over", "after", "before", "because", "could", "would", "should", "still", "even",
        "only", "know", "never", "every", "other", "your", "them", "here",
    ]

    private static func checkRepetition(_ text: String) -> [Finding] {
        let words = text.lowercased().split { !($0.isLetter) }.map(String.init)
            .filter { $0.count >= 4 && !stopwords.contains($0) }
        guard !words.isEmpty else { return [] }
        var freq: [String: Int] = [:]
        for w in words { freq[w, default: 0] += 1 }
        return freq.filter { $0.value >= 4 }.sorted { $0.value > $1.value }.prefix(2).map { word, count in
            Finding(severity: .tip, message: "\"\(word)\" 重复出现了 \(count) 次，试试用同义词或代词替换，让表达更丰富。")
        }
    }

    // MARK: 加分句式

    private static let advancedMarkers = ["not only", "no sooner", "it was not until", "such was", "rather than", "as if"]

    private static func checkAdvancedPatterns(_ text: String) -> [Finding] {
        let lower = text.lowercased()
        if let hit = advancedMarkers.first(where: { lower.contains($0) }) {
            return [Finding(severity: .good, message: "检测到加分句式 \"\(hit)\"，这类结构能让阅卷老师眼前一亮，继续保持。")]
        }
        let example = PhraseBook.cards(in: .sentencePattern).first?.en ?? "Not only did she finish early, but she also helped others."
        return [Finding(severity: .tip, message: "全文暂未检测到强调句/倒装/让步等加分句式，可以试着加一句，例如：\(example)")]
    }

    // MARK: 续写承接首句

    private static func checkLeads(_ text: String, _ leads: [String]) -> [Finding] {
        let lowerText = text.lowercased()
        return leads.compactMap { lead in
            let normalized = lead.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            let probe = String(normalized.prefix(20))
            guard !probe.isEmpty, !lowerText.contains(probe) else { return nil }
            return Finding(severity: .warning, message: "没有检测到衔接给定首句\u{201c}\(lead)\u{201d}，续写必须原样承接给定首句，不能另起开头。")
        }
    }
}
