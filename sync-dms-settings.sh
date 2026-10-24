#!/usr/bin/env bash
# Captures the live, GUI-edited DankMaterialShell settings into this repo so
# they can be managed declaratively by
# modules/home-manager/minimal/dms-shell/default.nix.
#
# Once settings.json is managed by home-manager, it's a read-only symlink
# into the Nix store - DMS detects this and will NOT write GUI changes back
# to disk (confirmed: https://duxlabs.dev/docs/dms/nixos-flake). So reading
# the on-disk file would miss anything changed via the GUI since the last
# switch. Instead, this uses DMS's own documented export of its live
# in-memory settings (`dms ipc call settings dump`), which reflects the
# current GUI state whether or not it was ever persisted to disk.
#
# Run this after configuring DMS via its own settings UI, then run
# `home-manager switch` (enable is already true in that module).
set -euo pipefail

DEST="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/modules/home-manager/minimal/dms-shell/settings.json"

if ! pgrep -f "dms run" > /dev/null; then
    echo "DMS doesn't appear to be running - start it first so there's live settings to export." >&2
    exit 1
fi

TMP="$(mktemp)"
trap 'rm -f "$TMP"' EXIT
dms ipc call settings dump > "$TMP"
python3 -c "import json; json.load(open('$TMP'))" || {
    echo "Export did not produce valid JSON - aborting, $DEST left untouched." >&2
    exit 1
}
mv "$TMP" "$DEST"
trap - EXIT

echo "Exported live DMS settings -> $DEST"
echo "Next: run home-manager switch to lock it in."
