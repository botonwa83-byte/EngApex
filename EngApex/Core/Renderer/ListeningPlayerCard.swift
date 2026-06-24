import SwiftUI

/// 听力播放卡：播放/重播按钮 + 已播次数提示。做题/模考/复习三处共用同一组件与播放器。
struct ListeningPlayerCard: View {
    let script: String
    @Binding var playCount: Int
    /// 单次练习/模考限播次数；nil = 不限（复习场景，服务于练熟而非模拟考场）。
    var maxPlays: Int? = 2

    @ObservedObject private var player = SpeechPlayer.shared

    private var reachedLimit: Bool {
        guard let maxPlays else { return false }
        return playCount >= maxPlays
    }

    var body: some View {
        HStack(spacing: Spacing.md) {
            Button {
                playCount += 1
                player.play(script)
            } label: {
                Image(systemName: player.isPlaying ? "waveform" : "play.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(reachedLimit ? .secondary : .apexStarBlue)
            }
            .disabled(reachedLimit || player.isPlaying)

            VStack(alignment: .leading, spacing: 2) {
                Text(statusText).font(AppFont.body)
                if let maxPlays {
                    Text("已播 \(playCount)/\(maxPlays) 次").font(AppFont.caption).foregroundColor(.secondary)
                } else {
                    Text("可重复回听").font(AppFont.caption).foregroundColor(.secondary)
                }
            }
            Spacer()
        }
        .cardSurface(padding: Spacing.md)
    }

    private var statusText: String {
        if player.isPlaying { return "正在播放…" }
        if playCount == 0 { return "点击播放听力材料" }
        return reachedLimit ? "已达播放上限" : "播放完毕，可重听"
    }
}
