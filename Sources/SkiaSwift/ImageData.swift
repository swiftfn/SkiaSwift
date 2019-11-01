import CSkia

public class ImageData {
  public static func empty() -> ImageData {
    let raw = sk_data_new_empty()
    return ImageData(raw!)
  }

  public static func copy(src: UnsafeRawPointer, length: Int) -> ImageData {
    let raw = sk_data_new_with_copy(src, length)
    return ImageData(raw!)
  }

  var raw: OpaquePointer

  init(_ raw: OpaquePointer) {
    self.raw = raw
  }

  deinit {
    unref()
  }

  func ref() {
    sk_data_ref(raw)
  }

  func unref() {
    sk_data_unref(raw)
  }

  public func subset(src: ImageData, offset: Int, length: Int) -> ImageData {
    let raw = sk_data_new_subset(src.raw, offset, length)
    return ImageData(raw!)
  }

  public var size: Int {
    get {
      return sk_data_get_size(raw)
    }
  }

  public var data: UnsafeRawPointer {
    get {
      return sk_data_get_data(raw)
    }
  }
}