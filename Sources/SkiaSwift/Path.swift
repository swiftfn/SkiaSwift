import CSkia

public class Path {
  var raw: OpaquePointer

  public init() {
    raw = sk_path_new()
  }

  deinit {
    sk_path_delete(raw)
  }

  @discardableResult
  public func moveTo(_ x: Float, _ y: Float) -> Path {
    sk_path_move_to(raw, x, y)
    return self
  }

  @discardableResult
  public func lineTo(_ x: Float, _ y: Float) -> Path {
    sk_path_line_to(raw, x, y)
    return self
  }

  @discardableResult
  public func quadTo(_ x0: Float, _ y0: Float, _ x1: Float, _ y1: Float) -> Path {
    sk_path_quad_to(raw, x0, y0, x1, y1)
    return self
  }

  @discardableResult
  public func conicTo(_ x0: Float, _ y0: Float, _ x1: Float, _ y1: Float, _ w: Float) -> Path {
    sk_path_conic_to(raw, x0, y0, x1, y1, w)
    return self
  }

  @discardableResult
  public func cubicTo(_ x0: Float, _ y0: Float, _ x1: Float, _ y1: Float, _ x2: Float, _ y2: Float) -> Path {
    sk_path_cubic_to(raw, x0, y0, x1, y1, x2, y2)
    return self
  }

  @discardableResult
  public func close() -> Path {
    sk_path_close(raw)
    return self
  }

  @discardableResult
  public func addRect(_ rect: Rect, _ direction: sk_path_direction_t) -> Path {
    var r = rect.toSk()
    sk_path_add_rect(raw, &r, direction)
    return self
  }

  @discardableResult
  public func addOval(_ rect: Rect, _ direction: sk_path_direction_t) -> Path {
    var r = rect.toSk()
    sk_path_add_oval(raw, &r, direction)
    return self
  }

  public var bounds: Rect {
    get {
      var rect = sk_rect_t()
      sk_path_get_bounds(raw, &rect)
      return Rect.fromSk(rect)
    }
  }
}
