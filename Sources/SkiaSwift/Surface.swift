import CSkia

public class Surface {
  public static func raster(_ imageInfo: ImageInfo) -> Surface {
    var info = imageInfo
    let handle = sk_surface_new_raster(&info, 0, nil)
    return Surface(handle!)
  }

  public static func rasterDirect(_ imageInfo: ImageInfo, _ pixels: UnsafeMutableRawPointer, _ rowBytes: Int) -> Surface {
    var info = imageInfo
    let handle = sk_surface_new_raster_direct(&info , pixels, rowBytes, nil, nil, nil)
    return Surface(handle!)
  }

  var handle: OpaquePointer

  init(_ handle: OpaquePointer) {
    self.handle = handle
  }

  deinit {
    sk_surface_unref(handle)
  }

  public var canvas: Canvas {
    get {
      let canvasHandle = sk_surface_get_canvas(handle)
      return Canvas(handle: canvasHandle!)
    }
  }

  public var snapshot: Image {
    get {
      let imgHandle = sk_surface_new_image_snapshot(handle)
      return Image(imgHandle!)
    }
  }
}
