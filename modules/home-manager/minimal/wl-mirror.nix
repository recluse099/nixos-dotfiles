{ pkgs, ... }:
{
  # niri has no built-in output-mirroring, so this fullscreen-mirrors the
  # laptop panel onto the projector via the wlr-screencopy protocol
  # (captures the whole output's compositor buffer, unaffected by window
  # focus - see the Mod+P/Mod+Shift+P binds in niri/config.kdl).
  home.packages = [ pkgs.wl-mirror ];
}
