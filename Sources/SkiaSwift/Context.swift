import CSkia

public class Context {
  public static func makeGl(glInterface: GLInterface) -> Context {
    let raw = gr_context_make_gl(glInterface.raw)
    return Context(raw!)
  }

  var raw: OpaquePointer

  init(_ raw: OpaquePointer) {
    self.raw = raw
  }

  deinit {
    unref()
  }

  func unref() {
    gr_context_unref(raw)
  }

  public func abandonContext() {
    gr_context_abandon_context(raw)
  }

  public func releaseResourcesAndAbandonContext() {
    gr_context_release_resources_and_abandon_context(raw)
  }

  // SK_C_API void gr_context_get_resource_cache_limits(gr_context_t* context, int* maxResources, size_t* maxResourceBytes);
  // SK_C_API void gr_context_set_resource_cache_limits(gr_context_t* context, int maxResources, size_t maxResourceBytes);
  // SK_C_API void gr_context_get_resource_cache_usage(gr_context_t* context, int* maxResources, size_t* maxResourceBytes);
  // SK_C_API int gr_context_get_max_surface_sample_count_for_color_type(gr_context_t* context, sk_colortype_t colorType);

  public func flush() {
    gr_context_flush(raw)
  }

  public func resetContext(state: UInt32) {
    gr_context_reset_context(raw, state)
  }

  var backend: gr_backend_t {
    get {
      return gr_context_get_backend(raw)
    }
  }
}
