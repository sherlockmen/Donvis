#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
APP="$ROOT/build/CodeQuota.app"
BIN="$APP/Contents/MacOS/CodeQuota"
PLIST="$APP/Contents/Info.plist"
ARM="$ROOT/.build/arm64-apple-macosx/release/CodeQuota"
INTEL="$ROOT/.build/x86_64-apple-macosx/release/CodeQuota"

cd "$ROOT"
swift build -c release --arch arm64
swift build -c release --arch x86_64

rm -rf "$APP"
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources"
lipo -create "$ARM" "$INTEL" -output "$BIN"
chmod +x "$BIN"
cp "$ROOT/Resources/AppIcon.icns" "$APP/Contents/Resources/AppIcon.icns"
cp -R "$ROOT/.build/arm64-apple-macosx/release/CodeQuota_CodeQuota.bundle" "$APP/Contents/Resources/CodeQuota_CodeQuota.bundle"

cat > "$PLIST" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleExecutable</key><string>CodeQuota</string>
  <key>CFBundleIdentifier</key><string>com.codequota.app</string>
  <key>CFBundleName</key><string>CodeQuota</string>
  <key>CFBundleDisplayName</key><string>CodeQuota</string>
  <key>CFBundleIconFile</key><string>AppIcon</string>
  <key>CFBundlePackageType</key><string>APPL</string>
  <key>CFBundleShortVersionString</key><string>0.3.0</string>
  <key>CFBundleVersion</key><string>3</string>
  <key>LSMinimumSystemVersion</key><string>13.0</string>
  <key>LSUIElement</key><true/>
</dict>
</plist>
PLIST

codesign --force --deep --sign - "$APP"

echo "Built $APP"
lipo -info "$BIN"
codesign --verify --deep --strict --verbose=2 "$APP"
