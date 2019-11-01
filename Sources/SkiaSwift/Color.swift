import CSkia

public class Color {
  public static func argb(_ a: UInt32, _ r: UInt32, _ g: UInt32, _ b: UInt32) -> sk_color_t {
    return (((a) << 24) | ((r) << 16) | ((g) << 8) | (b))
  }
}
