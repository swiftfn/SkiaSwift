import CSkia

public class RenderTarget {
  var handle: OpaquePointer

  public init(width: Int32, height: Int32, sampleCount: Int32, stencilBits: Int32, glInfo: GlFramebufferInfo) {
    var info = glInfo.toSk()
    let handle = gr_backendrendertarget_new_gl(
      width,
      height,
      sampleCount,
      stencilBits,
      &info
    )
    self.handle = handle!
  }

  deinit {
    gr_backendrendertarget_delete(handle)
  }

  var valid: Bool {
    get {
      return gr_backendrendertarget_is_valid(handle)
    }
  }

  var width: Int32 {
    get {
      return gr_backendrendertarget_get_width(handle)
    }
  }

  var height: Int32 {
    get {
      return gr_backendrendertarget_get_height(handle)
    }
  }

  var sampleCount: Int32 {
    get {
      return gr_backendrendertarget_get_samples(handle)
    }
  }

  var stencilBits: Int32 {
    get {
      return gr_backendrendertarget_get_stencils(handle)
    }
  }

  var backend: Backend {
    get {
      return gr_backendrendertarget_get_backend(handle).toSwift()
    }
  }

  var size: SizeI {
    get {
      return SizeI(width, height)
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
      gr_backendrendertarget_get_gl_framebufferinfo(handle, &glInfo)
      return glInfo.toSwift()
    }
  }
}
