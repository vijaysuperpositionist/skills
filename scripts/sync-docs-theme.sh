#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$ROOT/node_modules/@utopia-studio-design/design-system/src/themes"
DEST="$ROOT/docs/assets"
mkdir -p "$DEST/fonts" "$DEST/css"
cp "$SRC/fonts/"*.ttf "$DEST/fonts/"
python3 - "$ROOT" <<'PY'
from pathlib import Path
import sys
root = Path(sys.argv[1])
src = root / "node_modules/@utopia-studio-design/design-system/src/themes/utopia-default.css"
out = root / "docs/assets/css/utopia-default.css"
text = src.read_text().replace('url("./fonts/', 'url("../fonts/')
out.write_text(text)
print(f"Synced theme → {out}")
PY
