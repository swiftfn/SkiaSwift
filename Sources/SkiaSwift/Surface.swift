import CSkia

public class Surface {
  public static func raster(_ imageInfo: ImageInfo) -> Surface {
    let raw = sk_surface_new_raster(&imageInfo.raw, 0, nil)
    return Surface(raw!)
  }

  public static func rasterDirect(_ imageInfo: ImageInfo, _ pixels: UnsafeMutableRawPointer, _ rowBytes: Int) -> Surface {
    let raw = sk_surface_new_raster_direct(&imageInfo.raw, pixels, rowBytes, nil, nil, nil)
    return Surface(raw!)
  }

  var raw: OpaquePointer

  init(_ raw: OpaquePointer) {
    self.raw = raw
  }

  deinit {
    sk_surface_unref(raw)
  }

  public var canvas: Canvas {
    get {
      let rawCanvas = sk_surface_get_canvas(raw)
      return Canvas(raw: rawCanvas!)
    }
  }

  public var snapshot: Image {
    get {
      let rawImg = sk_surface_new_image_snapshot(raw)
      return Image(rawImg!)
    }
  }
}
