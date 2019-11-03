// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "SkiaSwift",
    products: [
        .library(name: "SkiaSwift", targets: ["SkiaSwift"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CSkia",
            dependencies: [],
            linkerSettings: [
                .linkedLibrary("skia"),
                .unsafeFlags(["-LSources/CSkia/out/mac"])
            ]),
        .target(
            name: "SkiaSwift",
            dependencies: ["CSkia"]),
        .target(
            name: "Demo",
            dependencies: ["SkiaSwift"])
    ],
    cxxLanguageStandard: .cxx14
)
