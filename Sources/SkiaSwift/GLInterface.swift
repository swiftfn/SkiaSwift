import CSkia

public class GLInterface {
  public static func createNativeInterface() -> GLInterface {
    let raw = gr_glinterface_create_native_interface()
    return GLInterface(raw!)
  }

  // SK_C_API const gr_glinterface_t* gr_glinterface_assemble_interface(void* ctx, gr_gl_get_proc get);
  // SK_C_API const gr_glinterface_t* gr_glinterface_assemble_gl_interface(void* ctx, gr_gl_get_proc get);
  // SK_C_API const gr_glinterface_t* gr_glinterface_assemble_gles_interface(void* ctx, gr_gl_get_proc get);

  var raw: OpaquePointer

  init(_ raw: OpaquePointer) {
    self.raw = raw
  }

  deinit {
    unref()
  }

  func unref() {
    gr_glinterface_unref(raw)
  }

  public func validate() -> Bool {
    return gr_glinterface_validate(raw)
  }

  public func hasExtension(ext: String) -> Bool {
    return gr_glinterface_has_extension(raw, ext)
  }
}
