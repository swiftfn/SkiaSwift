import CSkia

// https://bugs.chromium.org/p/skia/issues/detail?id=9586
public class Matrix {
  var handle: sk_matrix_t

  public init() {
    handle = sk_matrix_t()
    // sk_matrix_set_identity(&handle)
  }

  public func setIdentity() {
    // sk_matrix_set_identity(&handle)
  }

  public func setTranslate(tx: Float, ty: Float) {
    // sk_matrix_set_translate(&handle, tx, ty)
  }

  public func preTranslate(tx: Float, ty: Float) {
    // sk_matrix_pre_translate(&handle, tx, ty)
  }

  public func postTranslate(tx: Float, ty: Float) {
    // sk_matrix_post_translate(&handle, tx, ty)
  }

  public func setScale(sx: Float, sy: Float) {
    // sk_matrix_set_scale(&handle, sx, sy)
  }

  public func preScale(sx: Float, sy: Float) {
    // sk_matrix_pre_scale(&handle, sx, sy)
  }

  public func postScale(sx: Float, sy: Float) {
    // sk_matrix_post_scale(&handle, sx, sy)
  }
}
