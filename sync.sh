#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
BUILD=false
[[ "${1:-}" == "--build" ]] && BUILD=true

# Taco Tuesday
echo "Syncing taco-tuesday..."
rm -rf "$SCRIPT_DIR/taco-tuesday"
mkdir -p "$SCRIPT_DIR/taco-tuesday"
cp "$ROOT_DIR/taco-tuesday/index.html" "$SCRIPT_DIR/taco-tuesday/"
[ -d "$ROOT_DIR/taco-tuesday/images" ] && cp -r "$ROOT_DIR/taco-tuesday/images" "$SCRIPT_DIR/taco-tuesday/"

# Sisyphus Quest
echo "Syncing sisyphus-quest..."
if [ "$BUILD" = true ]; then
  echo "Building sisyphus-quest..."
  (cd "$ROOT_DIR/sisyphus-quest" && npm install && npx vite build --base=/sisyphus-quest/)
fi
if [ ! -d "$ROOT_DIR/sisyphus-quest/dist" ]; then
  echo "Error: sisyphus-quest/dist/ not found. Run with --build or build manually." >&2
  exit 1
fi
rm -rf "$SCRIPT_DIR/sisyphus-quest"
cp -r "$ROOT_DIR/sisyphus-quest/dist" "$SCRIPT_DIR/sisyphus-quest"

# Patch index.html (idempotent)
echo "Patching index.html..."
sed -i 's|src="../taco-tuesday/index.html"|src="taco-tuesday/index.html"|g' "$SCRIPT_DIR/index.html"
sed -i 's|href="/sisyphus-quest/"|href="sisyphus-quest/"|g' "$SCRIPT_DIR/index.html"

echo "Done."
