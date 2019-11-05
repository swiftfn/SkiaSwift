import CSkia

public struct Swizzle {
  public static func swapRedBlue(pixels: inout [UInt32]) {
    var src = pixels
    sk_swizzle_swap_rb(&pixels, &src, Int32(pixels.count))
  }

  public static func swapRedBlue(dst: inout [UInt32], src: inout [UInt32]) {
    if dst.count != src.count {
      fatalError("dst and src must have the same length")
    }
    sk_swizzle_swap_rb(&dst, &src, Int32(dst.count))
  }
}
