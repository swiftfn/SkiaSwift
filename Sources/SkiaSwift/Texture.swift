import CSkia

public class Texture {
  var raw: OpaquePointer

  init(width: Int32, height: Int32, mipmapped: Bool, glInfo: GlTextureInfo) {
    var info = glInfo.toSk()
    self.raw = gr_backendtexture_new_gl(width, height, mipmapped, &info)!
  }

  deinit {
    delete()
  }

  func delete() {
    gr_backendtexture_delete(raw)
  }

  var valid: Bool {
    get {
      return gr_backendtexture_is_valid(raw)
    }
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

  var backend: Backend {
    get {
      return gr_backendtexture_get_backend(raw).toSwift()
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

  var glInfo: GlTextureInfo {
    get {
      var glInfo = gr_gl_textureinfo_t()
      gr_backendtexture_get_gl_textureinfo(raw, &glInfo)
      return glInfo.toSwift()
    }
  }
}
