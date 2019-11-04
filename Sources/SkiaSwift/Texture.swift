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
    gr_backendtexture_is_valid(handle)
  }

  var width: Int32 {
    gr_backendtexture_get_width(handle)
  }

  var height: Int32 {
    gr_backendtexture_get_height(handle)
  }

  var mipmapped: Bool {
    gr_backendtexture_has_mipmaps(handle)
  }

  var backend: Backend {
    Backend.fromC(gr_backendtexture_get_backend(handle))
  }

  var size: SizeI {
    SizeI(width, height)
  }

  var rect: RectI {
    RectI(0, 0, width, height)
  }

  var glInfo: GlTextureInfo {
    var info = GlTextureInfo()
    gr_backendtexture_get_gl_textureinfo(handle, &info)
    return info
  }
}
