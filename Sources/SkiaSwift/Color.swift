import CSkia

// These are both UInt32
public typealias PMColor = sk_pmcolor_t
public typealias Color = sk_color_t

public extension PMColor {
  static func premultiply(color: Color) -> PMColor {
    return sk_color_premultiply(color)
  }

  static func unpremultiply(pmcolor: PMColor) -> Color {
    return sk_color_unpremultiply(pmcolor)
  }

  static func premultiply(colors: [Color]) -> [PMColor] {
    var pmcolors = [PMColor](repeating: 0, count: colors.count)
    sk_color_premultiply_array(colors, Int32(colors.count), &pmcolors)
    return pmcolors
  }

  static func unpremultiply(pmcolors: [PMColor]) -> [Color] {
    var colors = [Color](repeating: 0, count: pmcolors.count)
    sk_color_unpremultiply_array(pmcolors, Int32(pmcolors.count), &colors)
    return colors
  }

  var pmAlpha: UInt8 {
    get {
      return UInt8(self >> ImageInfo.platformColorShift.a & 0xff)
    }
  }

  var pmRed: UInt8 {
    get {
      return UInt8(self >> ImageInfo.platformColorShift.r & 0xff)
    }
  }

  var pmGreen: UInt8 {
    get {
      return UInt8(self >> ImageInfo.platformColorShift.g & 0xff)
    }
  }

  var pmBlue: UInt8 {
    get {
      return UInt8(self >> ImageInfo.platformColorShift.b & 0xff)
    }
  }
}

public extension Color {
  private static let EPSILON: Float = 0.001

  static func fromHsl(h: Float, s: Float, l: Float, a: UInt8 = 255) -> Color {
    // Convert from percentages
    let hp = h / 360
    let sp = s / 100
    let lp = l / 100

    // RGB results from 0 to 255
    var r = lp * 255
    var g = lp * 255
    var b = lp * 255

    // HSL from 0 to 1
    if abs(sp) > Color.EPSILON {
      var v2: Float
      if lp < 0.5 {
        v2 = lp * (1 + sp)
      } else {
        v2 = (lp + sp) - (sp * lp)
      }

      let v1 = 2 * lp - v2

      r = 255 * Color.hueToRgb(v1, v2, hp + (1.0 / 3))
      g = 255 * Color.hueToRgb(v1, v2, hp)
      b = 255 * Color.hueToRgb(v1, v2, hp - (1.0 / 3))
    }

    return Color(r: UInt8(r), g: UInt8(g), b: UInt8(b), a: a)
  }

  private static func hueToRgb(_ v1: Float, _ v2: Float, _ h: Float) -> Float {
    var vH = h

    if vH < 0 {
      vH += 1
    }
    if vH > 1 {
      vH -= 1
    }

    if 6 * vH < 1 {
      return v1 + (v2 - v1) * 6 * vH
    }
    if 2 * vH < 1 {
      return v2
    }
    if 3 * vH < 2 {
      return v1 + (v2 - v1) * ((2.0 / 3) - vH) * 6
    }
    return v1
  }

  static func fromHsv(h: Float, s: Float, v: Float, a: UInt8 = 255) -> Color {
    // Convert from percentages
    var hp = h / 360
    let sp = s / 100
    let vp = v / 100

    // RGB results from 0 to 255
    var r = vp
    var g = vp
    var b = vp

    // HSL from 0 to 1
    if abs(sp) > Color.EPSILON {
      hp = hp * 6
      if abs(hp - 6) < Color.EPSILON {
        hp = 0  // H must be < 1
      }

      let hInt = Int(hp)
      let v1 = vp * (1 - sp)
      let v2 = vp * (1 - sp * (hp - Float(hInt)))
      let v3 = vp * (1 - sp * (1 - (hp - Float(hInt))))

      if hInt == 0 {
        r = vp
        g = v3
        b = v1
      } else if hInt == 1 {
        r = v2
        g = vp
        b = v1
      } else if hInt == 2 {
        r = v1
        g = vp
        b = v3
      } else if hInt == 3 {
        r = v1
        g = v2
        b = vp
      } else if hInt == 4 {
        r = v3
        g = v1
        b = vp
      } else {
        r = vp
        g = v1
        b = v2
      }
    }

    // RGB results from 0 to 255
    r = r * 255
    g = g * 255
    b = b * 255

    return Color(r: UInt8(r), g: UInt8(g), b: UInt8(b), a: a)
  }

  init(r: UInt8, g: UInt8, b: UInt8, a: UInt8 = 255) {
    self = UInt32(a) << 24 | UInt32(r) << 16 | UInt32(g) << 8 | UInt32(b)
  }

  var alpha: UInt8 {
    get {
      return UInt8(self >> 24 & 0xff)
    }
  }

  var red: UInt8 {
    get {
      return UInt8(self >> 16 & 0xff)
    }
  }

  var green: UInt8 {
    get {
      return UInt8(self >> 8 & 0xff)
    }
  }

  var blue: UInt8 {
    get {
      return UInt8(self & 0xff)
    }
  }

  var hue: Float {
    get {
      let hsv = toHsv()
      return hsv.0
    }
  }

  func withRed(_ red: UInt8) -> Color {
    return Color(r: red, g: green, b: blue, a: alpha)
  }

  func withGreen(_ green: UInt8) -> Color {
    return Color(r: red, g: green, b: blue, a: alpha)
  }

  func withBlue(_ blue: UInt8) -> Color {
    return Color(r: red, g: green, b: blue, a: alpha)
  }

  func withAlpha(_ alpha: UInt8) -> Color {
    return Color(r: red, g: green, b: blue, a: alpha)
  }

  static func argb(_ a: UInt32, _ r: UInt32, _ g: UInt32, _ b: UInt32) -> sk_color_t {
    return (((a) << 24) | ((r) << 16) | ((g) << 8) | (b))
  }

  func toHsl() -> (Float, Float, Float) {
    var h: Float
    var s: Float
    var l: Float

    // RGB from 0 to 255
    let r = Float(red) / 255.0
    let g = Float(green) / 255.0
    let b = Float(blue) / 255.0

    let mn = Swift.min(r, g, b)
    let mx = Swift.max(r, g, b)
    let delta = mx - mn

    // Default to a gray, no chroma...
    h = 0
    s = 0
    l = (mx + mn) / 2

    // Chromatic data...
    if abs(delta) > Color.EPSILON {
      if l < 0.5 {
        s = delta / (mx + mn)
      } else {
        s = delta / (2 - mx - mn)
      }

      let deltaR = (((mx - r) / 6) + (delta / 2)) / delta
      let deltaG = (((mx - g) / 6) + (delta / 2)) / delta
      let deltaB = (((mx - b) / 6) + (delta / 2)) / delta

      if abs(r - mx) < Color.EPSILON {  // r == max
        h = deltaB - deltaG
      } else if abs(g - mx) < Color.EPSILON {  // g == max
        h = (1.0 / 3) + deltaR - deltaB
      } else {  // b == max
        h = (2.0 / 3) + deltaG - deltaR
      }

      if h < 0 {
        h += 1
      }
      if h > 1 {
        h -= 1
      }
    }

    // Convert to percentages
    h = h * 360
    s = s * 100
    l = l * 100

    return (h, s, l)
  }

  func toHsv() -> (Float, Float, Float) {
    var h: Float
    var s: Float
    var v: Float

    // RGB from 0 to 255
    let r = Float(red) / 255
    let g = Float(green) / 255
    let b = Float(blue) / 255

    let mn = Swift.min(r, g, b)
    let mx = Swift.max(r, g, b)
    let delta = mx - mn

    // Default to a gray, no chroma...
    h = 0
    s = 0
    v = mx

    // Chromatic data...
    if abs(delta) > Color.EPSILON {
      s = delta / mx

      let deltaR = (((mx - r) / 6) + (delta / 2)) / delta
      let deltaG = (((mx - g) / 6) + (delta / 2)) / delta
      let deltaB = (((mx - b) / 6) + (delta / 2)) / delta

      if abs(r - mx) < Color.EPSILON {  // r == max
        h = deltaB - deltaG
      } else if abs(g - mx) < Color.EPSILON {  // g == max
        h = (1.0 / 3) + deltaR - deltaB
      } else {  // b == max
        h = (2.0 / 3) + deltaG - deltaR
      }

      if h < 0 {
        h += 1
      }
      if h > 1 {
        h -= 1
      }
    }

    // Convert to percentages
    h = h * 360
    s = s * 100
    v = v * 100

    return (h, s, v)
  }

  // TODO
  // Convert TryParse(string hexString, out SKColor color)
}
