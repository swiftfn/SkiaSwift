import CSkia

public class Paint {
  var raw: OpaquePointer

  public init() {
    raw = sk_paint_new()
  }

  deinit {
    sk_paint_delete(raw)
  }

  public var antialias: Bool {
    get {
      return sk_paint_is_antialias(raw)
    }
    set(value) {
      sk_paint_set_antialias(raw, value)
    }
  }

  public var color: UInt32 {
    get {
      return sk_paint_get_color(raw)
    }
    set(value) {
      sk_paint_set_color(raw, value)
    }
  }

  public var strokeWidth: Float {
    get {
      return sk_paint_get_stroke_width(raw)
    }
    set(value) {
      sk_paint_set_stroke_width(raw, value)
    }
  }

  public var strokeMiter: Float {
    get {
      return sk_paint_get_stroke_miter(raw)
    }
    set(value) {
      sk_paint_set_stroke_miter(raw, value)
    }
  }

  public var strokeCap: sk_stroke_cap_t {
    get {
      return sk_paint_get_stroke_cap(raw)
    }
    set(value) {
      sk_paint_set_stroke_cap(raw, value)
    }
  }

  public var strokeJoin: sk_stroke_join_t {
    get {
      return sk_paint_get_stroke_join(raw)
    }
    set(value) {
      sk_paint_set_stroke_join(raw, value)
    }
  }

  public func setShader(value: Shader) {
    sk_paint_set_shader(raw, value.raw)
  }

  public func setMaskFilter(value: MaskFilter) {
    sk_paint_set_maskfilter(raw, value.raw)
  }
}
