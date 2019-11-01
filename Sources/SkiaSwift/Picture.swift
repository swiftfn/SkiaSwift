import CSkia

public class Picture {
  var raw: OpaquePointer

  init(_ raw: OpaquePointer) {
    self.raw = raw
  }

  deinit {
    unref()
  }

  func ref() {
    sk_picture_ref(raw)
  }

  func unref() {
    sk_picture_unref(raw)
  }

  public var uniqueId: UInt32 {
    get {
      return sk_picture_get_unique_id(raw)
    }
  }
}
