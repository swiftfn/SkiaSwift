import CSkia

public class Vertices {
  public static func createCopy(
    vmode: VertexMode,
    positions: [Point],
    colors: [Color]
  ) -> Vertices {
    createCopy(vmode: vmode, positions: positions, texs: nil, colors: colors, indices: nil)
  }

  public static func createCopy(
    vmode: VertexMode,
    positions: [Point],
    texs: [Point],
    colors: [Color]
  ) -> Vertices {
    createCopy(vmode: vmode, positions: positions, texs: texs, colors: colors, indices: nil)
  }

  public static func createCopy(
    vmode: VertexMode,
    positions: [Point],
    texs: [Point]?,
    colors: [Color]?,
    indices: [UInt16]?
  ) -> Vertices {
    if (texs != nil && positions.count != texs!.count) {
      fatalError("The number of texture coordinates must match the number of vertices.")
    }

    if (colors != nil && positions.count != colors!.count) {
      fatalError("The number of colors must match the number of vertices.")
    }

    let vertexCount = Int32(positions.count)
    let indexCount = Int32(indices?.count ?? 0)

    let handle = sk_vertices_make_copy(vmode.toC(), vertexCount, positions, texs, colors, indexCount, indices)
    return Vertices(handle!)
  }

  var handle: OpaquePointer

  init(_ handle: OpaquePointer) {
    self.handle = handle
  }

  deinit {
    sk_vertices_unref(handle)
  }
}
