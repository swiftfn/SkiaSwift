// import CSkia

// public class Bitmap {
//   private static let UnsupportedColorTypeMessage = "Setting the ColorTable is only supported for bitmaps with ColorTypes of Index8."
// 	private static let UnableToAllocatePixelsMessage = "Unable to allocate pixels for the bitmap."

//   var handle: OpaquePointer

//   init() {
//     handle = sk_bitmap_new()
//   }

//   init(width: Int, height: Int, isOpaque: Bool = false) {
//     self.init(width, height, ImageInfo.platformColorType, isOpaque ? .opaque : .premul)
//   }

//   init(width: Int, height: Int, colorType: ColorType, alphaType: AlphaType) {
//     self.init(info: ImageInfo(width, height, colorType, alphaType))
//   }

//   init(info: ImageInfo) {
//     self.init(info: info, rowBytes: info.RowBytes)
//   }

//   init(info: ImageInfo, rowBytes: Int) {
//     if (!tryAllocPixels(info, rowBytes)) {
//       fatalError(UnableToAllocatePixelsMessage)
//     }
//   }

//   deinit {
//     dispose()
//   }

//   func dispose() {
//     sk_bitmap_destructor(handle)
//   }

//   public func tryAllocPixels(info: ImageInfo) -> Bool {
//     return tryAllocPixels(info, info.RowBytes)
//   }

//   public func tryAllocPixels(info: ImageInfo, rowBytes: Int) -> Bool {
//     var cinfo = ImageInfoNative.fromManaged(&info)
//     return sk_bitmap_try_alloc_pixels(handle, &cinfo, (IntPtr)rowBytes)
//   }

//   public func tryAllocPixels(info: ImageInfo, flags: BitmapAllocFlags) -> Bool {
//     var cinfo = ImageInfoNative.fromManaged(info)
//     return sk_bitmap_try_alloc_pixels_with_flags(handle, &cinfo, flags)
//   }

//   public func reset() {
//     sk_bitmap_reset(handle)
//   }

//   public func setImmutable() {
//     sk_bitmap_set_immutable(handle)
//   }

//   public func erase(color: Color) {
//     sk_bitmap_erase(handle, color)
//   }

//   public func erase(color: Color, rect: RectI) {
//     sk_bitmap_erase_rect(handle, color, &rect)
//   }

//   public func getAddr8(x: Int, y: Int) -> UInt8 {
//     return sk_bitmap_get_addr_8(handle, x, y)
//   }

//   public func GetAddr16(x: Int, y: Int) -> UInt16 {
//     return sk_bitmap_get_addr_16(handle, x, y)
//   }

//   public func getAddr32(x: Int, y: Int) -> UInt32 {
//     return sk_bitmap_get_addr_32(handle, x, y)
//   }

//   public func getAddr(x: Int, y: Int) -> OpaquePointer {
//     return sk_bitmap_get_addr(handle, x, y)
//   }

//   public func getPixel(x: Int, y: Int) -> Color {
//     return sk_bitmap_get_pixel_color(handle, x, y)
//   }

//   public func setPixel(x: Int, y: Int, color: Color) {
//     sk_bitmap_set_pixel_color(handle, x, y, color)
//   }

//   public func canCopyTo(colorType: ColorType) -> Bool {
//     var srcCT = self.colorType;

//     if (srcCT == .unknown) {
//       return false
//     }

//     if (srcCT == .alpha8 && colorType != .alpha8) {
//       return false  // Can't convert from alpha to non-alpha
//     }

//     var sameConfigs = (srcCT == colorType)
//     switch (colorType) {
//       case .alpha8:
//       case .rgb565:
//       case .rgba8888:
//       case .bgra8888:
//       case .rgb888x:
//       case .rgba1010102:
//       case .rgb101010x:
//       case .rgbaF16:
//         break;
//       case .gray8:
//         if (!sameConfigs) {
//           return false
//         }
//         break;
//       case .argb4444:
//         return sameConfigs || srcCT == ImageInfo.platformColorType
//       default:
//         return false
//     }
//     return true
//   }

//   public func copy() -> Bitmap {
//     return copy(colorType)
//   }

//   public func copy(colorType: ColorType) -> Bitmap? {
//     var destination = Bitmap()
//     if (!copyTo(destination, colorType)) {
//       destination.dispose()
//       destination = nil
//     }
//     return destination
//   }

//   public func copyTo(destination: Bitmap) -> Bool {
//     return copyTo(destination, colorType)
//   }

//   public bool copyTo(destination: Bitmap, colorType: ColorType) -> Bool {
//     if (!canCopyTo(colorType)) {
//       return false
//     }

//     var srcPM = peekPixels()
//     if (srcPM == nil) {
//       return false
//     }

//     var dstInfo = srcPM.info.withColorType(colorType)
//     switch (colorType) {
//       case .rgb565:
//         // copyTo() is not strict on alpha type. Here we set the src to opaque to allow
//         // the call to readPixels() to succeed and preserve this lenient behavior.
//         if (srcPM.alphaType != .opaque) {
//           srcPM = srcPM.withAlphaType(.opaque)
//         }
//         dstInfo.alphaType = .opaque
//         break
//       case .rgbaF16:
//         // The caller does not have an opportunity to pass a dst color space.
//         // Assume that they want linear sRGB.
//         dstInfo.colorSpace = ColorSpace.createSrgbLinear()
//         if (srcPM.colorSpace == nil) {
//           // We can't do a sane conversion to F16 without a dst color space.
//           // Guess sRGB in this case.
//           srcPM = srcPM.withColorSpace(ColorSpace.createSrgb())
//         }
//         break
//     }

//     var tmpDst = Bitmap()
//     if (!tmpDst.tryAllocPixels(dstInfo)) {
//       return false
//     }

//     var dstPM = tmpDst.peekPixels()
//     if (dstPM == nil) {
//       return false
//     }

//     // We can't do a sane conversion from F16 without a src color space. Guess sRGB in this case.
//     if (srcPM.colorType == .rgbaF16 && dstPM.colorSpace == nil) {
//       dstPM = dstPM.withColorSpace(ColorSpace.createSrgb ))
//     }

//     // ReadPixels does not yet support color spaces with parametric transfer functions. This
//     // works around that restriction when the color spaces are equal.
//     if (colorType != .rgbaF16 && srcPM.colorType != .rgbaF16 && dstPM.colorSpace == srcPM.ColorSpace) {
//       dstPM = dstPM.withColorSpace(nil)
//       srcPM = srcPM.withColorSpace(nil)
//     }

//     if (!srcPM.readPixels(dstPM)) {
//       return false
//     }

//     destination.swap(tmpDst)
//     return true
//   }
// }
