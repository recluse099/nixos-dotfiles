{ inputs, pkgs, ... }:
let
  quickshell-pkg = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
  dms = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  programs.dux-shell = {
    enable = false;
    package = dms;
    systemd.enable = false;
    quickshell.package = quickshell-pkg;
  };
}
