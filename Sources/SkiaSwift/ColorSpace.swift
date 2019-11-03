// public class ColorSpace {
//   private static let srgb = ColorSpace(sk_colorspace_new_srgb())
//   private static let srgbLinear = ColorSpace(sk_colorspace_new_srgb_linear())

//   public static func createSrgb() -> ColorSpace {
//     return srgb
//   }

//   public static func createSrgbLinear() -> ColorSpace {
//     return srgbLinear
//   }

//   public static func createIcc(input: OpaquePointer, length: Int) {
//     var l = length
//     let handle = sk_colorspace_new_icc(input, &l)
//     return ColorSpace(handle!)
//   }

//   public static func createIcc(input: [UInt8] input, length: Int) {
//     var l = length
//     let handle = sk_colorspace_new_icc(input, &l)
//     return ColorSpace(handle!)
//   }

//   public static func createIcc(input: [UInt8]) {
//     var l = input.count
//     let handle = sk_colorspace_new_icc(input, &l)
//     return ColorSpace(handle!)
//   }

//   public static func createRgb(gamma: ColorSpaceRenderTargetGamma, toXyzD50: Matrix44) -> ColorSpace {
//     let handle = sk_colorspace_new_rgb_with_gamma(gamma, toXyzD50.handle)
//     return ColorSpace(handle!)
//   }

//   public static func createRgb(gamma: ColorSpaceRenderTargetGamma, gamut: ColorSpaceGamut) -> ColorSpace {
//     let handle = sk_colorspace_new_rgb_with_gamma_and_gamut(gamma, gamut)
//     return ColorSpace(handle!)
//   }

//   public static func createRgb(coeffs: ColorSpaceTransferFn, toXyzD50: Matrix44) -> ColorSpace {
//     let handle = sk_colorspace_new_rgb_with_coeffs(&coeffs, toXyzD50.handle)
//     return ColorSpace(handle!)
//   }

//   public static func createRgb(coeffs: ColorSpaceTransferFn, gamut: ColorSpaceGamut) -> ColorSpace {
//     let handle = sk_colorspace_new_rgb_with_coeffs_and_gamut(&coeffs, gamut)
//     return ColorSpace(handle!)
//   }

//   public static func ceateRgb(gamma: NamedGamma, toXyzD50: Matrix44) -> ColorSpace {
//     let handle = sk_colorspace_new_rgb_with_gamma_named(gamma, toXyzD50.handle)
//     return ColorSpace(handle!)
//   }

//   public static func createRgb(SKNamedGamma gamma, SKColorSpaceGamut gamut) -> ColorSpace {
//     let handle = sk_colorspace_new_rgb_with_gamma_named_and_gamut(gamma, gamut)
//     return ColorSpace(handle!)
//   }

//   public static func equal(left: ColorSpace, right: ColorSpace) -> Bool {
//     return sk_colorspace_equals(left.handle, right.handle)
//   }

//   var handle: OpaquePointer

//   init(_ handle: OpaquePointer) {
//     this.handle = handle
//   }

//   deinit {

//   }

//   public var gammaIsCloseToSrgb: Bool {
//     get {
//       return sk_colorspace_gamma_close_to_srgb(handle)
//     }
//   }

//   public var gammaIsLinear: Bool {
//     get {
//       return sk_colorspace_gamma_is_linear(handle)
//     }
//   }

//   public var isSrgb {
//     get {
//       return sk_colorspace_is_srgb(handle)
//     }
//   }

//   public var type: ColorSpaceType {
//     get {
//       ColorSpaceType(rawValue: sk_colorspace_gamma_get_type(handle))
//     }
//   }

//   public var namedGamma: NamedGamma {
//     get {
//       sk_colorspace_gamma_get_gamma_named(handle)
//     }
//   }

//   // public bool IsNumericalTransferFunction => GetNumericalTransferFunction (out _)

//   public func toXyzD50(toXyzD50: Matrix44) -> Bool {
//     return sk_colorspace_to_xyzd50(handle, toXyzD50.handle)
//   }

//   public func getNumericalTransferFunction(fn: out ColorSpaceTransferFn) -> Bool {
//     return sk_colorspace_is_numerical_transfer_fn(handle, fn)
//   }

//   public func toXyzD50() -> Matrix44 {
//     return sk_colorspace_as_to_xyzd50(handle)
//   }

//   public func fromXyzD50() -> Matrix44 {
//     return sk_colorspace_as_from_xyzd50(handle)
//   }
// }
