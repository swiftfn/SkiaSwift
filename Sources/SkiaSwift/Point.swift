import CSkia

public struct Point {
  let x: Float;
  let y: Float;

  func toSk() -> sk_point_t {
    var p = sk_point_t()
    p.x = x
    p.y = y
    return p
  }
}
