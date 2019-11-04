import CSkia

public class Picture {
  var handle: OpaquePointer

  init(_ handle: OpaquePointer) {
    self.handle = handle
  }

  deinit {
    unref()
  }

  func ref() {
    sk_picture_ref(handle)
  }

  func unref() {
    sk_picture_unref(handle)
  }

  public var uniqueId: UInt32 {
    sk_picture_get_unique_id(handle)
  }
}
