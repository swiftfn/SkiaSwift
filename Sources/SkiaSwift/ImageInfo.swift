import CSkia

struct PlatformColorShift {
  let a: Int32
  let r: Int32
  let g: Int32
  let b: Int32

  init() {
    var a: Int32 = 0
    var r: Int32 = 0
    var g: Int32 = 0
    var b: Int32 = 0
    sk_color_get_bit_shift(&a, &r, &g, &b)
    self.a = a
    self.r = r
    self.g = g
    self.b = b
  }
}

public struct ImageInfo {
  static let platformColorType = ColorType(rawValue: sk_colortype_get_default_8888().rawValue)
  static let platformColorShift = PlatformColorShift()

  var handle = sk_imageinfo_t()

  public init(_ width: Int32, _ height: Int32, _ colorType: sk_colortype_t, _ alphaType: sk_alphatype_t) {
    handle.width = width
    handle.height = height
    handle.colorType = colorType
    handle.alphaType = alphaType
  }

  public var width: Int32 {
    get {
      return handle.width
    }
  }

  public var height: Int32 {
    get {
      return handle.height
    }
  }

  public var colorType: sk_colortype_t {
    get {
      return handle.colorType
    }
  }

  public var alphaType: sk_alphatype_t {
    get {
      return handle.alphaType
    }
  }
}
