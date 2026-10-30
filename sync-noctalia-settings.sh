#!/usr/bin/env bash
# Captures the live, GUI-edited Noctalia (v5) settings into this repo so they
# can be managed declaratively by
# modules/home-manager/minimal/nocatlia-shell/default.nix.
#
# In v5 the home-manager module writes ~/.config/noctalia/config.toml (a
# read-only symlink into the Nix store), while the in-shell settings UI
# persists its changes as overrides in ~/.local/state/noctalia/settings.toml,
# which is layered on top at load time. `noctalia config export` prints the
# merged result of both (user config only, no built-in defaults), which is
# exactly what we want to commit back as noctalia_config.toml.
#
# Run this after configuring Noctalia via its own settings UI, then run
# `home-manager switch` (enable is already true in that module).
set -euo pipefail

DEST="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/modules/home-manager/minimal/nocatlia-shell/noctalia_config.toml"

TMP="$(mktemp --suffix=.toml)"
trap 'rm -f "$TMP"' EXIT
noctalia config export merged > "$TMP"
if [ ! -s "$TMP" ]; then
    echo "noctalia config export produced no output - aborting." >&2
    exit 1
fi
# Same check programs.noctalia.checkConfig runs at build time, so a bad
# export fails here instead of during home-manager switch.
noctalia config validate "$TMP" > /dev/null
mv "$TMP" "$DEST"
trap - EXIT

echo "Exported merged Noctalia config -> $DEST"
echo "Next: run home-manager switch to lock it in."
