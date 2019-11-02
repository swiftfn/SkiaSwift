import CSkia

public class ImageInfo {
  var info = sk_imageinfo_t()

  public init(_ width: Int32, _ height: Int32, _ colorType: sk_colortype_t, _ alphaType: sk_alphatype_t) {
    info.width = width
    info.height = height
    info.colorType = colorType
    info.alphaType = alphaType
  }

  public var width: Int32 {
    get {
      return info.width
    }
  }

  public var height: Int32 {
    get {
      return info.height
    }
  }

  public var colorType: sk_colortype_t {
    get {
      return info.colorType
    }
  }

  public var alphaType: sk_alphatype_t {
    get {
      return info.alphaType
    }
  }
}
