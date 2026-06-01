#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
APP="$ROOT/build/CodeQuota.app"
DIST="$ROOT/dist"
VERSION="0.3.0"
ZIP="$DIST/CodeQuota-$VERSION-macOS-universal.zip"
CHECKSUM="$ZIP.sha256"
DMG="$DIST/CodeQuota-$VERSION-macOS-universal.dmg"
DMG_CHECKSUM="$DMG.sha256"
STAGING="$DIST/dmg-root"

"$ROOT/Scripts/build_app.sh"

rm -rf "$DIST"
mkdir -p "$DIST"

ditto -c -k --sequesterRsrc --keepParent "$APP" "$ZIP"
shasum -a 256 "$ZIP" > "$CHECKSUM"
mkdir -p "$STAGING"
cp -R "$APP" "$STAGING/CodeQuota.app"
ln -s /Applications "$STAGING/Applications"
hdiutil create -volname "CodeQuota" -srcfolder "$STAGING" -ov -format UDZO "$DMG" >/dev/null
rm -rf "$STAGING"
shasum -a 256 "$DMG" > "$DMG_CHECKSUM"

echo "Created $ZIP"
echo "Created $CHECKSUM"
echo "Created $DMG"
echo "Created $DMG_CHECKSUM"
shasum -a 256 "$ZIP"
shasum -a 256 "$DMG"
