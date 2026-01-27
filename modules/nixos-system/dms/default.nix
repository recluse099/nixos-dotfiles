{ inputs, pkgs, ... }:
let
  quickshell-pkg = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
  dms = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  programs.dms-shell = {
    enable = true;
    package = dms;
    systemd.enable = true;
    enableSystemMonitoring = true;
    quickshell.package = quickshell-pkg;
  };
}
