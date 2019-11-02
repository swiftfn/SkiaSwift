import CSkia

public struct Point {
  let x: Float
  let y: Float

  func toSk() -> sk_point_t {
    var p = sk_point_t()
    p.x = x
    p.y = y
    return p
  }
}

public struct Size {
  var width: Float
  var height: Float
}

public struct SizeI {
  var width: Int32
  var height: Int32
}

extension sk_rect_t {
  func toSwift() -> Rect {
    return Rect(left, top, right, bottom)
  }
}

public struct Rect {
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

extension sk_irect_t {
  func toSwift() -> RectI {
    return RectI(left, top, right, bottom)
  }
}

public struct RectI {
  let left: Int32
  let top: Int32
  let right: Int32
  let bottom: Int32

  public init(_ left: Int32, _ top: Int32, _ right: Int32, _ bottom: Int32) {
    self.left = left
    self.top = top
    self.right = right
    self.bottom = bottom
  }

  func toSk() -> sk_irect_t {
    var r = sk_irect_t()
    r.left = left
    r.top = top
    r.right = right
    r.bottom = bottom
    return r
  }
}
