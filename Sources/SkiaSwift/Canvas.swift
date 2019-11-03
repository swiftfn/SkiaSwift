import CSkia

// Canvas has no deinit, thus it can be a struct, no need to be a class
public struct Canvas {
  let handle: OpaquePointer

  public func save() {
    sk_canvas_save(handle)
  }

  public func saveLayer(_ rect: Rect?, _ paint: Paint?) {
    if let r = rect {
      var cr = r.handle
      sk_canvas_save_layer(handle, &cr, paint?.handle)
    } else {
      sk_canvas_save_layer(handle, nil, paint?.handle)
    }
  }

  public func restore() {
    sk_canvas_restore(handle)
  }

  public func translate(_ dx: Float, _ dy: Float) {
    sk_canvas_translate(handle, dx, dy)
  }

  public func scale(_ sx: Float, _ sy: Float) {
    sk_canvas_scale(handle, sx, sy)
  }

  public func rotateDegrees(_ degrees: Float) {
    // https://bugs.chromium.org/p/skia/issues/detail?id=9584
    let radians = degrees * .pi / 180
    sk_canvas_rotate_radians(handle, radians)
  }

  public func rotateRadians(_ radians: Float) {
    sk_canvas_rotate_radians(handle, radians)
  }

  public func skew(_ sx: Float, _ sy: Float) {
    sk_canvas_skew(handle, sx, sy)
  }

  public func concat(_ matrix: Matrix) {
    sk_canvas_concat(handle, &matrix.handle)
  }

  public func drawPaint(_ paint: Paint) {
    sk_canvas_draw_paint(handle, paint.handle)
  }

  public func drawRect(_ rect: Rect, _ paint: Paint) {
    var r = rect.handle
    sk_canvas_draw_rect(handle, &r, paint.handle)
  }

  public func drawCircle(_ cx: Float, _ cy: Float, _ rad: Float, _ paint: Paint) {
    sk_canvas_draw_circle(handle, cx, cy, rad, paint.handle)
  }

  public func drawOval(_ rect: Rect, _ paint: Paint) {
    var r = rect.handle
    sk_canvas_draw_oval(handle, &r, paint.handle)
  }

  public func drawPath(_ path: Path, _ paint: Paint) {
    sk_canvas_draw_path(handle, path.handle, paint.handle)
  }

  public func drawImage(_ image: Image, _ x: Float, _ y: Float, _ paint: Paint) {
    sk_canvas_draw_image(handle, image.handle, x, y, paint.handle)
  }

  public func drawImageRect(_ image: Image, _ src: Rect, _ dst: Rect, _ paint: Paint) {
    var s = src.handle
    var d = dst.handle
    sk_canvas_draw_image_rect(handle, image.handle, &s, &d, paint.handle)
  }

  public func drawPicture(_ picture: Picture, _ matrix: Matrix, _ paint: Paint) {
    sk_canvas_draw_picture(handle, picture.handle, &matrix.handle, paint.handle)
  }
}
