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
      return sk_paint_is_antialias(handle)
    }
    set(value) {
      sk_paint_set_antialias(handle, value)
    }
  }

  public var dither: Bool {
    get {
      return sk_paint_is_dither(handle)
    }
    set(value) {
      sk_paint_set_dither(handle, value)
    }
  }

  public var verticalText: Bool {
    get {
      return sk_paint_is_verticaltext(handle)
    }
    set(value) {
      sk_paint_set_verticaltext(handle, value)
    }
  }

  public var linearText: Bool {
    get {
      return sk_paint_is_linear_text(handle)
    }
    set(value) {
      sk_paint_set_linear_text(handle, value)
    }
  }

  public var subpixelText: Bool {
    get {
      return sk_paint_is_subpixel_text(handle)
    }
    set(value) {
      sk_paint_set_subpixel_text(handle, value)
    }
  }

  public var lcdRenderText: Bool {
    get {
      return sk_paint_is_lcd_render_text(handle)
    }
    set(value) {
      sk_paint_set_lcd_render_text(handle, value)
    }
  }

  public var embeddedBitmapText: Bool {
    get {
      return sk_paint_is_embedded_bitmap_text(handle)
    }
    set(value) {
      sk_paint_set_embedded_bitmap_text(handle, value)
    }
  }

  public var autohinted: Bool {
    get {
      return sk_paint_is_autohinted(handle)
    }
    set(value) {
      sk_paint_set_autohinted(handle, value)
    }
  }

  public var hintingLevel: PaintHinting {
    get {
      return PaintHinting.fromC(sk_paint_get_hinting(handle))
    }
    set(value) {
      sk_paint_set_hinting(handle, value.toC())
    }
  }

  public var fakeBoldText: Bool {
    get {
      return sk_paint_is_fake_bold_text(handle)
    }
    set(value) {
      sk_paint_set_fake_bold_text(handle, value)
    }
  }

  public var deviceKerningEnabled: Bool {
    get {
      return sk_paint_is_dev_kern_text(handle)
    }
    set(value) {
      sk_paint_set_dev_kern_text(handle, value)
    }
  }

  public var stroke: Bool {
    get {
      return style != PaintStyle.fill
    }
    set(value) {
      style = value ? PaintStyle.stroke : PaintStyle.fill
    }
  }

  public var style: PaintStyle {
    get {
      return PaintStyle.fromC(sk_paint_get_style(handle))
    }
    set(value) {
      sk_paint_set_style(handle, value.toC())
    }
  }

  public var color: Color {
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

  public var shader: Shader? {
    get {
      let shaderHandle = sk_paint_get_shader(handle)
      return shaderHandle == nil ? nil : Shader(shaderHandle!)
    }
    set(value) {
      sk_paint_set_shader(handle, value?.handle)
    }
  }

  public var maskFilter: MaskFilter? {
    get {
      let maskFilterHandle = sk_paint_get_maskfilter(handle)
      return maskFilterHandle == nil ? nil : MaskFilter(maskFilterHandle!)
    }
    set(value) {
      sk_paint_set_maskfilter(handle, value?.handle)
    }
  }
}
