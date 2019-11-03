import CSkia

public class Path {
  var handle: OpaquePointer

  public init() {
    handle = sk_path_new()
  }

  deinit {
    sk_path_delete(handle)
  }

  @discardableResult
  public func moveTo(_ x: Float, _ y: Float) -> Path {
    sk_path_move_to(handle, x, y)
    return self
  }

  @discardableResult
  public func lineTo(_ x: Float, _ y: Float) -> Path {
    sk_path_line_to(handle, x, y)
    return self
  }

  @discardableResult
  public func quadTo(_ x0: Float, _ y0: Float, _ x1: Float, _ y1: Float) -> Path {
    sk_path_quad_to(handle, x0, y0, x1, y1)
    return self
  }

  @discardableResult
  public func conicTo(_ x0: Float, _ y0: Float, _ x1: Float, _ y1: Float, _ w: Float) -> Path {
    sk_path_conic_to(handle, x0, y0, x1, y1, w)
    return self
  }

  @discardableResult
  public func cubicTo(_ x0: Float, _ y0: Float, _ x1: Float, _ y1: Float, _ x2: Float, _ y2: Float) -> Path {
    sk_path_cubic_to(handle, x0, y0, x1, y1, x2, y2)
    return self
  }

  @discardableResult
  public func close() -> Path {
    sk_path_close(handle)
    return self
  }

  @discardableResult
  public func addRect(_ rect: Rect, _ direction: sk_path_direction_t) -> Path {
    var r = rect
    sk_path_add_rect(handle, &r, direction)
    return self
  }

  @discardableResult
  public func addOval(_ rect: Rect, _ direction: sk_path_direction_t) -> Path {
    var r = rect
    sk_path_add_oval(handle, &r, direction)
    return self
  }

  public var bounds: Rect {
    get {
      var rect = Rect()
      sk_path_get_bounds(handle, &rect)
      return rect
    }
  }
}
