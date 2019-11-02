import CSkia

public class RenderTarget {
  var raw: OpaquePointer

  public init(width: Int32, height: Int32, sampleCount: Int32, stencilBits: Int32, glInfo: GlFramebufferInfo) {
    var info = glInfo.toSk()
    let raw = gr_backendrendertarget_new_gl(
      width,
      height,
      sampleCount,
      stencilBits,
      &info
    )
    self.raw = raw!
  }

  deinit {
    delete()
  }

  func delete() {
    gr_backendrendertarget_delete(raw)
  }

  var valid: Bool {
    get {
      return gr_backendrendertarget_is_valid(raw)
    }
  }

  var width: Int32 {
    get {
      return gr_backendrendertarget_get_width(raw)
    }
  }

  var height: Int32 {
    get {
      return gr_backendrendertarget_get_height(raw)
    }
  }

  var sampleCount: Int32 {
    get {
      return gr_backendrendertarget_get_samples(raw)
    }
  }

  var stencilBits: Int32 {
    get {
      return gr_backendrendertarget_get_stencils(raw)
    }
  }

  var backend: Backend {
    get {
      return gr_backendrendertarget_get_backend(raw).toSwift()
    }
  }

  var size: SizeI {
    get {
      return SizeI(width: width, height: height)
    }
  }

  var rect: RectI {
    get {
      return RectI(0, 0, width, height)
    }
  }

  var glInfo: GlFramebufferInfo {
    get {
      var glInfo = gr_gl_framebufferinfo_t()
      gr_backendrendertarget_get_gl_framebufferinfo(raw, &glInfo)
      return glInfo.toSwift()
    }
  }
}
