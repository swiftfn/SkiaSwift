import CSkia

public class Texture {
  public static func newGl(width: Int32, height: Int32, mipmapped: Bool, glInfo: gr_gl_textureinfo_t) -> Texture {
    var info = glInfo
    let raw = gr_backendtexture_new_gl(width, height, mipmapped, &info)
    return Texture(raw!)
  }

  var raw: OpaquePointer

  init(_ raw: OpaquePointer) {
    self.raw = raw
  }

  deinit {
    delete()
  }

  func delete() {
    gr_backendtexture_delete(raw)
  }

  public func isValid() -> Bool {
    return gr_backendtexture_is_valid(raw)
  }

  var width: Int32 {
    get {
      return gr_backendtexture_get_width(raw)
    }
  }

  var height: Int32 {
    get {
      return gr_backendtexture_get_height(raw)
    }
  }

  var mipmapped: Bool {
    get {
      return gr_backendtexture_has_mipmaps(raw)
    }
  }

  var backend: gr_backend_t {
    get {
      return gr_backendtexture_get_backend(raw)
    }
  }

  var glInfo: gr_gl_textureinfo_t {
    get {
      var glInfo = gr_gl_textureinfo_t()
      gr_backendtexture_get_gl_textureinfo(raw, &glInfo)
      return glInfo
    }
  }
}
