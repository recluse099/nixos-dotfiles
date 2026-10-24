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
# `enable` is flipped to true below, but settings.json is still the {}
# placeholder - DO NOT run `home-manager switch` until sync-dms-settings.sh
# has populated settings.json with real, GUI-configured content (after
# logging into the DMS session and customizing it). Switching with the
# placeholder still in place will symlink settings.json to {} and lock DMS's
# GUI out of writing its own settings.
{ inputs, ... }:
{
  imports = [ inputs.dms.homeModules.default ];
  programs.dank-material-shell = {
    enable = true;
    systemd.enable = false;
    settings = builtins.fromJSON (builtins.readFile ./settings.json);
  };
}
