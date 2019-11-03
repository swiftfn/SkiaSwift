import CSkia

public class PictureRecorder {
  static func new() -> PictureRecorder {
    let handle = sk_picture_recorder_new()
    return PictureRecorder(handle!)
  }

  var handle: OpaquePointer

  init(_ handle: OpaquePointer) {
    self.handle = handle
  }

  deinit {
    sk_picture_recorder_delete(handle)
  }

  public func beginRecording(rect: Rect) -> Canvas {
    var r = rect
    let canvasHandle = sk_picture_recorder_begin_recording(handle, &r)
    return Canvas(handle: canvasHandle!)
  }

  public func endRecording() -> Picture {
    let pictureHandle = sk_picture_recorder_end_recording(handle)
    return Picture(pictureHandle!)
  }
}
