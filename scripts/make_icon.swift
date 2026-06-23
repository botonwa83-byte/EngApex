// EngApex 应用图标生成器
// 蓝→翠绿品牌渐变（对齐 PromoView Logo）+ 居中白色学士帽符号。无文字、无黑底。
// 用法：swift scripts/make_icon.swift  → 覆盖 AppIcon-1024.png
import AppKit

let S: CGFloat = 1024
let canvas = NSImage(size: NSSize(width: S, height: S))
canvas.lockFocus()

// 背景渐变：左下 starBlue(0x42A5F5) → 右上 emerald(0x26A69A)
let grad = NSGradient(starting: NSColor(red: 0x42/255, green: 0xA5/255, blue: 0xF5/255, alpha: 1),
                      ending:   NSColor(red: 0x26/255, green: 0xA6/255, blue: 0x9A/255, alpha: 1))!
grad.draw(in: NSRect(x: 0, y: 0, width: S, height: S), angle: 45)

// 顶部柔光
let sheen = NSGradient(colors: [NSColor(white: 1, alpha: 0.22), NSColor(white: 1, alpha: 0)])!
sheen.draw(in: NSRect(x: 0, y: 0, width: S, height: S),
           relativeCenterPosition: NSPoint(x: 0, y: 0.5))

// 居中白色学士帽
if let base = NSImage(systemSymbolName: "graduationcap.fill", accessibilityDescription: nil) {
    let conf = NSImage.SymbolConfiguration(pointSize: 520, weight: .bold)
    if let sym = base.withSymbolConfiguration(conf) {
        // 把符号染成纯白：先画符号，再用 sourceAtop 覆白
        let tinted = NSImage(size: sym.size)
        tinted.lockFocus()
        sym.draw(at: .zero, from: .zero, operation: .sourceOver, fraction: 1)
        NSColor.white.set()
        NSRect(origin: .zero, size: sym.size).fill(using: .sourceAtop)
        tinted.unlockFocus()

        let w = sym.size.width, h = sym.size.height
        let scale = 560 / max(w, h)
        let dw = w * scale, dh = h * scale
        let dr = NSRect(x: (S - dw) / 2, y: (S - dh) / 2 + 24, width: dw, height: dh)
        tinted.draw(in: dr)
    }
}

canvas.unlockFocus()

guard let tiff = canvas.tiffRepresentation,
      let rep = NSBitmapImageRep(data: tiff),
      let png = rep.representation(using: .png, properties: [:]) else { fatalError("png") }
let out = "EngApex/Resources/Assets.xcassets/AppIcon.appiconset/AppIcon-1024.png"
try! png.write(to: URL(fileURLWithPath: out))
print("✅ wrote \(out)")
