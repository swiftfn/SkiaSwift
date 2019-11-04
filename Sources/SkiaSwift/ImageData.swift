import CSkia

public class ImageData {
  public static func empty() -> ImageData {
    let handle = sk_data_new_empty()
    return ImageData(handle!)
  }

  public static func copy(src: UnsafeRawPointer, length: Int) -> ImageData {
    let handle = sk_data_new_with_copy(src, length)
    return ImageData(handle!)
  }

  var handle: OpaquePointer

  init(_ handle: OpaquePointer) {
    self.handle = handle
  }

  deinit {
    unref()
  }

  func ref() {
    sk_data_ref(handle)
  }

  func unref() {
    sk_data_unref(handle)
  }

  public func subset(src: ImageData, offset: Int, length: Int) -> ImageData {
    let handle = sk_data_new_subset(src.handle, offset, length)
    return ImageData(handle!)
  }

  public var size: Int {
    sk_data_get_size(handle)
  }

  public var data: UnsafeRawPointer {
    sk_data_get_data(handle)
  }
}