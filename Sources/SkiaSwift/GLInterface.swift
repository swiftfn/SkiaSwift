import CSkia

public class GLInterface {
  public static func createNativeInterface() -> GLInterface {
    let handle = gr_glinterface_create_native_interface()
    return GLInterface(handle!)
  }

  // SK_C_API const gr_glinterface_t* gr_glinterface_assemble_interface(void* ctx, gr_gl_get_proc get);
  // SK_C_API const gr_glinterface_t* gr_glinterface_assemble_gl_interface(void* ctx, gr_gl_get_proc get);
  // SK_C_API const gr_glinterface_t* gr_glinterface_assemble_gles_interface(void* ctx, gr_gl_get_proc get);

  var handle: OpaquePointer

  init(_ handle: OpaquePointer) {
    self.handle = handle
  }

  deinit {
    unref()
  }

  func unref() {
    gr_glinterface_unref(handle)
  }

  public func validate() -> Bool {
    gr_glinterface_validate(handle)
  }

  public func hasExtension(ext: String) -> Bool {
    gr_glinterface_has_extension(handle, ext)
  }
}
