import CSkia

public class MaskFilter {
  public static func blur(blurStyle: sk_blurstyle_t, sigma: Float) -> MaskFilter {
    let handle = sk_maskfilter_new_blur(blurStyle, sigma)
    return MaskFilter(handle!)
  }

  var handle: OpaquePointer

  init(_ handle: OpaquePointer) {
    self.handle = handle
  }

  deinit {
    unref()
  }

  func ref() {
    sk_maskfilter_ref(handle)
  }

  func unref() {
    sk_maskfilter_unref(handle)
  }
}
