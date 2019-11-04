import CSkia

infix operator +: AdditionPrecedence
infix operator -: AdditionPrecedence

public typealias Point = sk_point_t

public extension Point {
  static func normalize(_ point: Point) -> Point {
    let ls = point.x * point.x + point.y * point.y
    let invNorm = 1.0 / ls.squareRoot()
    return Point(point.x * invNorm, point.y * invNorm)
  }

  static func distance(_ point: Point, _ other: Point) -> Float {
    distanceSquared(point, other).squareRoot()
  }

  static func distanceSquared(_ point: Point, _ other: Point) -> Float {
    let dx = point.x - other.x
    let dy = point.y - other.y
    return dx * dx + dy * dy
  }

  static func reflect(_ point: Point, _ normal: Point) -> Point {
    let dot = point.x * point.x + point.y * point.y
    return Point(
      point.x - 2.0 * dot * normal.x,
      point.y - 2.0 * dot * normal.y
    )
  }

  static func +(_ pt: Point, _ sz: Point) -> Point {
    Point(pt.x + sz.x, pt.y + sz.y)
  }

  static func +(_ pt: Point, _ sz: PointI) -> Point {
    Point(pt.x + Float(sz.x), pt.y + Float(sz.y))
  }

  static func +(_ pt: Point, _ sz: Size) -> Point {
    Point(pt.x + sz.w, pt.y + sz.h)
  }

  static func +(_ pt: Point, _ sz: SizeI) -> Point {
    Point(pt.x + Float(sz.w), pt.y + Float(sz.h))
  }

  static func -(_ pt: Point, _ sz: Point) -> Point {
    Point(pt.x - sz.x, pt.y - sz.y)
  }

  static func -(_ pt: Point, _ sz: PointI) -> Point {
    Point(pt.x - Float(sz.x), pt.y - Float(sz.y))
  }

  static func -(_ pt: Point, _ sz: Size) -> Point {
    Point(pt.x - sz.w, pt.y - sz.w)
  }

  static func -(_ pt: Point, _ sz: SizeI) -> Point {
    Point(pt.x - Float(sz.w), pt.y - Float(sz.w))
  }

  init(_ x: Float, _ y: Float) {
    self.init()
    self.x = x
    self.y = y
  }

  var length: Float {
    lengthSquared.squareRoot()
  }

  var lengthSquared: Float {
    x * x + y * y
  }

  mutating func offset(_ p: Point) {
    x += p.x
    y += p.y
  }

  mutating func offset(_ dx: Float, _ dy: Float) {
    x += dx
    y += dy
  }
}

public typealias PointI = sk_ipoint_t

public extension PointI {
  static func normalize(_ point: PointI) -> PointI {
    let x = Float(point.x)
    let y = Float(point.y)
    let ls = x * x + y * y
    let invNorm = 1.0 / ls.squareRoot()
    return PointI(Int32(x * invNorm), Int32(y * invNorm))
  }

  static func distance(_ point: PointI, _ other: PointI) -> Float {
    Float(distanceSquared(point, other)).squareRoot()
  }

  static func distanceSquared(_ point: PointI, _ other: PointI) -> Int32 {
    let dx = point.x - other.x
    let dy = point.y - other.y
    return dx * dx + dy * dy
  }

  static func reflect(_ point: PointI, _ normal: PointI) -> PointI {
    let dot = point.x * point.x + point.y * point.y
    return PointI(
      point.x - 2 * dot * normal.x,
      point.y - 2 * dot * normal.y
    )
  }

  static func ceiling(_ value: Point) -> PointI {
    let x = value.x.rounded(.up)
    let y = value.y.rounded(.up)
    return PointI(Int32(x), Int32(y))
  }

  static func round(_ value: Point) -> PointI {
    let x = value.x.rounded()
    let y = value.y.rounded()
    return PointI(Int32(x), Int32(y))
  }

  static func truncate(_ value: Point) -> PointI {
    let x = value.x.rounded(.down)
    let y = value.y.rounded(.down)
    return PointI(Int32(x), Int32(y))
  }

  static func +(_ pt: PointI, _ sz: PointI) -> PointI {
    PointI(pt.x + sz.x, pt.y + sz.y)
  }

  static func +(_ pt: PointI, _ sz: SizeI) -> PointI {
    PointI(pt.x + sz.w, pt.y + sz.h)
  }

  static func -(_ pt: PointI, _ sz: PointI) -> PointI {
    PointI(pt.x - sz.x, pt.y - sz.y)
  }

  static func -(_ pt: PointI, _ sz: SizeI) -> PointI {
    PointI(pt.x - sz.w, pt.y - sz.h)
  }

  init(_ x: Int32, _ y: Int32) {
    self.init()
    self.x = x
    self.y = y
  }

  init(_ sz: SizeI) {
    self.init(sz.w, sz.h)
  }

  var length: Float {
    Float(lengthSquared).squareRoot()
  }

  var lengthSquared: Int32 {
    x * x + y * y
  }

  mutating func offset(_ p: PointI) {
    x += p.x
    y += p.y
  }

  mutating func offset(_ dx: Int32, _ dy: Int32) {
    x += x
    y += y
  }
}

public typealias Point3 = sk_point3_t

public extension Point3 {
  static func +(_ pt: Point3, _ sz: Point3) -> Point3 {
    Point3(pt.x + sz.x, pt.y + sz.y, pt.z + sz.z)
  }

  static func -(_ pt: Point3, _ sz: Point3) -> Point3 {
    Point3(pt.x - sz.x, pt.y - sz.y, pt.z - sz.z)
  }

  init(_ x: Float, _ y: Float, _ z: Float) {
    self.init()
    self.x = x
    self.y = y
    self.z = z
  }
}

public typealias Size = sk_size_t

public extension Size {
  static func +(_ sz1: Size, _ sz2: Size) -> Size {
    Size(sz1.w + sz2.w, sz1.h + sz2.h)
  }

  static func -(_ sz1: Size, _ sz2: Size) -> Size {
    Size(sz1.w - sz2.w, sz1.h - sz2.h)
  }

  init(_ w: Float, _ h: Float) {
    self.init()
    self.w = w
    self.h = h
  }

  init(_ point: Point) {
    self.init(point.x, point.y)
  }

  func toPoint() -> Point {
		Point(w, h)
  }

  func toSizeI() -> SizeI {
    SizeI(Int32(w), Int32(h))
  }
}

public typealias SizeI = sk_isize_t

public extension SizeI {
  static func +(_ sz1: SizeI, _ sz2: SizeI) -> SizeI {
    SizeI(sz1.w + sz2.w, sz1.h + sz2.h)
  }

  static func -(_ sz1: SizeI, _ sz2: SizeI) -> SizeI {
    SizeI(sz1.w - sz2.w, sz1.h - sz2.h)
  }

  init(_ w: Int32, _ h: Int32) {
    self.init()
    self.w = w
    self.h = h
  }

  init(_ point: PointI) {
    self.init(point.x, point.y)
  }

  func toPointI() -> PointI {
    PointI(w, h)
  }

  func toSize() -> Size {
    Size(Float(w), Float(h))
  }
}

public typealias Rect = sk_rect_t

public extension Rect {
  static func create(location: Point, size: Size) -> Rect {
    create(x: location.x, y: location.y, width: size.w, height: size.h)
  }

  static func create(size: Size) -> Rect {
    create(location: Point(0, 0), size: size)
  }

  static func create(width: Float, height: Float) -> Rect {
    Rect(0, 0, width, height)
  }

  static func create(x: Float, y: Float, width: Float, height: Float) -> Rect {
    Rect(x, y, x + width, y + height)
  }

  static func inflate(_ rect: Rect, _ x: Float, _ y: Float) -> Rect {
    var r = Rect(rect.left, rect.top, rect.right, rect.bottom)
    r.inflate(x, y)
    return r
  }

  static func intersect(_ a: Rect, _ b: Rect) -> Rect {
    if (!a.intersectsWithInclusive(b)) {
      return Rect(0, 0, 0, 0)
    }

    return Rect(
      max(a.left, b.left),
      max(a.top, b.top),
      min(a.right, b.right),
      min(a.bottom, b.bottom)
    )
  }

  static func union(_ a: Rect, _ b: Rect) -> Rect {
		Rect(
      min(a.left, b.left),
      min(a.top, b.top),
      max(a.right, b.right),
      max(a.bottom, b.bottom)
    )
  }

  init(_ left: Float, _ top: Float, _ right: Float, _ bottom: Float) {
    self.init()
    self.left = left
    self.top = top
    self.right = right
    self.bottom = bottom
  }

  var empty: Bool {
    Utils.nearlyEqual(left, 0) &&
    Utils.nearlyEqual(top, 0) &&
    Utils.nearlyEqual(right, 0) &&
    Utils.nearlyEqual(bottom, 0)
  }

  var width: Float {
    right - left
  }

  var height: Float {
    bottom - top
  }

  var midX: Float {
    left + width / 2
  }

  var midY: Float {
    top + height / 2
  }

  var size: Size {
    get {
      Size(width, height)
    }
    set {
      right = left + newValue.w
      bottom = top + newValue.h
    }
  }

  var location: Point {
    get {
      Point(left, top)
    }
    set {
      self.left = newValue.x
      self.top = newValue.y
    }
  }

  var standardized: Rect {
    get {
      if (left > right) {
        if (top > bottom) {
          return Rect(right, bottom, left, top)
        } else {
          return Rect(right, top, left, bottom)
        }
      } else {
        if (top > bottom) {
          return Rect(left, bottom, right, top)
        } else {
          return Rect(left, top, right, bottom)
        }
      }
    }
  }

  func aspectFit(_ size: Size) -> Rect {
    aspectResize(size, true)
  }

  func aspectFill(_ size: Size) -> Rect {
    aspectResize(size, false)
  }

  mutating func inflate(_ size: Size) {
    inflate(size.w, size.h)
  }

  mutating func inflate(_ x: Float, _ y: Float) {
    left -= x
    top -= y
    right += x
    bottom += y
  }

  mutating func intersect(rect: Rect) {
	  self = Rect.intersect(self, rect)
  }

  func intersectsWith(_ rect: Rect) -> Bool {
    (left < rect.right) && (right > rect.left) && (top < rect.bottom) && (bottom > rect.top)
  }

  func intersectsWithInclusive(_ rect: Rect) -> Bool {
    (left <= rect.right) && (right >= rect.left) && (top <= rect.bottom) && (bottom >= rect.top)
  }

  mutating func union(rect: Rect) {
    self = Rect.union(self, rect)
  }

  func contains(_ x: Float, _ y: Float) -> Bool {
    (x >= left) && (x < right) && (y >= top) && (y < bottom)
  }

  func contains(_ pt: Point) -> Bool {
    contains(pt.x, pt.y)
  }

  func contains(_ rect: Rect) -> Bool {
    (left <= rect.left) && (right >= rect.right) &&
    (top <= rect.top) && (bottom >= rect.bottom)
  }

  mutating func offset(_ x: Float, _ y: Float) {
    left += x
    top += y
    right += x
    bottom += y
  }

  mutating func offset(_ pos: Point) {
    offset(pos.x, pos.y)
  }

  private func aspectResize(_ size: Size, _ fit: Bool) -> Rect {
    if size.w == 0 || size.h == 0 || width == 0 || height == 0 {
      return Rect.create(x: midX, y: midY, width: 0, height: 0)
    }

    var aspectWidth = size.w
    var aspectHeight = size.h
    let imgAspect = aspectWidth / aspectHeight
    let fullRectAspect = width / height

    let compare = fit ? (fullRectAspect > imgAspect) : (fullRectAspect < imgAspect)
    if (compare) {
      aspectHeight = height
      aspectWidth = aspectHeight * imgAspect
    } else {
      aspectWidth = width
      aspectHeight = aspectWidth / imgAspect
    }
    let aspectLeft = midX - (aspectWidth / 2)
    let aspectTop = midY - (aspectHeight / 2)

    return Rect.create(x: aspectLeft, y: aspectTop, width: aspectWidth, height: aspectHeight)
  }
}

public typealias RectI = sk_irect_t

public extension RectI {
  static func create(size: SizeI) -> RectI {
    create(x: 0, y: 0, width: size.w, height: size.h)
  }

  static func create(location: PointI, size: SizeI) -> RectI {
    create(x: location.x, y: location.y, width: size.w, height: size.h)
  }

  static func create(width: Int32, height: Int32) -> RectI {
    RectI(0, 0, width, height)
  }

  static func create(x: Int32, y: Int32, width: Int32, height: Int32) -> RectI {
    RectI(x, y, x + width, y + height)
  }

  static func ceiling(_ value: Rect) -> RectI {
    ceiling(value, outwards: false)
  }

  static func ceiling(_ value: Rect, outwards: Bool) -> RectI {
    let x = Int32(outwards && value.width > 0 ? value.left.rounded(.down) : value.left.rounded(.up))
    let y = Int32(outwards && value.height > 0 ? value.top.rounded(.down) : value.top.rounded(.up))
    let r = Int32(outwards && value.width < 0 ? value.right.rounded(.down) : value.right.rounded(.up))
    let b = Int32(outwards && value.height < 0 ? value.bottom.rounded(.down) : value.bottom.rounded(.up))
    return RectI(x, y, r, b)
  }

  static func round(value: Rect) -> RectI {
    let x = Int32(value.left.rounded())
    let y = Int32(value.top.rounded())
    let r = Int32(value.right.rounded())
    let b = Int32(value.bottom.rounded())
    return RectI(x, y, r, b)
  }

  static func floor(value: Rect) -> RectI {
    floor(value: value, inwards: false)
  }

  static func floor(value: Rect, inwards: Bool) -> RectI {
    let x = Int32(inwards && value.width > 0 ? value.left.rounded(.up) : value.left.rounded(.down))
    let y = Int32(inwards && value.height > 0 ? value.top.rounded(.up) : value.top.rounded(.down))
    let r = Int32(inwards && value.width < 0 ? value.right.rounded(.up) : value.right.rounded(.down))
    let b = Int32(inwards && value.height < 0 ? value.bottom.rounded(.up) : value.bottom.rounded(.down))
    return RectI(x, y, r, b)
  }

  static func inflate(_ rect: RectI, _ x: Int32, _ y: Int32) -> RectI {
    var r = RectI(rect.left, rect.top, rect.right, rect.bottom)
    r.inflate(x, y)
    return r
  }

  static func intersect(_ a: RectI, _ b: RectI) -> RectI {
    if !a.intersectsWithInclusive(b) {
      return RectI(0, 0, 0, 0)
    }

    return RectI(
      max(a.left, b.left),
      max(a.top, b.top),
      min(a.right, b.right),
      min(a.bottom, b.bottom)
    )
  }

  static func truncate(_ value: Rect) -> RectI {
    let x = Int32(value.left)
    let y = Int32(value.top)
    let r = Int32(value.right)
    let b = Int32(value.bottom)
    return RectI (x, y, r, b)
  }

  static func union(_ a: RectI, _ b: RectI) -> RectI {
    return RectI(
      min(a.left, b.left),
      min(a.top, b.top),
      max(a.right, b.right),
      max(a.bottom, b.bottom)
    )
  }

  init(_ left: Int32, _ top: Int32, _ right: Int32, _ bottom: Int32) {
    self.init()
    self.left = left
    self.top = top
    self.right = right
    self.bottom = bottom
  }

  var empty: Bool {
    left == 0 &&
    top == 0 &&
    right == 0 &&
    bottom == 0
  }

  var width: Int32 {
    right - left
  }

  var height: Int32 {
    bottom - top
  }

  var midX: Int32 {
    left + width / 2
  }

  var midY: Int32 {
    top + height / 2
  }

  var size: SizeI {
    get {
      SizeI(width, height)
    }
    set {
      right = left + newValue.w
      bottom = top + newValue.h
    }
  }

  var location: PointI {
    get {
      PointI(left, top)
    }
    set {
      self.left = newValue.x
      self.top = newValue.y
    }
  }

  var standardized: RectI {
    get {
      if (left > right) {
        if (top > bottom) {
          return RectI(right, bottom, left, top)
        } else {
          return RectI(right, top, left, bottom)
        }
      } else {
        if (top > bottom) {
          return RectI(left, bottom, right, top)
        } else {
          return RectI(left, top, right, bottom)
        }
      }
    }
  }

  func aspectFit(_ size: SizeI) -> RectI {
  	RectI.truncate(toRect().aspectFit(size.toSize()))
  }

  func aspectFill(_ size: SizeI) -> RectI {
    RectI.truncate(toRect().aspectFill(size.toSize()))
  }

  mutating func inflate(_ size: SizeI) {
    inflate(size.w, size.h)
  }

  mutating func inflate(_ width: Int32, _ height: Int32) {
    left -= width
    top -= height
    right += width
    bottom += height
  }

  mutating func intersect(_ rect: RectI) {
    self = RectI.intersect(self, rect)
  }

  func intersectsWith(_ rect: RectI) -> Bool {
    (left < rect.right) && (right > rect.left) && (top < rect.bottom) && (bottom > rect.top)
  }

  func intersectsWithInclusive(_ rect: RectI) -> Bool {
    (left <= rect.right) && (right >= rect.left) && (top <= rect.bottom) && (bottom >= rect.top)
  }

  mutating func union(_ rect: RectI) {
    self = RectI.union(self, rect)
  }

  func contains(_ x: Int32, _ y: Int32) -> Bool {
    (x >= left) && (x < right) && (y >= top) && (y < bottom)
  }

  func contains(_ pt: PointI) -> Bool {
    contains(pt.x, pt.y)
  }

  func contains(_ rect: RectI) -> Bool {
    (left <= rect.left) && (right >= rect.right) &&
    (top <= rect.top) && (bottom >= rect.bottom)
  }

  mutating func offset(_ x: Int32, _ y: Int32) {
    left += x
    top += y
    right += x
    bottom += y
  }

  mutating func offset(_ pos: PointI) {
    offset(pos.x, pos.y)
  }

  func toRect() -> Rect {
    Rect(Float(left), Float(top), Float(right), Float(bottom))
  }
}
