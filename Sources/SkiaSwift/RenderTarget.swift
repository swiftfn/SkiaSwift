import CSkia

public class RenderTarget {
  public static func newGl(width: Int32, height: Int32, samples: Int32, stencils: Int32, glInfo: gr_gl_framebufferinfo_t) -> RenderTarget {
    var info = glInfo
    let raw = gr_backendrendertarget_new_gl(width, height, samples, stencils, &info)
    return RenderTarget(raw!)
  }

  var raw: OpaquePointer

  init(_ raw: OpaquePointer) {
    self.raw = raw
  }

  deinit {
    delete()
  }

  func delete() {
    gr_backendrendertarget_delete(raw)
  }

  public func isValid() -> Bool {
    return gr_backendrendertarget_is_valid(raw)
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

  var samples: Int32 {
    get {
      return gr_backendrendertarget_get_samples(raw)
    }
  }

  var stencils: Int32 {
    get {
      return gr_backendrendertarget_get_stencils(raw)
    }
  }

  var backend: gr_backend_t {
    get {
      return gr_backendrendertarget_get_backend(raw)
    }
  }

  var glInfo: gr_gl_framebufferinfo_t {
    get {
      var glInfo = gr_gl_framebufferinfo_t()
      gr_backendrendertarget_get_gl_framebufferinfo(raw, &glInfo)
      return glInfo
    }
  }
}
