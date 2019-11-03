import CSkia

public class Shader {
  public static func linearGradient(
    point0: Point,
    point1: Point,
    colors: inout [UInt32],
    tileMode: sk_shader_tilemode_t
  ) -> Shader {
    var points = [point0, point1]
    let handle = sk_shader_new_linear_gradient(&points, &colors, nil, Int32(colors.count), tileMode, nil)
    return Shader(handle!)
  }

  public static func radialGradient(
    center: Point,
    radius: Float,
    colors: inout [UInt32],
    tileMode: sk_shader_tilemode_t
  ) -> Shader {
    var ccenter = center
    let handle = sk_shader_new_radial_gradient(&ccenter, radius, &colors, nil, Int32(colors.count), tileMode, nil)
    return Shader(handle!)
  }

  public static func sweepGradient(
    center: Point,
    radius: Float,
    colors: inout [UInt32],
    tileMode: sk_shader_tilemode_t,
    startAngle: Float,
    endAngle: Float
  ) -> Shader {
    var ccenter = center
    let handle = sk_shader_new_sweep_gradient(&ccenter, &colors, nil, Int32(colors.count), tileMode, startAngle, endAngle, nil)
    return Shader(handle!)
  }

  public static func conicalGradient(
    start: Point, startRadius: Float,
    end: Point, endRadius: Float,
    colors: inout [UInt32],
    tileMode: sk_shader_tilemode_t
  ) -> Shader {
    var cstart = start
    var cend = end
    let handle = sk_shader_new_two_point_conical_gradient(
      &cstart,
      startRadius,
      &cend,
      endRadius,
      &colors,
      nil,
      Int32(colors.count),
      tileMode,
      nil
    )
    return Shader(handle!)
  }

  var handle: OpaquePointer

  init(_ handle: OpaquePointer) {
    self.handle = handle
  }

  deinit {
    unref()
  }

  func ref() {
    sk_shader_ref(handle)
  }

  func unref() {
    sk_shader_unref(handle)
  }
}
