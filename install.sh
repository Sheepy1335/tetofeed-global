#!/usr/bin/env bash
# Tetofeed — Global Theme (Plasma 6) — install.
#   ./install.sh          copy everything into your home, change nothing
#   ./install.sh --apply  copy, then switch Plasma (and Kvantum) to Tetofeed
set -euo pipefail
HERE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
D=${XDG_DATA_HOME:-$HOME/.local/share}
C=${XDG_CONFIG_HOME:-$HOME/.config}
put() { rm -rf "$2"; mkdir -p "$(dirname "$2")"; cp -a "$1" "$2"; }

put "$HERE/contents" "$D/plasma/look-and-feel/sheepy.tetofeed/contents"
cp "$HERE/metadata.json" "$D/plasma/look-and-feel/sheepy.tetofeed/"
install -Dm644 "$HERE/extras/colors/Tetofeed.colors" "$D/color-schemes/Tetofeed.colors"
put "$HERE/extras/plasma/Tetofeed"  "$D/plasma/desktoptheme/Tetofeed"
put "$HERE/extras/aurorae/Tetofeed" "$D/aurorae/themes/Tetofeed"
put "$HERE/extras/icons/Tetofeed"   "$D/icons/Tetofeed"
put "$HERE/extras/kvantum/Tetofeed" "$C/Kvantum/Tetofeed"
echo "Installed: global theme, colour scheme, Plasma style, Aurorae, icons, Kvantum."

if [[ ${1:-} == --apply ]]; then
    kwriteconfig6 --file Kvantum/kvantum.kvconfig --group General --key theme Tetofeed
    plasma-apply-lookandfeel -a sheepy.tetofeed
    qdbus6 org.kde.KWin /KWin reconfigure >/dev/null 2>&1 || true
    echo "Applied. Restart apps to pick up the Kvantum style."
else
    echo "Apply: System Settings → Colors & Themes → Global Theme → Tetofeed, or ./install.sh --apply"
fi
