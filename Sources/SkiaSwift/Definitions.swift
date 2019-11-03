import CSkia
import Foundation

public typealias CodecResult = sk_codec_result_t

public typealias EncodedOrigin = sk_encodedorigin_t

public typealias EncodedImageFormat = sk_encoded_image_format_t

public enum FontStyleWeight: Int {
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

public enum FontStyleWidth: Int {
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

public typealias FontStyleSlant = sk_font_style_slant_t

public typealias PointMode = sk_point_mode_t

public typealias pathDirection = sk_path_direction_t

public typealias PathArcSize = sk_path_arc_size_t

public typealias PathFillType = sk_path_filltype_t

public typealias PathSegmentMask = sk_path_segment_mask_t

public typealias ColorType = sk_colortype_t

public typealias AlphaType = sk_alphatype_t

public typealias ShaderTileMode = sk_shader_tilemode_t

public typealias BlurStyle = sk_blurstyle_t

public typealias BlendMode = sk_blendmode_t

public typealias PixelGeometry = sk_pixelgeometry_t

extension PixelGeometry {
  public static func isBgr(pg: PixelGeometry) -> Bool {
    return pg == BGR_H_SK_PIXELGEOMETRY || pg == BGR_V_SK_PIXELGEOMETRY
  }

  public static func isRgb(pg: PixelGeometry) -> Bool {
    return pg == RGB_H_SK_PIXELGEOMETRY || pg == RGB_V_SK_PIXELGEOMETRY
  }

  public static func isVertical(pg: PixelGeometry) -> Bool {
    return pg == BGR_V_SK_PIXELGEOMETRY || pg == RGB_V_SK_PIXELGEOMETRY
  }

  public static func isHorizontal(pg: PixelGeometry) -> Bool {
    return pg == BGR_H_SK_PIXELGEOMETRY || pg == RGB_H_SK_PIXELGEOMETRY
  }
}

public typealias SurfacePropsFlags = sk_surfaceprops_flags_t

public typealias Encoding = sk_encoding_t

public typealias StrokeCap = sk_stroke_cap_t

public typealias StrokeJoin = sk_stroke_join_t

public typealias TextAlign = sk_text_align_t

public typealias TextEncoding = sk_text_encoding_t

public typealias FilterQuality = sk_filter_quality_t

public typealias CropRectFlags = sk_crop_rect_flags_t

public typealias DropShadowImageFilterShadowMode = sk_drop_shadow_image_filter_shadow_mode_t

public typealias DisplacementMapEffectChannelSelectorType = sk_displacement_map_effect_channel_selector_type_t

public typealias MatrixConvolutionTileMode = sk_matrix_convolution_tilemode_t

public typealias PaintStyle = sk_paint_style_t

public typealias PaintHinting = sk_paint_hinting_t

public typealias RegionOperation = sk_region_op_t

public typealias ClipOperation = sk_clipop_t

public typealias CodecZeroInitialized = sk_codec_zero_initialized_t

public typealias CodecScanlineOrder = sk_codec_scanline_order_t

public typealias TransferFunctionBehavior = sk_transfer_function_behavior_t

struct CodecOptionsInternal {
  var fZeroInitialized: ZeroInitialized
  var fSubset: RectI
  var fFrameIndex: Int
  var fPriorFrame: Int
  var fPremulBehavior: TransferFunctionBehavior
}

public struct CodecOptions {
  public static let defaultOptions = CodecOptions(zeroInitialized: .no)

  public var zeroInitialized: ZeroInitialized = .no
  public var subset: RectI? = nil
  public var frameIndex: Int = 0
  public var priorFrame: Int = -1
  public var premulBehavior: TransferFunctionBehavior = .respect

  public init(zeroInitialized: ZeroInitialized) {
    self.zeroInitialized = zeroInitialized
  }

  public init(zeroInitialized: ZeroInitialized, subset: RectI) {
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
    get {
      return subset != nil
    }
  }
}

public typealias CodecAnimationDisposalMethod = sk_codecanimation_disposalmethod_t

public typealias CodecFrameInfo = sk_codec_frameinfo_t

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
    return getIfValid(underlineThickness, FontMetrics.flagsUnderlineThicknessIsValid)
  }

  public func getUnderlinePosition() -> Float? {
    return getIfValid(underlinePosition, FontMetrics.flagsUnderlinePositionIsValid)
  }

  public func getStrikeoutThickness() -> Float? {
    return getIfValid(strikeoutThickness, FontMetrics.flagsStrikeoutThicknessIsValid)
  }

  public func getStrikeoutPosition() -> Float? {
    return getIfValid(strikeoutPosition, FontMetrics.flagsStrikeoutPositionIsValid)
  }

  private func getIfValid(_ value: Float, _ flag: UInt) -> Float? {
    return (flags & flag) == flag ? value : nil
  }
}

public typealias PathOp = sk_pathop_t

public typealias PathConvexity = sk_path_convexity_t

public typealias LatticeRectType = sk_lattice_recttype_t

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

public enum ColorSpaceGamut {
  case srgb,
  adobeRgb,
  dcip3D65,
  rec2020
}

public enum ColorSpaceRenderTargetGamma {
  case linear,
  srgb
}

public enum ColorSpaceType {
  case rgb,
  cmyk,
  gray
}

public enum NamedGamma {
  case linear,
  srgb,
  twoDotTwoCurve,
  nonStandard
}

public enum MaskFormat {
  case bw,
  a8,
  threeD,
  argb32,
  lcd16
}

public enum Matrix44TypeMask: Int {
  case identity = 0,
  translate = 0x01,
  scale = 0x02,
  affine = 0x04,
  perspective = 0x08
}

public enum VertexMode {
  case triangles,
  triangleStrip,
  triangleFan
}

public enum ImageCachingHint {
  case allow,
  disallow
}

public enum HighContrastConfigInvertStyle {
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
      return fGrayscale != 0
    }
    set(value) {
      fGrayscale = value ? 1 : 0
    }
  }

  public var valid: Bool {
    get {
      return contrast >= -1.0 && contrast <= 1.0
    }
  }
}

public enum BitmapAllocFlags: Int {
  case none,
  zeroPixels
}

public enum PngEncoderFilterFlags: Int {
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

public enum JpegEncoderDownsample {
  case downsample420,
  downsample422,
  downsample444
}

public enum JpegEncoderAlphaOption {
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

public enum WebpEncoderCompression {
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

public enum RoundRectType {
  case empty,
  rect,
  oval,
  simple,
  ninePatch,
  complex
}

public enum RoundRectCorner {
  case upperLeft,
  upperRight,
  lowerRight,
  lowerLeft
}
