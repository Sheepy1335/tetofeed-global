#!/usr/bin/env bash
# Tetofeed — Global Theme (Plasma 6) — install
set -euo pipefail
HERE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
DST=${XDG_DATA_HOME:-$HOME/.local/share}/plasma/look-and-feel/sheepy.tetofeed
rm -rf "$DST"; mkdir -p "$DST"
cp -r "$HERE"/{metadata.json,contents} "$DST"/
echo "Installed. Apply: plasma-apply-lookandfeel -a sheepy.tetofeed  (splash only: kwriteconfig6 --file ksplashrc --group KSplash --key Theme sheepy.tetofeed)"
