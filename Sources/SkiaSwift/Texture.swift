import CSkia

public class Texture {
  var handle: OpaquePointer

  init(width: Int32, height: Int32, mipmapped: Bool, glInfo: GlTextureInfo) {
    var info = glInfo
    self.handle = gr_backendtexture_new_gl(width, height, mipmapped, &info)!
  }

  deinit {
    delete()
  }

  func delete() {
    gr_backendtexture_delete(handle)
  }

  var valid: Bool {
    get {
      return gr_backendtexture_is_valid(handle)
    }
  }

  var width: Int32 {
    get {
      return gr_backendtexture_get_width(handle)
    }
  }

  var height: Int32 {
    get {
      return gr_backendtexture_get_height(handle)
    }
  }

  var mipmapped: Bool {
    get {
      return gr_backendtexture_has_mipmaps(handle)
    }
  }

  var backend: Backend {
    get {
      return gr_backendtexture_get_backend(handle)
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

  var glInfo: GlTextureInfo {
    get {
      var info = GlTextureInfo()
      gr_backendtexture_get_gl_textureinfo(handle, &info)
      return info
    }
  }
}
