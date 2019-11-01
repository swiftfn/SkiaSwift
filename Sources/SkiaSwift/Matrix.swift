import CSkia

// https://bugs.chromium.org/p/skia/issues/detail?id=9586
public class Matrix {
  var raw: sk_matrix_t

  public init() {
    raw = sk_matrix_t()
    // sk_matrix_set_identity(&raw)
  }

  public func setIdentity() {
    // sk_matrix_set_identity(&raw)
  }

  public func setTranslate(tx: Float, ty: Float) {
    // sk_matrix_set_translate(&raw, tx, ty)
  }

  public func preTranslate(tx: Float, ty: Float) {
    // sk_matrix_pre_translate(&raw, tx, ty)
  }

  public func postTranslate(tx: Float, ty: Float) {
    // sk_matrix_post_translate(&raw, tx, ty)
  }

  public func setScale(sx: Float, sy: Float) {
    // sk_matrix_set_scale(&raw, sx, sy)
  }

  public func preScale(sx: Float, sy: Float) {
    // sk_matrix_pre_scale(&raw, sx, sy)
  }

  public func postScale(sx: Float, sy: Float) {
    // sk_matrix_post_scale(&raw, sx, sy)
  }
}
