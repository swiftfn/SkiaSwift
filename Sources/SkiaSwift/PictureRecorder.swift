import CSkia

public class PictureRecorder {
  static func new() -> PictureRecorder {
    let raw = sk_picture_recorder_new()
    return PictureRecorder(raw!)
  }

  var raw: OpaquePointer

  init(_ raw: OpaquePointer) {
    self.raw = raw
  }

  deinit {
    sk_picture_recorder_delete(raw)
  }

  public func beginRecording(rect: Rect) -> Canvas {
    var r = rect.toSk()
    let rawCanvas = sk_picture_recorder_begin_recording(raw, &r)
    return Canvas(raw: rawCanvas!)
  }

  public func endRecording() -> Picture {
    let rawPicture = sk_picture_recorder_end_recording(raw)
    return Picture(rawPicture!)
  }
}
