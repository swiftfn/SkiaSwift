// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "CSkiaSwift",
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
