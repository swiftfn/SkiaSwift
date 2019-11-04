class Utils {
  static let nearlyZero = 1.0 / Float(1 << 12)

  static func nearlyEqual(_ a: Float, _ b: Float, _ tolerance: Float = nearlyZero) -> Bool {
    abs(a - b) <= tolerance
  }
}
