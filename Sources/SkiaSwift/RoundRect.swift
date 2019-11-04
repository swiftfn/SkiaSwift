import CSkia

public class RoundRect {
  var handle: OpaquePointer

  public init() {
    handle = sk_rrect_new()
    setEmpty()
  }

  public init(rect: Rect) {
    handle = sk_rrect_new()
    setRect(rect)
  }

  public init(rect: Rect, xRadius: Float, yRadius: Float) {
    handle = sk_rrect_new()
		setRect(rect, xRadius: xRadius, yRadius: yRadius)
  }

  public init(rrect: RoundRect) {
    handle = sk_rrect_new_copy(rrect.handle)
  }

  deinit {
    sk_rrect_delete(handle)
  }

  public var rect: Rect {
    var rect = Rect()
    sk_rrect_get_rect(handle, &rect)
    return rect
  }

  public var radii: (Point, Point, Point, Point) {
    (
      getRadii(.upperLeft),
      getRadii(.upperRight),
      getRadii(.lowerRight),
      getRadii(.lowerLeft)
    )
  }

  public var type: RoundRectType {
    RoundRectType.fromC(sk_rrect_get_type(handle))
  }

  public var width: Float {
    sk_rrect_get_width(handle)
  }

  public var height: Float {
    sk_rrect_get_height(handle)
  }

  public var valid: Bool {
    sk_rrect_is_valid(handle)
  }

  public var allCornersCircular: Bool {
    let ul = getRadii(.upperLeft)
    let ur = getRadii(.upperRight)
    let lr = getRadii(.lowerRight)
    let ll = getRadii(.lowerLeft)

    return
      Utils.nearlyEqual(ul.x, ul.y) &&
      Utils.nearlyEqual(ur.x, ur.y) &&
      Utils.nearlyEqual(lr.x, lr.y) &&
      Utils.nearlyEqual(ll.x, ll.y)
  }

  public func setEmpty() {
    sk_rrect_set_empty(handle)
  }

  public func setRect(_ rect: Rect) {
    var r = rect
    sk_rrect_set_rect(handle, &r)
  }

  public func setRect(_ rect: Rect, xRadius: Float, yRadius: Float) {
    var r = rect
    sk_rrect_set_rect_xy(handle, &r, xRadius, yRadius)
  }

  public func setOval(_ rect: Rect) {
    var r = rect
    sk_rrect_set_oval(handle, &r)
  }

  public func setNinePatch(_ rect: Rect, leftRadius: Float, topRadius: Float, rightRadius: Float, bottomRadius: Float) {
    var r = rect
    sk_rrect_set_nine_patch(handle, &r, leftRadius, topRadius, rightRadius, bottomRadius)
  }

  public func setRectRadii(_ rect: Rect, radiis: (Point, Point, Point, Point)) {
    var r = rect
    let rs = [radiis.0, radiis.1, radiis.2, radiis.3]
    sk_rrect_set_rect_radii(handle, &r, rs)
  }

  public func contains(_ rect: Rect) -> Bool {
    var r = rect
    return sk_rrect_contains(handle, &r)
  }

  public func getRadii(_ corner: RoundRectCorner) -> Point {
    var radii = Point()
    sk_rrect_get_radii(handle, corner.toC(), &radii)
    return radii
  }

  public func deflate(_ size: Size) {
    deflate(size.w, size.h)
  }

  public func deflate(_ dx: Float, _ dy: Float) {
    sk_rrect_inset(handle, dx, dy)
  }

  public func inflate(_ size: Size) {
    inflate(size.w, size.h)
  }

  public func inflate(_ dx: Float, _ dy: Float) {
    sk_rrect_outset(handle, dx, dy)
  }

  public func offset(_ pos: Point) {
    offset(pos.x, pos.y)
  }

  public func offset(_ dx: Float, _ dy: Float) {
    sk_rrect_offset(handle, dx, dy)
  }

  public func transform(_ matrix: Matrix) -> RoundRect? {
    var r: RoundRect? = RoundRect()
    var m = matrix
    if sk_rrect_transform(handle, &m, r!.handle) {
      return r
    }
    r = nil
    return nil
  }
}
