# DankMaterialShell settings, managed the same way as the old noctalia.json:
# live-edited via DMS's own GUI, then captured into this repo via
# ../../../../sync-dms-settings.sh and locked in declaratively here. The
# actual DMS shell process itself is started by niri's spawn-at-startup (see
# ../niri/config.kdl) and installed system-wide via
# modules/nixos-system/extra/dms - this module only takes over management of
# ~/.config/DankMaterialShell/settings.json.
#
# IMPORTANT: once `enable` is flipped to true and this is switched in, the
# live settings.json becomes a read-only symlink into the Nix store - DMS's
# GUI can no longer write to it. Workflow for changing settings is then
# always: tweak via GUI (first set enable = false and switch, or accept that
# GUI changes need re-syncing) -> run sync-dms-settings.sh -> flip/keep
# enable = true -> home-manager switch.
#
# Disabled 2026-10-29: switched the desktop shell back to Noctalia (see
# ../nocatlia-shell). settings.json below is kept up to date (last synced via
# sync-dms-settings.sh) so switching DMS back on later is just flipping this
# back to true and rebuilding - no need to redo the GUI configuration from
# scratch.
{ inputs, ... }:
{
  imports = [ inputs.dms.homeModules.default ];
  programs.dank-material-shell = {
    enable = false;
    systemd.enable = false;
    settings = builtins.fromJSON (builtins.readFile ./settings.json);
  };
}
