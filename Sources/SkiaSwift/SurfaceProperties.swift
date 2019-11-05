import CSkia

public class SurfaceProperties {
  var handle: OpaquePointer

  public init(flags: SurfacePropsFlags, pixelGeometry: PixelGeometry) {
    handle = sk_surfaceprops_new(flags.toC(), pixelGeometry.toC())
  }

  public convenience init(pixelGeometry: PixelGeometry) {
    self.init(flags: .none, pixelGeometry: pixelGeometry)
  }

  deinit {
    sk_surfaceprops_delete(handle)
  }

  public var flags: SurfacePropsFlags {
    SurfacePropsFlags.fromC(sk_surfaceprops_get_flags(handle))
  }

  public var pixelGeometry: PixelGeometry {
    PixelGeometry.fromC(sk_surfaceprops_get_pixel_geometry(handle))
  }

  public var useDeviceIndependentFonts: Bool {
    let flag = SurfacePropsFlags.useDeviceIndependentFonts.rawValue
    return (flags.rawValue & flag) == flag
  }
}
