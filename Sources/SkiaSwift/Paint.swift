import CSkia

public class Paint {
  var handle: OpaquePointer

  public init() {
    handle = sk_paint_new()
  }

  deinit {
    sk_paint_delete(handle)
  }

  public var antialias: Bool {
    get {
      return sk_paint_is_antialias(handle)
    }
    set(value) {
      sk_paint_set_antialias(handle, value)
    }
  }

  public var color: UInt32 {
    get {
      return sk_paint_get_color(handle)
    }
    set(value) {
      sk_paint_set_color(handle, value)
    }
  }

  public var strokeWidth: Float {
    get {
      return sk_paint_get_stroke_width(handle)
    }
    set(value) {
      sk_paint_set_stroke_width(handle, value)
    }
  }

  public var strokeMiter: Float {
    get {
      return sk_paint_get_stroke_miter(handle)
    }
    set(value) {
      sk_paint_set_stroke_miter(handle, value)
    }
  }

  public var strokeCap: sk_stroke_cap_t {
    get {
      return sk_paint_get_stroke_cap(handle)
    }
    set(value) {
      sk_paint_set_stroke_cap(handle, value)
    }
  }

  public var strokeJoin: sk_stroke_join_t {
    get {
      return sk_paint_get_stroke_join(handle)
    }
    set(value) {
      sk_paint_set_stroke_join(handle, value)
    }
  }

  public func setShader(value: Shader) {
    sk_paint_set_shader(handle, value.handle)
  }

  public func setMaskFilter(value: MaskFilter) {
    sk_paint_set_maskfilter(handle, value.handle)
  }
}
