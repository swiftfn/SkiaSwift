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

public class Picture {
  var raw: OpaquePointer

  init(_ raw: OpaquePointer) {
    self.raw = raw
  }

  deinit {
    unref()
  }

  func ref() {
    sk_picture_ref(raw)
  }

  func unref() {
    sk_picture_unref(raw)
  }

  public var uniqueId: UInt32 {
    get {
      return sk_picture_get_unique_id(raw)
    }
  }
}
