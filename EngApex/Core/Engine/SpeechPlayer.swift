import AVFoundation

/// 听力材料朗读器：用系统离线语音合成朗读 listeningScript，零音频资源、零 API。
/// 脚本里的"W:"/"M:"只用来按说话人切句和换声，本身不会被朗读出来；两个角色各配男女声，更接近真实对话感。
final class SpeechPlayer: NSObject, ObservableObject {
    static let shared = SpeechPlayer()

    @Published private(set) var isPlaying = false

    private let synthesizer = AVSpeechSynthesizer()
    private lazy var womanVoice = Self.voice(gender: .female)
    private lazy var manVoice = Self.voice(gender: .male)
    private var pendingCount = 0

    private override init() {
        super.init()
        synthesizer.delegate = self
        try? AVAudioSession.sharedInstance().setCategory(.playback)
    }

    /// 一句台词：speaker 为 "W"/"M"，独白材料无说话人标签时为 nil。
    private struct Line {
        let speaker: Character?
        let text: String
    }

    func play(_ script: String) {
        stop()
        let lines = Self.parseLines(script)
        guard !lines.isEmpty else { return }
        pendingCount = lines.count
        isPlaying = true
        for line in lines {
            let utterance = AVSpeechUtterance(string: line.text)
            utterance.voice = voice(for: line.speaker)
            utterance.rate = AVSpeechUtteranceDefaultSpeechRate * 0.92
            synthesizer.speak(utterance)
        }
    }

    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
        pendingCount = 0
        isPlaying = false
    }

    private func voice(for speaker: Character?) -> AVSpeechSynthesisVoice? {
        switch speaker {
        case "M": return manVoice ?? womanVoice
        default:  return womanVoice
        }
    }

    /// 按 "W: "/"M: " 切分台词；标签本身从待朗读文本里剥离，独白材料(无标签)整段作为一句。
    private static func parseLines(_ script: String) -> [Line] {
        guard let regex = try? NSRegularExpression(pattern: #"\b([WM]):\s*"#) else {
            return [Line(speaker: nil, text: script)]
        }
        let ns = script as NSString
        let matches = regex.matches(in: script, range: NSRange(location: 0, length: ns.length))
        guard !matches.isEmpty else { return [Line(speaker: nil, text: script)] }

        var lines: [Line] = []
        for (i, match) in matches.enumerated() {
            let speaker = Character(ns.substring(with: match.range(at: 1)))
            let textStart = match.range.location + match.range.length
            let textEnd = i + 1 < matches.count ? matches[i + 1].range.location : ns.length
            let text = ns.substring(with: NSRange(location: textStart, length: textEnd - textStart))
                .trimmingCharacters(in: .whitespacesAndNewlines)
            if !text.isEmpty { lines.append(Line(speaker: speaker, text: text)) }
        }
        return lines
    }

    private static func voice(gender: AVSpeechSynthesisVoiceGender) -> AVSpeechSynthesisVoice? {
        AVSpeechSynthesisVoice.speechVoices()
            .first { $0.language.hasPrefix("en") && $0.gender == gender }
            ?? AVSpeechSynthesisVoice(language: "en-US")
    }
}

extension SpeechPlayer: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        utteranceDidEnd()
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        utteranceDidEnd()
    }

    private func utteranceDidEnd() {
        pendingCount = max(0, pendingCount - 1)
        if pendingCount == 0 { isPlaying = false }
    }
}
