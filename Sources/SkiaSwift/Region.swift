import CSkia

public class Region {
  var handle: OpaquePointer

  public init() {
    handle = sk_region_new()
  }

  public init(region: Region) {
    handle = sk_region_new2(region.handle)
  }

  public convenience init(rect: RectI) {
    self.init()
    setRect(rect)
  }

  public convenience init(path: Path) {
    self.init(rect: RectI.ceiling(path.bounds))
    setPath(path)
  }

  deinit {
    sk_region_delete(handle)
  }

  public var bounds: RectI {
    var rect = RectI()
    sk_region_get_bounds(handle, &rect)
    return rect
  }

  public func contains(region: Region) -> Bool {
    sk_region_contains(handle, region.handle)
  }

  public func contains(point: PointI) -> Bool {
    sk_region_contains2(handle, point.x, point.y)
  }

  public func contains(x: Int32, y: Int32) -> Bool {
    sk_region_contains2(handle, x, y)
  }

  public func intersects(path: Path) -> Bool {
    var pathRegion: Region? = Region(path: path)
    let ret = intersects(region: pathRegion!)
    pathRegion = nil
    return ret
  }

  public func intersects(region: Region) -> Bool {
    sk_region_intersects(handle, region.handle)
  }

  public func intersects(rect: RectI) -> Bool {
    var r = rect
		return sk_region_intersects_rect(handle, &r)
  }

  @discardableResult
  public func setRegion(region: Region) -> Bool {
    sk_region_set_region(handle, region.handle)
  }

  @discardableResult
  public func setRect(_ rect: RectI) -> Bool {
    var r = rect
    return sk_region_set_rect(handle, &r)
  }

  @discardableResult
  public func setPath(_ path: Path, clip: Region) -> Bool {
    sk_region_set_path(handle, path.handle, clip.handle)
  }

  @discardableResult
  public func setPath(_ path: Path) -> Bool {
    var clip: Region? = Region()

    let rect = RectI.ceiling(path.bounds)
    if !rect.empty {
      clip!.setRect(rect)
    }

    let ret = sk_region_set_path(handle, path.handle, clip!.handle)
    clip = nil
    return ret
  }

  @discardableResult
  public func op(rect: RectI, op: RegionOperation) -> Bool {
    sk_region_op(handle, rect.left, rect.top, rect.right, rect.bottom, op.toC())
  }

  @discardableResult
  public func op(left: Int32, top: Int32, right: Int32, bottom: Int32, op: RegionOperation) -> Bool {
    sk_region_op(handle, left, top, right, bottom, op.toC())
  }

  @discardableResult
  public func op(region: Region, op: RegionOperation) -> Bool {
    sk_region_op2(handle, region.handle, op.toC())
  }

  @discardableResult
  public func op(path: Path, op: RegionOperation) -> Bool {
    var pathRegion: Region? = Region(path: path)
    let ret = self.op(region: pathRegion!, op: op)
    pathRegion = nil
    return ret
  }
}
