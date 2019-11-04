import CSkia

public class Paint {
  var handle: OpaquePointer

  public init() {
    handle = sk_paint_new()
  }

  deinit {
    sk_paint_delete(handle)
  }

  public func reset() {
    sk_paint_reset(handle)
  }

  public var antialias: Bool {
    get {
      sk_paint_is_antialias(handle)
    }
    set {
      sk_paint_set_antialias(handle, newValue)
    }
  }

  public var dither: Bool {
    get {
      sk_paint_is_dither(handle)
    }
    set {
      sk_paint_set_dither(handle, newValue)
    }
  }

  public var verticalText: Bool {
    get {
      sk_paint_is_verticaltext(handle)
    }
    set {
      sk_paint_set_verticaltext(handle, newValue)
    }
  }

  public var linearText: Bool {
    get {
      sk_paint_is_linear_text(handle)
    }
    set {
      sk_paint_set_linear_text(handle, newValue)
    }
  }

  public var subpixelText: Bool {
    get {
      sk_paint_is_subpixel_text(handle)
    }
    set {
      sk_paint_set_subpixel_text(handle, newValue)
    }
  }

  public var lcdRenderText: Bool {
    get {
      sk_paint_is_lcd_render_text(handle)
    }
    set {
      sk_paint_set_lcd_render_text(handle, newValue)
    }
  }

  public var embeddedBitmapText: Bool {
    get {
      sk_paint_is_embedded_bitmap_text(handle)
    }
    set {
      sk_paint_set_embedded_bitmap_text(handle, newValue)
    }
  }

  public var autohinted: Bool {
    get {
      sk_paint_is_autohinted(handle)
    }
    set {
      sk_paint_set_autohinted(handle, newValue)
    }
  }

  public var hintingLevel: PaintHinting {
    get {
      PaintHinting.fromC(sk_paint_get_hinting(handle))
    }
    set {
      sk_paint_set_hinting(handle, newValue.toC())
    }
  }

  public var fakeBoldText: Bool {
    get {
      sk_paint_is_fake_bold_text(handle)
    }
    set {
      sk_paint_set_fake_bold_text(handle, newValue)
    }
  }

  public var deviceKerningEnabled: Bool {
    get {
      sk_paint_is_dev_kern_text(handle)
    }
    set {
      sk_paint_set_dev_kern_text(handle, newValue)
    }
  }

  public var stroke: Bool {
    get {
      style != PaintStyle.fill
    }
    set {
      style = newValue ? PaintStyle.stroke : PaintStyle.fill
    }
  }

  public var style: PaintStyle {
    get {
      PaintStyle.fromC(sk_paint_get_style(handle))
    }
    set {
      sk_paint_set_style(handle, newValue.toC())
    }
  }

  public var color: Color {
    get {
      sk_paint_get_color(handle)
    }
    set {
      sk_paint_set_color(handle, newValue)
    }
  }

  public var strokeWidth: Float {
    get {
      sk_paint_get_stroke_width(handle)
    }
    set {
      sk_paint_set_stroke_width(handle, newValue)
    }
  }

  public var strokeMiter: Float {
    get {
      sk_paint_get_stroke_miter(handle)
    }
    set {
      sk_paint_set_stroke_miter(handle, newValue)
    }
  }

  public var strokeCap: sk_stroke_cap_t {
    get {
      sk_paint_get_stroke_cap(handle)
    }
    set {
      sk_paint_set_stroke_cap(handle, newValue)
    }
  }

  public var strokeJoin: sk_stroke_join_t {
    get {
      sk_paint_get_stroke_join(handle)
    }
    set {
      sk_paint_set_stroke_join(handle, newValue)
    }
  }

  public var shader: Shader? {
    get {
      let shaderHandle = sk_paint_get_shader(handle)
      return shaderHandle == nil ? nil : Shader(shaderHandle!)
    }
    set {
      sk_paint_set_shader(handle, newValue?.handle)
    }
  }

  public var maskFilter: MaskFilter? {
    get {
      let maskFilterHandle = sk_paint_get_maskfilter(handle)
      return maskFilterHandle == nil ? nil : MaskFilter(maskFilterHandle!)
    }
    set {
      sk_paint_set_maskfilter(handle, newValue?.handle)
    }
  }
}
