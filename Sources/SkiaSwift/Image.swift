import CSkia

public class Image {
  public static func rasterCopy(imageInfo: ImageInfo, pixels: UnsafeRawPointer, rowBytes: Int) -> Image {
    var info = imageInfo
    let handle = sk_image_new_raster_copy(&info, pixels, rowBytes)
    return Image(handle!)
  }

  public static func fromEncoded(encoded: ImageData, subset: RectI) -> Image {
    var r = subset
    let handle = sk_image_new_from_encoded(encoded.handle, &r)
    return Image(handle!)
  }

  var handle: OpaquePointer

  init(_ handle: OpaquePointer) {
    self.handle = handle
  }

  deinit {
    unref()
  }

  func ref() {
    sk_image_ref(handle)
  }

  func unref() {
    sk_image_unref(handle)
  }

  public func encode() -> ImageData {
    let dataHandle = sk_image_encode(handle)
    return ImageData(dataHandle!)
  }

  public var width: Int32 {
    sk_image_get_width(handle)
  }

  public var height: Int32 {
    sk_image_get_height(handle)
  }

  public var uniqueId: UInt32 {
    sk_image_get_unique_id(handle)
  }
}
