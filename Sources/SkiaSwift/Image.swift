import CSkia

public class Image {
  public static func rasterCopy(imageInfo: ImageInfo, pixels: UnsafeRawPointer, rowBytes: Int) -> Image {
    let raw = sk_image_new_raster_copy(&imageInfo.raw, pixels, rowBytes)
    return Image(raw!)
  }

  public static func fromEncoded(encoded: ImageData, subset: IRect) -> Image {
    var r = subset.toSk()
    let raw = sk_image_new_from_encoded(encoded.raw, &r)
    return Image(raw!)
  }

  var raw: OpaquePointer

  init(_ raw: OpaquePointer) {
    self.raw = raw
  }

  deinit {
    unref()
  }

  func ref() {
    sk_image_ref(raw)
  }

  func unref() {
    sk_image_unref(raw)
  }

  public func encode() -> ImageData {
    let rawData = sk_image_encode(raw)
    return ImageData(rawData!)
  }

  public var width: Int32 {
    get {
      return sk_image_get_width(raw)
    }
  }

  public var height: Int32 {
    get {
      return sk_image_get_height(raw)
    }
  }

  public var uniqueId: UInt32 {
    get {
      return sk_image_get_unique_id(raw)
    }
  }
}
