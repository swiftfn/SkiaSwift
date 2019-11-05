import CSkia
import Foundation

// Swift sees C's enums as UInt32

public enum CodecResult: UInt32 {
  case success,
  incompleteInput,
  errorInInput,
  invalidConversion,
  invalidScale,
  invalidParameters,
  invalidInput,
  couldNotRewind,
  internalError,
  unimplemented
}

public enum EncodedOrigin: UInt32 {
  case topLeft = 1,
  topRight,
  bottomRight,
  bottomLeft,
  leftTop,
  rightTop,
  rightBottom,
  leftBottom

  public static let defaultOrigin = topLeft
}

public enum EncodedImageFormat: UInt32 {
  case bmp,
  gif,
  ico,
  jpeg,
  png,
  wbmp,
  webp,
  pkm,
  ktx,
  astc,
  dng
  // heif  // appears to be development still
}

public enum FontStyleWeight: UInt32 {
  case invisible  = 0
  case thin       = 100
  case extraLight = 200
  case light      = 300
  case normal     = 400
  case medium     = 500
  case semiBold   = 600
  case bold       = 700
  case extraBold  = 800
  case black      = 900
  case extraBlack = 1000
}

public enum FontStyleWidth: UInt32 {
  case ultraCondensed = 1,
  extraCondensed,
  condensed,
  semiCondensed,
  normal,
  semiExpanded,
  expanded,
  extraExpanded,
  ultraExpanded
}

public enum FontStyleSlant: UInt32 {
  case upright,
  italic,
  oblique
}

public enum PointMode: UInt32 {
  case points,
  lines,
  polygon
}

public enum PathDirection: UInt32 {
  case clockwise = 1,
  counterClockwise
}

public enum PathArcSize: UInt32 {
  case small,
  large
}

public enum PathFillType: UInt32 {
  case winding,
  evenOdd,
  inverseWinding,
  inverseEvenOdd
}

public enum PathSegmentMask: UInt32 {
  case line  = 1  // 1 << 0
  case quad  = 2  // 1 << 1
  case conic = 4  // 1 << 2
  case cubic = 8  // 1 << 3
}

public enum ColorType: UInt32 {
  case unknown,
  alpha8,
  rgb565,
  argb4444,
  rgba8888,
  rgb888x,
  bgra8888,
  rgba1010102,
  rgb101010x,
  gray8,
  rgbaF16

  func toC() -> sk_colortype_t {
    sk_colortype_t(rawValue)
  }
}

public enum AlphaType: UInt32 {
  case unknown,
  opaque,
  premul,
  unpremul

  func toC() -> sk_alphatype_t {
    sk_alphatype_t(rawValue)
  }
}

public enum ShaderTileMode: UInt32 {
  case clamp,
  repeatMode,
  mirror
}

public enum BlurStyle: UInt32 {
  case normal,
  solid,
  outer,
  inner
}

public enum BlendMode: UInt32 {
  case clear,
  src,
  dst,
  srcOver,
  dstOver,
  srcIn,
  dstIn,
  srcOut,
  dstOut,
  srcATop,
  sstATop,
  xor,
  plus,
  modulate,
  screen,
  overlay,
  darken,
  lighten,
  colorDodge,
  colorBurn,
  hardLight,
  softLight,
  difference,
  exclusion,
  multiply,
  hue,
  saturation,
  color,
  luminosity
}

public enum PixelGeometry: UInt32 {
  case unknown,
  rgbHorizontal,
  bgrHorizontal,
  rgbVertical,
  bgrVertical

  public static func isBgr(pg: PixelGeometry) -> Bool {
    pg == .bgrHorizontal || pg == .bgrVertical
  }

  public static func isRgb(pg: PixelGeometry) -> Bool {
    pg == .rgbHorizontal || pg == .rgbVertical
  }

  public static func isVertical(pg: PixelGeometry) -> Bool {
    pg == .bgrVertical || pg == .rgbVertical
  }

  public static func isHorizontal(pg: PixelGeometry) -> Bool {
    pg == .bgrHorizontal || pg == .rgbHorizontal
  }

  static func fromC(_ geometry: sk_pixelgeometry_t) -> PixelGeometry {
    PixelGeometry(rawValue: geometry.rawValue)!
  }

  func toC() -> sk_pixelgeometry_t {
    sk_pixelgeometry_t(rawValue)
  }
}

public enum SurfacePropsFlags: UInt32 {
  case none
  case useDeviceIndependentFonts

  static func fromC(_ flags: UInt32) -> SurfacePropsFlags {
    SurfacePropsFlags(rawValue: flags)!
  }

  func toC() -> UInt32 {
    rawValue
  }
}

public enum Encoding: UInt32 {
  case utf8,
  utf16,
  utf32
}

public enum StrokeCap: UInt32 {
  case butt,
  round,
  square
}

public enum StrokeJoin: UInt32 {
  case miter,
  round,
  bevel
}

public enum TextAlign: UInt32 {
  case left,
  center,
  right
}

public enum TextEncoding: UInt32 {
  case utf8,
  utf16,
  utf32,
  glyphId
}

public enum FilterQuality: UInt32 {
  case none,
  low,
  medium,
  high
}

public enum CropRectFlags: UInt32 {
  case hasNone = 0,
  hasLeft = 0x01,
  hasTop = 0x02,
  hasWidth = 0x04,
  hasHeight = 0x08,
  hasAll = 0x0F
}

public enum DropShadowImageFilterShadowMode: UInt32 {
  case drawShadowAndForeground,
  drawShadowOnly
}

public enum DisplacementMapEffectChannelSelectorType: UInt32 {
  case unknown,
  r,
  g,
  b,
  a
}

public enum MatrixConvolutionTileMode: UInt32 {
  case clamp,
  repeatMode,
  clampToBlack
}

public enum PaintStyle: UInt32 {
  case fill,
  stroke,
  strokeAndFill

  static func fromC(_ paintStyle: sk_paint_style_t) -> PaintStyle {
    PaintStyle(rawValue: paintStyle.rawValue)!
  }

  func toC() -> sk_paint_style_t {
    sk_paint_style_t(rawValue)
  }
}

public enum PaintHinting: UInt32 {
  case noHinting,
  slight,
  normal,
  full

  static func fromC(_ paintHinting: sk_paint_hinting_t) -> PaintHinting {
    PaintHinting(rawValue: paintHinting.rawValue)!
  }

  func toC() -> sk_paint_hinting_t {
    sk_paint_hinting_t(rawValue)
  }
}

public enum RegionOperation: UInt32 {
  case difference,
  intersect,
  union,
  xor,
  reverseDifference,
  replace

  static func fromC(_ op: sk_region_op_t) -> RegionOperation {
    RegionOperation(rawValue: op.rawValue)!
  }

  func toC() -> sk_region_op_t {
    sk_region_op_t(rawValue)
  }
}

public enum ClipOperation: UInt32 {
  case difference,
  intersect
}

public enum CodecZeroInitialized: UInt32 {
  case yes,
  no
}

public enum CodecScanlineOrder: UInt32 {
  case topDown,
  bottomUp
}

public enum TransferFunctionBehavior: UInt32 {
  case respect,
  ignore
}

struct CodecOptionsInternal {
  var fZeroInitialized: CodecZeroInitialized
  var fSubset: RectI
  var fFrameIndex: Int
  var fPriorFrame: Int
  var fPremulBehavior: TransferFunctionBehavior
}

public struct CodecOptions {
  public static let defaultOptions = CodecOptions(zeroInitialized: .no)

  public var zeroInitialized: CodecZeroInitialized = .no
  public var subset: RectI? = nil
  public var frameIndex: Int = 0
  public var priorFrame: Int = -1
  public var premulBehavior: TransferFunctionBehavior = .respect

  public init(zeroInitialized: CodecZeroInitialized) {
    self.zeroInitialized = zeroInitialized
  }

  public init(zeroInitialized: CodecZeroInitialized, subset: RectI) {
    self.zeroInitialized = zeroInitialized
    self.subset = subset
  }

  public init(subset: RectI) {
    self.subset = subset
  }

  public init(frameIndex: Int) {
    self.frameIndex = frameIndex
  }

  public init(frameIndex: Int, priorFrame: Int) {
    self.frameIndex = frameIndex
    self.priorFrame = priorFrame
  }

  public var hasSubset: Bool {
    subset != nil
  }
}

public enum CodecAnimationDisposalMethod: UInt32 {
  case keep = 1,
  restoreBackgroundColor,
  restorePrevious
}

public struct CodecFrameInfo {
  var requiredFrame: Int
  var duration: Int
  var fullyRecieved: UInt8
  var alphaType: AlphaType
  var disposalMethod: CodecAnimationDisposalMethod
}

public struct FontMetrics {
  private static let flagsUnderlineThicknessIsValid: UInt = 1  // 1 << 0
  private static let flagsUnderlinePositionIsValid:  UInt = 2  // 1 << 1
  private static let flagsStrikeoutThicknessIsValid: UInt = 4  // 1 << 2
  private static let flagsStrikeoutPositionIsValid:  UInt = 8  // 1 << 3

  var flags: UInt                     // Bit field to identify which values are unknown
  var top: Float                      // The greatest distance above the baseline for any glyph (will be <= 0)
  var ascent: Float                   // The recommended distance above the baseline (will be <= 0)
  var descent: Float                  // The recommended distance below the baseline (will be >= 0)
  var bottom: Float                   // The greatest distance below the baseline for any glyph (will be >= 0)
  var leading: Float                  // The recommended distance to add between lines of text (will be >= 0)
  var avgCharWidth: Float             // The average character width (>= 0)
  var maxCharWidth: Float             // The max character width (>= 0)
  var xMin: Float                     // The minimum bounding box x value for all glyphs
  var xMax: Float                     // The maximum bounding box x value for all glyphs
  var xHeight: Float                  // The height of an 'x' in px, or 0 if no 'x' in face
  var capHeight: Float                // The cap height (> 0), or 0 if cannot be determined.
  var underlineThickness: Float       // Underline thickness, or 0 if cannot be determined
  var underlinePosition: Float        // Underline position, or 0 if cannot be determined
  var strikeoutThickness: Float
  var strikeoutPosition: Float

  public func getUnderlineThickness() -> Float? {
    getIfValid(underlineThickness, FontMetrics.flagsUnderlineThicknessIsValid)
  }

  public func getUnderlinePosition() -> Float? {
    getIfValid(underlinePosition, FontMetrics.flagsUnderlinePositionIsValid)
  }

  public func getStrikeoutThickness() -> Float? {
    getIfValid(strikeoutThickness, FontMetrics.flagsStrikeoutThicknessIsValid)
  }

  public func getStrikeoutPosition() -> Float? {
    getIfValid(strikeoutPosition, FontMetrics.flagsStrikeoutPositionIsValid)
  }

  private func getIfValid(_ value: Float, _ flag: UInt) -> Float? {
    (flags & flag) == flag ? value : nil
  }
}

public enum PathOp: UInt32 {
  case difference,
  intersect,
  union,
  xor,
  reverseDifference
}

public enum PathConvexity: UInt32 {
  case unknown,
  convex,
  concave
}

public enum LatticeRectType: UInt32 {
  case defaultType,
  transparent,
  fixedColor
}

struct SKLatticeInternal {
  var fXDivs: UnsafePointer<Int>
  var fYDivs: UnsafePointer<Int>
  var fRectTypes: UnsafePointer<LatticeRectType>
  var fXCount: Int
  var fYCount: Int
  var fBounds: UnsafePointer<RectI>
  var fColors: UnsafePointer<Color>
}

public struct SKLattice {
  var xDivs: [Int]
  var yDivs: [Int]
  var rectTypes: [LatticeRectType]
  var bounds: RectI?
  var colors: [Color]
}

struct TimeDateTimeInternal {
  var timeZoneMinutes: Int16
  var year: UInt16
  var month: UInt8
  var dayOfWeek: UInt8
  var day: UInt8
  var hour: UInt8
  var minute: UInt8
  var second: UInt8

  // FIXME
  // public static func create(datetime: DateTime) -> TimeDateTimeInternal {
  //   var zone = datetime.Hour - datetime.ToUniversalTime().Hour
  //   return TimeDateTimeInternal(
  //     timeZoneMinutes = (Int16)(zone * 60),
  //     year = (UInt16)datetime.Year,
  //     month = (Byte)datetime.Month,
  //     dayOfWeek = (Byte)datetime.DayOfWeek,
  //     day = (Byte)datetime.Day,
  //     hour = (Byte)datetime.Hour,
  //     minute = (Byte)datetime.Minute,
  //     second = (Byte)datetime.Second
  //   )
  // }
}

// FIXME
// struct DocumentPdfMetadataInternal {
//   var title: sk_string_t
//   var author: sk_string_t
//   var subject: sk_string_t
//   var keywords: sk_string_t
//   var creator: sk_string_t
//   var producer: sk_string_t
//   var creation: UnsafePointer<TimeDateTimeInternal>
//   var modified: UnsafePointer<TimeDateTimeInternal>
//   var rasterDpi: Float
//   var pdfa: UInt8
//   var encodingQuality: Int
// }

public struct DocumentPdfMetadata {
  public static let defaultRasterDpi = Document.defaultRasterDpi
  public static let defaultEncodingQuality = 101

  public static let defaultMetadata = DocumentPdfMetadata(rasterDpi: DocumentPdfMetadata.defaultRasterDpi)

  var title: String? = nil
  var author: String? = nil
  var subject: String? = nil
  var keywords: String? = nil
  var creator: String? = nil
  var producer: String? = nil
  var creation: DateComponents? = nil
  var modified: DateComponents? = nil
  var pdfA: Bool = false
  var rasterDpi: Float = defaultRasterDpi
  var encodingQuality: Int = defaultEncodingQuality

  public init(rasterDpi: Float) {
    self.rasterDpi = rasterDpi
  }

  public init(encodingQuality: Int) {
    self.encodingQuality = encodingQuality
  }

  public init(rasterDpi: Float, encodingQuality: Int) {
    self.rasterDpi = rasterDpi
    self.encodingQuality = encodingQuality
  }
}

public enum ColorSpaceGamut: UInt32 {
  case srgb,
  adobeRgb,
  dcip3D65,
  rec2020
}

public enum ColorSpaceRenderTargetGamma: UInt32 {
  case linear,
  srgb
}

public enum ColorSpaceType: UInt32 {
  case rgb,
  cmyk,
  gray
}

public enum NamedGamma: UInt32 {
  case linear,
  srgb,
  twoDotTwoCurve,
  nonStandard
}

public enum MaskFormat: UInt32 {
  case bw,
  a8,
  threeD,
  argb32,
  lcd16
}

public enum Matrix44TypeMask: UInt32 {
  case identity = 0,
  translate = 0x01,
  scale = 0x02,
  affine = 0x04,
  perspective = 0x08
}

public enum VertexMode: UInt32 {
  case triangles,
  triangleStrip,
  triangleFan

  static func fromC(_ vmode: sk_vertices_vertex_mode_t) -> VertexMode {
    VertexMode(rawValue: vmode.rawValue)!
  }

  func toC() -> sk_vertices_vertex_mode_t {
    sk_vertices_vertex_mode_t(rawValue)
  }
}

public enum ImageCachingHint: UInt32 {
  case allow,
  disallow
}

public enum HighContrastConfigInvertStyle: UInt32 {
  case noInvert,
  invertBrightness,
  invertLightness
}

public struct HighContrastConfig {
  private var fGrayscale: UInt8

  public var invertStyle: HighContrastConfigInvertStyle
  public var contrast: Float

  public static let defaultConfig = HighContrastConfig(
    grayscale: false, invertStyle: .noInvert, contrast: 0.0
  )

  public init(grayscale: Bool, invertStyle: HighContrastConfigInvertStyle, contrast: Float) {
    fGrayscale = grayscale ? 1 : 0
    self.invertStyle = invertStyle
    self.contrast = contrast
  }

  public var grayscale: Bool {
    get {
      fGrayscale != 0
    }
    set {
      fGrayscale = newValue ? 1 : 0
    }
  }

  public var valid: Bool {
    contrast >= -1.0 && contrast <= 1.0
  }
}

public enum BitmapAllocFlags: UInt32 {
  case none,
  zeroPixels
}

public enum PngEncoderFilterFlags: UInt32 {
  case noFilters = 0x00,
  none           = 0x08,
  sub            = 0x10,
  up             = 0x20,
  avg            = 0x40,
  paeth          = 0x80,
  allFilters     = 0xF8  // none | sub | up | avg | paeth
}

public struct PngEncoderOptions {
  var filterFlags: PngEncoderFilterFlags
  var zLibLevel: Int
  var unpremulBehavior: TransferFunctionBehavior = .respect
  // TODO: get and set comments

  public static let defaultOptions = PngEncoderOptions(
    filterFlags: PngEncoderFilterFlags.allFilters,
    zLibLevel: 6
  )

  public init(filterFlags: PngEncoderFilterFlags, zLibLevel: Int) {
    self.filterFlags = filterFlags
    self.zLibLevel = zLibLevel
  }

  public init(filterFlags: PngEncoderFilterFlags, zLibLevel: Int, unpremulBehavior: TransferFunctionBehavior) {
    self.init(filterFlags: filterFlags, zLibLevel: zLibLevel)
    self.unpremulBehavior = unpremulBehavior
  }
}

public enum JpegEncoderDownsample: UInt32 {
  case downsample420,
  downsample422,
  downsample444
}

public enum JpegEncoderAlphaOption: UInt32 {
  case ignore,
  blendOnBlack
}

public struct JpegEncoderOptions {
  var quality: Int
  var downsample: JpegEncoderDownsample
  var alphaOption: JpegEncoderAlphaOption
  var blendBehavior: TransferFunctionBehavior = .respect

  public static let defaultOptions = JpegEncoderOptions(
    quality: 100,
    downsample: .downsample420,
    alphaOption: .ignore
  )

  public init(quality: Int, downsample: JpegEncoderDownsample, alphaOption: JpegEncoderAlphaOption) {
    self.quality = quality
    self.downsample = downsample
    self.alphaOption = alphaOption
  }

  public init(quality: Int, downsample: JpegEncoderDownsample, alphaOption: JpegEncoderAlphaOption, blendBehavior: TransferFunctionBehavior) {
    self.init(quality: quality, downsample: downsample, alphaOption: alphaOption)
    self.blendBehavior = blendBehavior
  }
}

public enum WebpEncoderCompression: UInt32 {
  case lossy,
  lossless
}

public struct WebpEncoderOptions {
  var compression: WebpEncoderCompression
  var quality: Float
  var unpremulBehavior: TransferFunctionBehavior = .respect

  public static let defaultOptions = WebpEncoderOptions(
    compression: .lossy,
    quality: 100
  )

  public init(compression: WebpEncoderCompression, quality: Float) {
    self.compression = compression
    self.quality = quality
  }

  public init(compression: WebpEncoderCompression, quality: Float, unpremulBehavior: TransferFunctionBehavior) {
    self.init(compression: compression, quality: quality)
    self.unpremulBehavior = unpremulBehavior
  }
}

public enum RoundRectType: UInt32 {
  case empty,
  rect,
  oval,
  simple,
  ninePatch,
  complex

  static func fromC(_ rrectType: sk_rrect_type_t) -> RoundRectType {
    RoundRectType(rawValue: rrectType.rawValue)!
  }

  func toC() -> sk_rrect_type_t {
    sk_rrect_type_t(rawValue)
  }
}

public enum RoundRectCorner: UInt32 {
  case upperLeft,
  upperRight,
  lowerRight,
  lowerLeft

  static func fromC(_ rrectCorner: sk_rrect_corner_t) -> RoundRectCorner {
    RoundRectCorner(rawValue: rrectCorner.rawValue)!
  }

  func toC() -> sk_rrect_corner_t {
    sk_rrect_corner_t(rawValue)
  }
}
