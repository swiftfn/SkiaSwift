import CSkia

public class Matrix {
  static func sdot(_ a: Float, _ b: Float, _ c: Float, _ d: Float) -> Float {
    return a * b + c * d
  }

  static func scross(_ a: Float, _ b: Float, _ c: Float, _ d: Float) -> Float {
    return a * b - c * d
  }

  public static func makeIdentity() -> Matrix {
    let m = Matrix()
    m.scaleX = 1
    m.scaleY = 1
    m.persp2 = 1
    return m
  }

  public static func makeScale(_ sx: Float, _ sy: Float) -> Matrix {
    if (sx == 1 && sy == 1) {
      return makeIdentity()
    }

    let m = Matrix()
    m.scaleX = sx
    m.scaleY = sy
    m.persp2 = 1
    return m
  }

  /// Set the matrix to scale by sx and sy, with a pivot point at (px, py).
  /// The pivot point is the coordinate that should remain unchanged by the
  /// specified transformation.
  public static func makeScale(_ sx: Float, _ sy: Float, _ pivotx: Float, _ pivoty: Float) -> Matrix {
    if (sx == 1 && sy == 1) {
      return makeIdentity()
    }

    let tx = pivotx - sx * pivotx
    let ty = pivoty - sy * pivoty

    let m = Matrix()
    m.scaleX = sx
    m.scaleY = sy
    m.transX = tx
    m.transY = ty
    m.persp2 = 1
    return m
  }

  public static func makeTranslation(_ dx: Float, _ dy: Float) -> Matrix {
    if (dx == 0 && dy == 0) {
      return makeIdentity()
    }

    let m = Matrix ()
    m.scaleX = 1
    m.scaleY = 1
    m.transX = dx
    m.transY = dy
    m.persp2 = 1
    return m
  }

  public static func makeRotation(_ radians: Float) -> Matrix {
    let s = sin(radians)
    let c = cos(radians)
    var m = Matrix()
    setSinCos(&m, s, c)
    return m
  }

  public static func makeRotation(_ radians: Float, _ pivotx: Float, _ pivoty: Float) -> Matrix {
    let s = sin(radians)
    let c = cos(radians)
    var m = Matrix()
    setSinCos(&m, s, c, pivotx, pivoty)
    return m
  }

  static let degToRad = Float.pi / 180

  public static func makeRotationDegrees(_ degrees: Float) -> Matrix {
    return makeRotation(degrees * degToRad)
  }

  public static func makeRotationDegrees(_ degrees: Float, _ pivotx: Float, _ pivoty: Float) -> Matrix {
    return makeRotation(degrees * degToRad, pivotx, pivoty)
  }

  static func setSinCos(_ matrix: inout Matrix, _ sine: Float, _ cosine: Float) {
    matrix.scaleX = cosine
    matrix.skewX = -sine
    matrix.transX = 0

    matrix.skewY = sine
    matrix.scaleY = cosine
    matrix.transY = 0

    matrix.persp0 = 0
    matrix.persp1 = 0
    matrix.persp2 = 1
	}

  static func setSinCos(_ matrix: inout Matrix, _ sine: Float, _ cosine: Float, _ pivotx: Float, _ pivoty: Float) {
    let oneMinusCos = 1 - cosine

    matrix.scaleX = cosine
    matrix.skewX = -sine
    matrix.transX = sdot(sine, pivoty, oneMinusCos, pivotx)

    matrix.skewY = sine
    matrix.scaleY = cosine
    matrix.transY = sdot(-sine, pivotx, oneMinusCos, pivoty)

    matrix.persp0 = 0
    matrix.persp1 = 0
    matrix.persp2 = 1
  }

  public static func rotate(_ matrix: inout Matrix, _ radians: Float, _ pivotx: Float, _ pivoty: Float) {
    let s = sin(radians)
    let c = cos(radians)
    setSinCos(&matrix, s, c, pivotx, pivoty)
  }

  public static func rotateDegrees(_ matrix: inout Matrix, _ degrees: Float, _ pivotx: Float, _ pivoty: Float) {
    let s = sin(degrees * degToRad)
    let c = cos(degrees * degToRad)
    setSinCos(&matrix, s, c, pivotx, pivoty)
  }

  public static func rotate(_ matrix: inout Matrix, _ radians: Float) {
    let s = sin(radians)
    let c = cos(radians)
    setSinCos(&matrix, s, c)
  }

  public static func rotateDegrees(_ matrix: inout Matrix, _ degrees: Float) {
    let s = sin(degrees * degToRad)
    let c = cos(degrees * degToRad)
    setSinCos(&matrix, s, c)
  }

  public static func makeSkew(_ sx: Float, _ sy: Float) -> Matrix {
    let m = Matrix()

    m.scaleX = 1
    m.skewX = sx
    m.transX = 0

    m.skewY = sy
    m.scaleY = 1
    m.transY = 0

    m.persp0 = 0
    m.persp1 = 0
    m.persp2 = 1

    return m
  }

  public static func concat(_ target: Matrix, _ first: Matrix, _ second: Matrix) {
    sk_matrix_concat(&target.handle, &first.handle, &second.handle)
  }

  public static func preConcat(_ target: Matrix, _ matrix: Matrix) {
    sk_matrix_pre_concat(&target.handle, &matrix.handle)
  }

  public static func postConcat(_ target: Matrix, _ matrix: Matrix) {
    sk_matrix_post_concat(&target.handle, &matrix.handle)
  }

  public static func mapRect(_ matrix: Matrix, _ dest: inout Rect, _ source: Rect) {
    var s = source
    sk_matrix_map_rect(&matrix.handle, &dest, &s)
  }

  var handle = sk_matrix_t()

  private class Indices {
    static let scaleX = 0
    static let skewX  = 1
    static let transX = 2

    static let skewY  = 3
    static let scaleY = 4
    static let transY = 5

    static let persp0 = 6
    static let persp1 = 7
    static let persp2 = 8

    static let count  = 9
  }

  // https://stackoverflow.com/questions/34776546/access-element-of-fixed-length-c-array-in-swift

  public var scaleX: Float {
    get {
      return handle.mat.0
    }
    set(value) {
      handle.mat.0 = value
    }
  }

  public var skewX: Float {
    get {
      return handle.mat.1
    }
    set(value) {
      handle.mat.1 = value
    }
  }

  public var transX: Float {
    get {
      return handle.mat.2
    }
    set(value) {
      handle.mat.2 = value
    }
  }

	public var skewY: Float {
    get {
      return handle.mat.3
    }
    set(value) {
      handle.mat.3 = value
    }
  }

  public var scaleY: Float {
    get {
      return handle.mat.4
    }
    set(value) {
      handle.mat.4 = value
    }
  }

  public var transY: Float {
    get {
      return handle.mat.5
    }
    set(value) {
      handle.mat.5 = value
    }
  }

	public var persp0: Float {
    get {
      return handle.mat.6
    }
    set(value) {
      handle.mat.6 = value
    }
  }

  public var persp1: Float {
    get {
      return handle.mat.7
    }
    set(value) {
      handle.mat.7 = value
    }
  }

  public var persp2: Float {
    get {
      return handle.mat.8
    }
    set(value) {
      handle.mat.8 = value
    }
  }

  public init() {
  }

  public init(
    _ scaleX: Float, _ skewX: Float, _ transX: Float,
    _ skewY: Float, _ scaleY: Float, _ transY: Float,
    _ persp0: Float, _ persp1: Float, _ persp2: Float
  ) {
    self.scaleX = scaleX
    self.skewX  = skewX
    self.transX = transX

    self.skewY  = skewY
    self.scaleY = scaleY
    self.transY = transY

    self.persp0 = persp0
    self.persp1 = persp1
    self.persp2 = persp2
  }

  public var values: [Float] {
    get {
      // https://forums.developer.apple.com/thread/72120
      return [Float](UnsafeBufferPointer(start: &handle.mat.0, count: MemoryLayout.size(ofValue: handle.mat)))
    }
    set(value) {
      if (value.count != Indices.count) {
        fatalError("The matrix array must have a count of \(Indices.count)")
      }

      scaleX = value[Indices.scaleX]
      skewX = value[Indices.skewX]
      transX = value[Indices.transX]

      skewY = value[Indices.skewY]
      scaleY = value[Indices.scaleY]
      transY = value[Indices.transY]

      persp0 = value[Indices.persp0]
      persp1 = value[Indices.persp1]
      persp2 = value[Indices.persp2]
    }
  }

  public func getValues(_ values: inout [Float]) {
    if (values.count != Indices.count) {
      fatalError("The matrix array must have a count of \(Indices.count)")
    }

    values[Indices.scaleX] = scaleX
    values[Indices.skewX] = skewX
    values[Indices.transX] = transX

    values[Indices.skewY] = skewY
    values[Indices.scaleY] = scaleY
    values[Indices.transY] = transY

    values[Indices.persp0] = persp0
    values[Indices.persp1] = persp1
    values[Indices.persp2] = persp2
  }

  public func setScaleTranslate(sx: Float, sy: Float, tx: Float, ty: Float) {
    scaleX = sx
    skewX = 0
    transX = tx

    skewY = 0
    scaleY = sy
    transY = ty

    persp0 = 0
    persp1 = 0
    persp2 = 1
  }

  public func tryInvert(_ inverse: inout Matrix) -> Bool {
    return sk_matrix_try_invert(&handle, &inverse.handle)
  }

  public func mapRect(_ source: Rect) -> Rect {
    var result = Rect()
    Matrix.mapRect(self, &result, source)
    return result
  }

  // public func mapPoints(result: [Point], points: [Point]) {
  //   if result.count != points.count {
  //     fatalError("Buffers must be the same size.")
  //   }

  //   let count = result.count
  //   var resultHandles = (0..<count).map { sk_point_t() }
  //   var

  //   sk_matrix_map_points(&handle, resultHandles, points, count)
  // }

  // public func mapPoints(points: [Point]) -> [Point] {
  //   var res = [Point](points.count)
  //   mapPoints(res, points)
  //   return res
  // }
}
