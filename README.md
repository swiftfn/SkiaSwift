# SkiaSwift

Swift classes wrapper for [SkiaSharp](https://github.com/mono/SkiaSharp)'s C API

See:
* [SkiaSharp's C API](https://github.com/mono/skia), which is a fork of [Skia](https://skia.org),
  to add more features to the default C API
* [CSkiaSwift](https://github.com/swiftfn/SkiaSwift)

This project uses [Swift Package Manager](https://swift.org/package-manager/):
* https://github.com/apple/swift-package-manager/blob/master/Documentation/Usage.md
* https://github.com/apple/swift-package-manager/blob/master/Documentation/PackageDescription.md
* https://clang.llvm.org/docs/Modules.html

## Build SkiaSharp's fork of Skia

Download [SkiaSharp's fork of Skia](https://github.com/mono/skia),
then see these doc to build:
* https://skia.org/user/download
* https://skia.org/user/build
* https://stackoverflow.com/questions/50228652/how-to-compile-skia-on-windows
* https://github.com/flutter/engine/blob/master/tools/gn

Build static libraries:

```sh
bin/gn gen out/mac --args="is_debug=false is_official_build=true \
skia_use_system_expat=false skia_use_system_libjpeg_turbo=false \
skia_use_system_libpng=false skia_use_system_libwebp=false \
skia_use_system_zlib=false skia_use_system_icu=false \
skia_use_system_harfbuzz=false"

ninja -C out/mac
```

## Build CSkiaSwift for Mac

Create symlinks to the built Skia above (`include/c` and `out/mac` directories are used):

```sh
cd Sources/CSkia/include
ln -s /path/to/skia/include/c

cd Sources/CSkia
ln -s /path/to/skia/out
```

Build:

```sh
swift build
swift build -c release
```

Run:

```sh
swift run Demo
.build/debug/Demo
.build/release/Demo
```

## Generate doc

Install [jazzy](https://github.com/realm/jazzy), then run:

```sh
jazzy --module SkiaSwift
```
