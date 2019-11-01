import CSkia

public class ImageInfo {
  var raw = sk_imageinfo_t()

  public init(_ width: Int32, _ height: Int32, _ colorType: sk_colortype_t, _ alphaType: sk_alphatype_t) {
    raw.width = width
    raw.height = height
    raw.colorType = colorType
    raw.alphaType = alphaType
  }

  public var width: Int32 {
    get {
      return raw.width
    }
  }

  public var height: Int32 {
    get {
      return raw.height
    }
  }

  public var colorType: sk_colortype_t {
    get {
      return raw.colorType
    }
  }

  public var alphaType: sk_alphatype_t {
    get {
      return raw.alphaType
    }
  }
}
