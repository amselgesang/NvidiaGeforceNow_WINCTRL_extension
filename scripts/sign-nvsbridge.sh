#!/bin/bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
binary="${2:-"$repo_root/.build/debug/NVSBridge"}"
entitlements="$repo_root/Entitlements/NVSBridge.entitlements"
identity="${1:-${NVSBRIDGE_CODESIGN_IDENTITY:-}}"

if [[ -z "$identity" ]]; then
    cat >&2 <<'EOF'
usage: scripts/sign-nvsbridge.sh SIGNING_IDENTITY [BINARY]

Build first with `swift build`, then pass an identity listed by:
  security find-identity -v -p codesigning

Example:
  scripts/sign-nvsbridge.sh "Developer ID Application: Example (TEAMID)"
EOF
    exit 64
fi

if [[ ! -x "$binary" ]]; then
    echo "NVSBridge executable not found at: $binary" >&2
    echo "Run 'swift build' first." >&2
    exit 66
fi

codesign \
    --force \
    --sign "$identity" \
    --entitlements "$entitlements" \
    "$binary"

codesign --verify --strict --verbose=2 "$binary"
codesign -d --entitlements - "$binary"
