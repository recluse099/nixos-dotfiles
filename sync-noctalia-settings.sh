#!/usr/bin/env bash
# Captures the live, GUI-edited Noctalia settings into this repo so they can
# be managed declaratively by
# modules/home-manager/minimal/nocatlia-shell/default.nix.
#
# Once noctalia.json is managed by home-manager, it's a read-only symlink
# into the Nix store - Noctalia's own FileView save path checks
# QFileInfo::isWritable() before writing (see quickshell's fileview.cpp) and
# silently aborts the write with PermissionDenied against a read-only
# target, same limitation as DMS. So reading the on-disk file would miss
# anything changed via the GUI since the last switch. Instead, this uses
# Noctalia's own IPC export of its live in-memory state
# (`noctalia-shell ipc call state all`), which reflects the current GUI
# state whether or not it was ever persisted to disk, and already matches
# noctalia.json's {settings, state} top-level structure exactly.
#
# Run this after configuring Noctalia via its own settings UI, then run
# `home-manager switch` (enable is already true in that module).
set -euo pipefail

DEST="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/modules/home-manager/minimal/nocatlia-shell/noctalia.json"

if ! pgrep -f "noctalia-shell" > /dev/null && ! pgrep -f "quickshell.*noctalia" > /dev/null; then
    echo "Noctalia doesn't appear to be running - start it first so there's live settings to export." >&2
    exit 1
fi

TMP="$(mktemp)"
trap 'rm -f "$TMP"' EXIT
noctalia-shell ipc call state all > "$TMP"
python3 -c "
import json
d = json.load(open('$TMP'))
assert 'settings' in d, 'Export is missing the settings key - unexpected shape, aborting.'
"
mv "$TMP" "$DEST"
trap - EXIT

echo "Exported live Noctalia settings -> $DEST"
echo "Next: run home-manager switch to lock it in."
