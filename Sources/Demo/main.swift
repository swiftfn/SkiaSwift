// https://github.com/google/skia/tree/master/experimental/c-api-example
// https://github.com/elegantchaos/CSkia

import SkiaSwift
import Foundation

func makeSurface(_ w: Int32, _ h: Int32) -> Surface {
    let info = ImageInfo(w, h, .rgba8888, .premul)
    return Surface.raster(info)
}

func emitPng(_ path: String, _ surface: Surface) {
    let image = surface.snapshot
    let encoded = image.encode()
    let bytes = encoded.data
    let size = encoded.size
    let data = Data(bytes: bytes, count: size)
    try? data.write(to: URL(fileURLWithPath: path))
}

func draw(_ canvas: Canvas) {
    let fill = Paint()
    fill.color = Color(r: 0, g: 0, b: 0xFF)
    canvas.drawPaint(fill)

    fill.color = Color(r: 0, g: 0xFF, b: 0xFF)
    let rect = Rect(100.0, 100.0, 540.0, 380.0)
    canvas.drawRect(rect, fill)

    let stroke = Paint()
    stroke.color = Color(r: 0xFF, g: 0, b: 0)
    stroke.antialias = true
    stroke.strokeWidth = 5.0

    let path = Path()
    path
        .moveTo(50.0, 50.0)
        .lineTo(590.0, 50.0)
        .cubicTo(-490.0, 50.0, 1130.0, 430.0, 50.0, 430.0)
        .lineTo(590.0, 430.0)
    canvas.drawPath(path, stroke)

    fill.color = Color(r: 0, g: 0xFF, b: 0, a: 0x80)
    let rect2 = Rect(120.0, 120.0, 520.0, 360.0)
    canvas.drawOval(rect2, fill)
}

let surface = makeSurface(640, 480)
let canvas = surface.canvas
draw(canvas)

let fileName = "skia-swift-example.png"
emitPng(fileName, surface)
print("Created \(fileName)")
