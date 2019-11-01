import CSkia

public struct Rect {
  static func fromSk(_ rect: sk_rect_t) -> Rect {
    return Rect(rect.left, rect.top, rect.right, rect.bottom)
  }

  let left: Float;
  let top: Float;
  let right: Float;
  let bottom: Float;

  public init(_ left: Float, _ top: Float, _ right: Float, _ bottom: Float) {
    self.left = left
    self.top = top
    self.right = right
    self.bottom = bottom
  }

  func toSk() -> sk_rect_t {
    var r = sk_rect_t()
    r.left = left
    r.top = top
    r.right = right
    r.bottom = bottom
    return r
  }
}

public struct IRect {
  static func fromSk(_ rect: sk_irect_t) -> IRect {
    return IRect(left: rect.left, top: rect.top, right: rect.right, bottom: rect.bottom)
  }

  let left: Int32;
  let top: Int32;
  let right: Int32;
  let bottom: Int32;

  func toSk() -> sk_irect_t {
    var r = sk_irect_t()
    r.left = left
    r.top = top
    r.right = right
    r.bottom = bottom
    return r
  }
}
