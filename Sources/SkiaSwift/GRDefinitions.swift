import CSkia

public typealias SurfaceOrigin = gr_surfaceorigin_t

public typealias PixelConfig = gr_pixelconfig_t

public typealias Backend = gr_backend_t

public enum GlBackendState: UInt32 {
  case none      = 0,
  renderTarget   = 1,     // 1 << 0
  textureBinding = 2,     // 1 << 1
  view           = 4,     // 1 << 2, scissor and viewport
  blend          = 8,     // 1 << 3
  msaaEnable     = 16,    // 1 << 4
  vertex         = 32,    // 1 << 5
  stencil        = 64,    // 1 << 6
  pixelStore     = 128,   // 1 << 7
  program        = 256,   // 1 << 8
  fixedFunction   = 512,   // 1 << 9
  misc           = 1024,  // 1 << 10
  pathRendering  = 2048,  // 1 << 11
  all            = 0xffff
}

public enum BackendState: UInt32 {
  case none = 0,
  all       = 0xffffffff
}

public typealias GlFramebufferInfo = gr_gl_framebufferinfo_t

public typealias GlTextureInfo = gr_gl_textureinfo_t

extension ColorType {
  public func toGlSizedFormat() -> Int {
    switch (self) {
      case ALPHA_8_SK_COLORTYPE:
        return GlSizedFormat.ALPHA8
      case RGB_565_SK_COLORTYPE:
        return GlSizedFormat.RGB565
      case ARGB_4444_SK_COLORTYPE:
        return GlSizedFormat.RGBA4
      case RGBA_8888_SK_COLORTYPE:
        return GlSizedFormat.RGBA8
      case RGB_888X_SK_COLORTYPE:
        return GlSizedFormat.RGB8
      case BGRA_8888_SK_COLORTYPE:
        return GlSizedFormat.BGRA8
      case RGBA_1010102_SK_COLORTYPE:
        return GlSizedFormat.RGB10_A2
      case GRAY_8_SK_COLORTYPE:
        return GlSizedFormat.LUMINANCE8
      case RGBA_F16_SK_COLORTYPE:
        return GlSizedFormat.RGBA16F
      default:
        return 0
    }
  }

  public func toPixelConfig() -> PixelConfig {
    switch (self) {
      case ALPHA_8_SK_COLORTYPE:
        return ALPHA_8_GR_PIXEL_CONFIG
      case GRAY_8_SK_COLORTYPE:
        return GRAY_8_GR_PIXEL_CONFIG
      case RGB_565_SK_COLORTYPE:
        return RGB_565_GR_PIXEL_CONFIG
      case ARGB_4444_SK_COLORTYPE:
        return RGBA_4444_GR_PIXEL_CONFIG
      case RGBA_8888_SK_COLORTYPE:
        return RGBA_8888_GR_PIXEL_CONFIG
      case RGB_888X_SK_COLORTYPE:
        return RGB_888_GR_PIXEL_CONFIG
      case BGRA_8888_SK_COLORTYPE:
        return BGRA_8888_GR_PIXEL_CONFIG
      case RGBA_1010102_SK_COLORTYPE:
        return RGBA_1010102_GR_PIXEL_CONFIG
      case RGBA_F16_SK_COLORTYPE:
        return RGBA_HALF_GR_PIXEL_CONFIG
      default:
        return UNKNOWN_GR_PIXEL_CONFIG
    }
  }
}

extension PixelConfig {
  public func toGlSizedFormat() -> Int {
    switch (self) {
      case ALPHA_8_GR_PIXEL_CONFIG:
        return GlSizedFormat.ALPHA8
      case GRAY_8_GR_PIXEL_CONFIG:
        return GlSizedFormat.LUMINANCE8
      case RGB_565_GR_PIXEL_CONFIG:
        return GlSizedFormat.RGB565
      case RGBA_4444_GR_PIXEL_CONFIG:
        return GlSizedFormat.RGBA4
      case RGBA_8888_GR_PIXEL_CONFIG:
        return GlSizedFormat.RGBA8
      case RGB_888_GR_PIXEL_CONFIG:
        return GlSizedFormat.RGB8
      case BGRA_8888_GR_PIXEL_CONFIG:
        return GlSizedFormat.BGRA8
      case SRGBA_8888_GR_PIXEL_CONFIG:
        return GlSizedFormat.SRGB8_ALPHA8
      case SBGRA_8888_GR_PIXEL_CONFIG:
        return GlSizedFormat.SRGB8_ALPHA8
      case RGBA_1010102_GR_PIXEL_CONFIG:
        return GlSizedFormat.RGB10_A2
      case RGBA_FLOAT_GR_PIXEL_CONFIG:
        return GlSizedFormat.RGBA32F
      case RG_FLOAT_GR_PIXEL_CONFIG:
        return GlSizedFormat.RG32F
      case ALPHA_HALF_GR_PIXEL_CONFIG:
        return GlSizedFormat.R16F
      case RGBA_HALF_GR_PIXEL_CONFIG:
        return GlSizedFormat.RGBA16F
      default:
        return 0
    }
  }

  public func toColorType() -> ColorType {
    switch (self) {
      case ALPHA_8_GR_PIXEL_CONFIG:
        return ALPHA_8_SK_COLORTYPE
      case GRAY_8_GR_PIXEL_CONFIG:
        return GRAY_8_SK_COLORTYPE
      case RGB_565_GR_PIXEL_CONFIG:
        return RGB_565_SK_COLORTYPE
      case RGBA_4444_GR_PIXEL_CONFIG:
        return ARGB_4444_SK_COLORTYPE
      case RGBA_8888_GR_PIXEL_CONFIG:
        return RGBA_8888_SK_COLORTYPE
      case RGB_888_GR_PIXEL_CONFIG:
        return RGB_888X_SK_COLORTYPE
      case BGRA_8888_GR_PIXEL_CONFIG:
        return BGRA_8888_SK_COLORTYPE
      case SRGBA_8888_GR_PIXEL_CONFIG:
        return RGBA_8888_SK_COLORTYPE
      case SBGRA_8888_GR_PIXEL_CONFIG:
        return BGRA_8888_SK_COLORTYPE
      case RGBA_1010102_GR_PIXEL_CONFIG:
        return RGBA_1010102_SK_COLORTYPE
      case RGBA_HALF_GR_PIXEL_CONFIG:
        return RGBA_F16_SK_COLORTYPE
      default:
        return UNKNOWN_SK_COLORTYPE
    }
  }
}

class GlSizedFormat {
  // Unsized formats
  static let STENCIL_INDEX = 0x1901
  static let DEPTH_COMPONENT = 0x1902
  static let DEPTH_STENCIL = 0x84F9
  static let RED = 0x1903
  static let RED_INTEGER = 0x8D94
  static let GREEN = 0x1904
  static let BLUE = 0x1905
  static let ALPHA = 0x1906
  static let LUMINANCE = 0x1909
  static let LUMINANCE_ALPHA = 0x190A
  static let RG_INTEGER = 0x8228
  static let RGB = 0x1907
  static let RGB_INTEGER = 0x8D98
  static let SRGB = 0x8C40
  static let RGBA = 0x1908
  static let RG = 0x8227
  static let SRGB_ALPHA = 0x8C42
  static let RGBA_INTEGER = 0x8D99
  static let BGRA = 0x80E1

  // Stencil index sized formats
  static let STENCIL_INDEX4 = 0x8D47
  static let STENCIL_INDEX8 = 0x8D48
  static let STENCIL_INDEX16 = 0x8D49

  // Depth component sized formats
  static let DEPTH_COMPONENT16 = 0x81A5

  // Depth stencil sized formats
  static let DEPTH24_STENCIL8 = 0x88F0

  // Red sized formats
  static let R8 = 0x8229
  static let R16 = 0x822A
  static let R16F = 0x822D
  static let R32F = 0x822E

  // Red integer sized formats
  static let R8I = 0x8231
  static let R8UI = 0x8232
  static let R16I = 0x8233
  static let R16UI = 0x8234
  static let R32I = 0x8235
  static let R32UI = 0x8236

  // Luminance sized formats
  static let LUMINANCE8 = 0x8040

  // Alpha sized formats
  static let ALPHA8 = 0x803C
  static let ALPHA16 = 0x803E
  static let ALPHA16F = 0x881C
  static let ALPHA32F = 0x8816

  // Alpha integer sized formats
  static let ALPHA8I = 0x8D90
  static let ALPHA8UI = 0x8D7E
  static let ALPHA16I = 0x8D8A
  static let ALPHA16UI = 0x8D78
  static let ALPHA32I = 0x8D84
  static let ALPHA32UI = 0x8D72

  // RG sized formats
  static let RG8 = 0x822B
  static let RG16 = 0x822C
  //static let R16F = 0x822D
  //static let R32F = 0x822E

  // RG sized integer formats
  static let RG8I = 0x8237
  static let RG8UI = 0x8238
  static let RG16I = 0x8239
  static let RG16UI = 0x823A
  static let RG32I = 0x823B
  static let RG32UI = 0x823C

  // RGB sized formats
  static let RGB5 = 0x8050
  static let RGB565 = 0x8D62
  static let RGB8 = 0x8051
  static let SRGB8 = 0x8C41

  // RGB integer sized formats
  static let RGB8I = 0x8D8F
  static let RGB8UI = 0x8D7D
  static let RGB16I = 0x8D89
  static let RGB16UI = 0x8D77
  static let RGB32I = 0x8D83
  static let RGB32UI = 0x8D71

  // RGBA sized formats
  static let RGBA4 = 0x8056
  static let RGB5_A1 = 0x8057
  static let RGBA8 = 0x8058
  static let RGB10_A2 = 0x8059
  static let SRGB8_ALPHA8 = 0x8C43
  static let RGBA16F = 0x881A
  static let RGBA32F = 0x8814
  static let RG32F = 0x8230

  // RGBA integer sized formats
  static let RGBA8I = 0x8D8E
  static let RGBA8UI = 0x8D7C
  static let RGBA16I = 0x8D88
  static let RGBA16UI = 0x8D76
  static let RGBA32I = 0x8D82
  static let RGBA32UI = 0x8D70

  // BGRA sized formats
  static let BGRA8 = 0x93A1
}
