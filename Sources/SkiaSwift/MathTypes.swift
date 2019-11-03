import CSkia

infix operator +: AdditionPrecedence
infix operator -: AdditionPrecedence

public typealias Point = sk_point_t

extension Point {
  public static func normalize(_ point: Point) -> Point {
    let ls = point.x * point.x + point.y * point.y
    let invNorm = 1.0 / ls.squareRoot()
    return Point(point.x * invNorm, point.y * invNorm)
  }

  public static func distance(_ point: Point, _ other: Point) -> Float {
    return distanceSquared(point, other).squareRoot()
  }

  public static func distanceSquared(_ point: Point, _ other: Point) -> Float {
    let dx = point.x - other.x
    let dy = point.y - other.y
    return dx * dx + dy * dy
  }

  public static func reflect(_ point: Point, _ normal: Point) -> Point {
    let dot = point.x * point.x + point.y * point.y
    return Point(
      point.x - 2.0 * dot * normal.x,
      point.y - 2.0 * dot * normal.y
    )
  }

  public static func +(_ pt: Point, _ sz: Point) -> Point {
    return Point(pt.x + sz.x, pt.y + sz.y)
  }

  public static func +(_ pt: Point, _ sz: PointI) -> Point {
    return Point(pt.x + Float(sz.x), pt.y + Float(sz.y))
  }

  public static func +(_ pt: Point, _ sz: Size) -> Point {
    return Point(pt.x + sz.w, pt.y + sz.h)
  }

  public static func +(_ pt: Point, _ sz: SizeI) -> Point {
    return Point(pt.x + Float(sz.w), pt.y + Float(sz.h))
  }

  public static func -(_ pt: Point, _ sz: Point) -> Point {
    return Point(pt.x - sz.x, pt.y - sz.y)
  }

  public static func -(_ pt: Point, _ sz: PointI) -> Point {
    return Point(pt.x - Float(sz.x), pt.y - Float(sz.y))
  }

  public static func -(_ pt: Point, _ sz: Size) -> Point {
    return Point(pt.x - sz.w, pt.y - sz.w)
  }

  public static func -(_ pt: Point, _ sz: SizeI) -> Point {
    return Point(pt.x - Float(sz.w), pt.y - Float(sz.w))
  }

  init(_ x: Float, _ y: Float) {
    self.init()
    self.x = x
    self.y = y
  }

  var length: Float {
    get {
      return lengthSquared.squareRoot()
    }
  }

  var lengthSquared: Float {
    get {
      return x * x + y * y
    }
  }

  public mutating func offset(_ p: Point) {
    x += p.x
    y += p.y
  }

  public mutating func offset(_ dx: Float, _ dy: Float) {
    x += dx
    y += dy
  }
}

public typealias PointI = sk_ipoint_t

extension PointI {
  public static func normalize(_ point: PointI) -> PointI {
    let x = Float(point.x)
    let y = Float(point.y)
    let ls = x * x + y * y
    let invNorm = 1.0 / ls.squareRoot()
    return PointI(Int32(x * invNorm), Int32(y * invNorm))
  }

  public static func distance(_ point: PointI, _ other: PointI) -> Float {
    return Float(distanceSquared(point, other)).squareRoot()
  }

  public static func distanceSquared(_ point: PointI, _ other: PointI) -> Int32 {
    let dx = point.x - other.x
    let dy = point.y - other.y
    return dx * dx + dy * dy
  }

  public static func reflect(_ point: PointI, _ normal: PointI) -> PointI {
    let dot = point.x * point.x + point.y * point.y
    return PointI(
      point.x - 2 * dot * normal.x,
      point.y - 2 * dot * normal.y
    )
  }

  public static func ceiling(_ value: Point) -> PointI {
    let x = value.x.rounded(.up)
    let y = value.y.rounded(.up)
    return PointI(Int32(x), Int32(y))
  }

  public static func round(_ value: Point) -> PointI {
    let x = value.x.rounded()
    let y = value.y.rounded()
    return PointI(Int32(x), Int32(y))
  }

  public static func truncate(_ value: Point) -> PointI {
    let x = value.x.rounded(.down)
    let y = value.y.rounded(.down)
    return PointI(Int32(x), Int32(y))
  }

  public static func +(_ pt: PointI, _ sz: PointI) -> PointI {
    return PointI(pt.x + sz.x, pt.y + sz.y)
  }

  public static func +(_ pt: PointI, _ sz: SizeI) -> PointI {
    return PointI(pt.x + sz.w, pt.y + sz.h)
  }

  public static func -(_ pt: PointI, _ sz: PointI) -> PointI {
    return PointI(pt.x - sz.x, pt.y - sz.y)
  }

  public static func -(_ pt: PointI, _ sz: SizeI) -> PointI {
    return PointI(pt.x - sz.w, pt.y - sz.h)
  }

  init(_ x: Int32, _ y: Int32) {
    self.init()
    self.x = x
    self.y = y
  }

  init(_ sz: SizeI) {
    self.init(sz.w, sz.h)
  }

  public var length: Float {
    get {
      return Float(lengthSquared).squareRoot()
    }
  }

  public var lengthSquared: Int32 {
    get {
      return x * x + y * y
    }
  }

  public mutating func offset(_ p: PointI) {
    x += p.x
    y += p.y
  }

  public mutating func offset(_ dx: Int32, _ dy: Int32) {
    x += x
    y += y
  }
}

public typealias Point3 = sk_point3_t

extension Point3 {
  public static func +(_ pt: Point3, _ sz: Point3) -> Point3 {
    return Point3(pt.x + sz.x, pt.y + sz.y, pt.z + sz.z)
  }

  public static func -(_ pt: Point3, _ sz: Point3) -> Point3 {
    return Point3(pt.x - sz.x, pt.y - sz.y, pt.z - sz.z)
  }

  init(_ x: Float, _ y: Float, _ z: Float) {
    self.init()
    self.x = x
    self.y = y
    self.z = z
  }
}

public typealias Size = sk_size_t

extension Size {
  public static func +(_ sz1: Size, _ sz2: Size) -> Size {
    return Size(sz1.w + sz2.w, sz1.h + sz2.h)
  }

  public static func -(_ sz1: Size, _ sz2: Size) -> Size {
    return Size(sz1.w - sz2.w, sz1.h - sz2.h)
  }

  public init(_ w: Float, _ h: Float) {
    self.init()
    self.w = w
    self.h = h
  }

  public init(_ point: Point) {
    self.init(point.x, point.y)
  }

  public func toPoint() -> Point {
		return Point(w, h)
  }

  public func toSizeI() -> SizeI {
    return SizeI(Int32(w), Int32(h))
  }
}

public typealias SizeI = sk_isize_t

extension SizeI {
  public static func +(_ sz1: SizeI, _ sz2: SizeI) -> SizeI {
    return SizeI(sz1.w + sz2.w, sz1.h + sz2.h)
  }

  public static func -(_ sz1: SizeI, _ sz2: SizeI) -> SizeI {
    return SizeI(sz1.w - sz2.w, sz1.h - sz2.h)
  }

  public init(_ w: Int32, _ h: Int32) {
    self.init()
    self.w = w
    self.h = h
  }

  public init(_ point: PointI) {
    self.init(point.x, point.y)
  }

  public func toPointI() -> PointI {
    return PointI(w, h)
  }

  func toSize() -> Size {
    return Size(Float(w), Float(h))
  }
}

public typealias Rect = sk_rect_t

extension Rect {
  public static func create(location: Point, size: Size) -> Rect {
    return create(x: location.x, y: location.y, width: size.w, height: size.h)
  }

  public static func create(size: Size) -> Rect {
    return create(location: Point(0, 0), size: size)
  }

  public static func create(width: Float, height: Float) -> Rect {
    return Rect(0, 0, width, height)
  }

  public static func create(x: Float, y: Float, width: Float, height: Float) -> Rect {
    return Rect(x, y, x + width, y + height)
  }

  public static func inflate(_ rect: Rect, _ x: Float, _ y: Float) -> Rect {
    var r = Rect(rect.left, rect.top, rect.right, rect.bottom)
    r.inflate(x, y)
    return r
  }

  public static func intersect(_ a: Rect, _ b: Rect) -> Rect {
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

  public static func union(_ a: Rect, _ b: Rect) -> Rect {
		return Rect(
      min(a.left, b.left),
      min(a.top, b.top),
      max(a.right, b.right),
      max(a.bottom, b.bottom)
    )
  }

  public init(_ left: Float, _ top: Float, _ right: Float, _ bottom: Float) {
    self.init()
    self.left = left
    self.top = top
    self.right = right
    self.bottom = bottom
  }

  public var width: Float {
    get {
      return right - left
    }
  }

  public var height: Float {
    get {
      return bottom - top
    }
  }

  public var midX: Float {
    get {
      return left + width / 2
    }
  }

  public var midY: Float {
    get {
      return top + height / 2
    }
  }

  public var size: Size {
    get {
      return Size(width, height)
    }
    set(value) {
      right = left + value.w
      bottom = top + value.h
    }
  }

  public var location: Point {
    get {
      return Point(left, top)
    }
    set(value) {
      self.left = value.x
      self.top = value.y
    }
  }

  public var standardized: Rect {
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

  public func aspectFit(_ size: Size) -> Rect {
    return aspectResize(size, true)
  }

  public func aspectFill(_ size: Size) -> Rect {
    return aspectResize(size, false)
  }

  public mutating func inflate(_ size: Size) {
    inflate(size.w, size.h)
  }

  public mutating func inflate(_ x: Float, _ y: Float) {
    left -= x
    top -= y
    right += x
    bottom += y
  }

  public mutating func intersect(rect: Rect) {
	  self = Rect.intersect(self, rect)
  }

  public func intersectsWith(_ rect: Rect) -> Bool {
    return (left < rect.right) && (right > rect.left) && (top < rect.bottom) && (bottom > rect.top)
  }

  public func intersectsWithInclusive(_ rect: Rect) -> Bool {
    return (left <= rect.right) && (right >= rect.left) && (top <= rect.bottom) && (bottom >= rect.top)
  }

  public mutating func union(rect: Rect) {
    self = Rect.union(self, rect)
  }

  public func contains(_ x: Float, _ y: Float) -> Bool {
    return (x >= left) && (x < right) && (y >= top) && (y < bottom)
  }

  public func contains(_ pt: Point) -> Bool {
    return contains(pt.x, pt.y)
  }

  public func contains(_ rect: Rect) -> Bool {
    return (left <= rect.left) && (right >= rect.right) &&
      (top <= rect.top) && (bottom >= rect.bottom)
  }

  public mutating func offset(_ x: Float, _ y: Float) {
    left += x
    top += y
    right += x
    bottom += y
  }

  public mutating func offset(_ pos: Point) {
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

extension RectI {
  public static func create(size: SizeI) -> RectI {
    return create(x: 0, y: 0, width: size.w, height: size.h)
  }

  public static func create(location: PointI, size: SizeI) -> RectI {
    return create(x: location.x, y: location.y, width: size.w, height: size.h)
  }

  public static func create(width: Int32, height: Int32) -> RectI {
    return RectI(0, 0, width, height)
  }

  public static func create(x: Int32, y: Int32, width: Int32, height: Int32) -> RectI {
    return RectI(x, y, x + width, y + height)
  }

  public static func ceiling(value: Rect) -> RectI {
    return ceiling(value: value, outwards: false)
  }

  public static func ceiling(value: Rect, outwards: Bool) -> RectI {
    let x = Int32(outwards && value.width > 0 ? value.left.rounded(.down) : value.left.rounded(.up))
    let y = Int32(outwards && value.height > 0 ? value.top.rounded(.down) : value.top.rounded(.up))
    let r = Int32(outwards && value.width < 0 ? value.right.rounded(.down) : value.right.rounded(.up))
    let b = Int32(outwards && value.height < 0 ? value.bottom.rounded(.down) : value.bottom.rounded(.up))
    return RectI(x, y, r, b)
  }

  public static func round(value: Rect) -> RectI {
    let x = Int32(value.left.rounded())
    let y = Int32(value.top.rounded())
    let r = Int32(value.right.rounded())
    let b = Int32(value.bottom.rounded())
    return RectI(x, y, r, b)
  }

  public static func floor(value: Rect) -> RectI {
    return floor(value: value, inwards: false)
  }

  public static func floor(value: Rect, inwards: Bool) -> RectI {
    let x = Int32(inwards && value.width > 0 ? value.left.rounded(.up) : value.left.rounded(.down))
    let y = Int32(inwards && value.height > 0 ? value.top.rounded(.up) : value.top.rounded(.down))
    let r = Int32(inwards && value.width < 0 ? value.right.rounded(.up) : value.right.rounded(.down))
    let b = Int32(inwards && value.height < 0 ? value.bottom.rounded(.up) : value.bottom.rounded(.down))
    return RectI(x, y, r, b)
  }

  public static func inflate(_ rect: RectI, _ x: Int32, _ y: Int32) -> RectI {
    var r = RectI(rect.left, rect.top, rect.right, rect.bottom)
    r.inflate(x, y)
    return r
  }

  public static func intersect(_ a: RectI, _ b: RectI) -> RectI {
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

  public static func truncate(_ value: Rect) -> RectI {
    let x = Int32(value.left)
    let y = Int32(value.top)
    let r = Int32(value.right)
    let b = Int32(value.bottom)
    return RectI (x, y, r, b)
  }

  public static func union(_ a: RectI, _ b: RectI) -> RectI {
    return RectI(
      min(a.left, b.left),
      min(a.top, b.top),
      max(a.right, b.right),
      max(a.bottom, b.bottom)
    )
  }

  public init(_ left: Int32, _ top: Int32, _ right: Int32, _ bottom: Int32) {
    self.init()
    self.left = left
    self.top = top
    self.right = right
    self.bottom = bottom
  }

  public var width: Int32 {
    get {
      return right - left
    }
  }

  public var height: Int32 {
    get {
      return bottom - top
    }
  }

  public var midX: Int32 {
    get {
      return left + width / 2
    }
  }

  public var midY: Int32 {
    get {
      return top + height / 2
    }
  }

  public var size: SizeI {
    get {
      return SizeI(width, height)
    }
    set(value) {
      right = left + value.w
      bottom = top + value.h
    }
  }

  public var location: PointI {
    get {
      return PointI(left, top)
    }
    set(value) {
      self.left = value.x
      self.top = value.y
    }
  }

  public var standardized: RectI {
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

  public func aspectFit(_ size: SizeI) -> RectI {
  	RectI.truncate(toRect().aspectFit(size.toSize()))
  }

  public func aspectFill(_ size: SizeI) -> RectI {
    RectI.truncate(toRect().aspectFill(size.toSize()))
  }

  public mutating func inflate(_ size: SizeI) {
    inflate(size.w, size.h)
  }

  public mutating func inflate(_ width: Int32, _ height: Int32) {
    left -= width
    top -= height
    right += width
    bottom += height
  }

  public mutating func intersect(_ rect: RectI) {
    self = RectI.intersect(self, rect)
  }

  public func intersectsWith(_ rect: RectI) -> Bool {
    return (left < rect.right) && (right > rect.left) && (top < rect.bottom) && (bottom > rect.top)
  }

  public func intersectsWithInclusive(_ rect: RectI) -> Bool {
    return (left <= rect.right) && (right >= rect.left) && (top <= rect.bottom) && (bottom >= rect.top)
  }

  public mutating func union(_ rect: RectI) {
    self = RectI.union(self, rect)
  }

  public func contains(_ x: Int32, _ y: Int32) -> Bool {
    return (x >= left) && (x < right) && (y >= top) && (y < bottom)
  }

  public func contains(_ pt: PointI) -> Bool {
    return contains(pt.x, pt.y)
  }

  public func contains(_ rect: RectI) -> Bool {
    return (left <= rect.left) && (right >= rect.right) &&
    (top <= rect.top) && (bottom >= rect.bottom)
  }

  public mutating func offset(_ x: Int32, _ y: Int32) {
    left += x
    top += y
    right += x
    bottom += y
  }

  public mutating func offset(_ pos: PointI) {
    offset(pos.x, pos.y)
  }

  func toRect() -> Rect {
    return Rect(Float(left), Float(top), Float(right), Float(bottom))
  }
}
