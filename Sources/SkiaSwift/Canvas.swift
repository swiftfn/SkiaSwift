import CSkia

// Canvas has no deinit, thus it can be a struct, no need to be a class
public struct Canvas {
  let raw: OpaquePointer

  public func save() {
    sk_canvas_save(raw)
  }

  public func saveLayer(_ rect: Rect?, _ paint: Paint?) {
    if let r = rect {
      var cr = r.toSk()
      sk_canvas_save_layer(raw, &cr, paint?.raw)
    } else {
      sk_canvas_save_layer(raw, nil, paint?.raw)
    }
  }

  public func restore() {
    sk_canvas_restore(raw)
  }

  public func translate(_ dx: Float, _ dy: Float) {
    sk_canvas_translate(raw, dx, dy)
  }

  public func scale(_ sx: Float, _ sy: Float) {
    sk_canvas_scale(raw, sx, sy)
  }

  public func rotateDegrees(_ degrees: Float) {
    // https://bugs.chromium.org/p/skia/issues/detail?id=9584
    let radians = degrees * .pi / 180
    sk_canvas_rotate_radians(raw, radians)
  }

  public func rotateRadians(_ radians: Float) {
    sk_canvas_rotate_radians(raw, radians)
  }

  public func skew(_ sx: Float, _ sy: Float) {
    sk_canvas_skew(raw, sx, sy)
  }

  public func concat(_ matrix: Matrix) {
    sk_canvas_concat(raw, &matrix.raw)
  }

  public func drawPaint(_ paint: Paint) {
    sk_canvas_draw_paint(raw, paint.raw)
  }

  public func drawRect(_ rect: Rect, _ paint: Paint) {
    var r = rect.toSk()
    sk_canvas_draw_rect(raw, &r, paint.raw)
  }

  public func drawCircle(_ cx: Float, _ cy: Float, _ rad: Float, _ paint: Paint) {
    sk_canvas_draw_circle(raw, cx, cy, rad, paint.raw)
  }

  public func drawOval(_ rect: Rect, _ paint: Paint) {
    var r = rect.toSk()
    sk_canvas_draw_oval(raw, &r, paint.raw)
  }

  public func drawPath(_ path: Path, _ paint: Paint) {
    sk_canvas_draw_path(raw, path.raw, paint.raw)
  }

  public func drawImage(_ image: Image, _ x: Float, _ y: Float, _ paint: Paint) {
    sk_canvas_draw_image(raw, image.raw, x, y, paint.raw)
  }

  public func drawImageRect(_ image: Image, _ src: Rect, _ dst: Rect, _ paint: Paint) {
    var s = src.toSk()
    var d = dst.toSk()
    sk_canvas_draw_image_rect(raw, image.raw, &s, &d, paint.raw)
  }

  public func drawPicture(_ picture: Picture, _ matrix: Matrix, _ paint: Paint) {
    sk_canvas_draw_picture(raw, picture.raw, &matrix.raw, paint.raw)
  }
}
