{inputs, pkgs, ...}: let
  pkgs-new = inputs.nixpkgs-quick-update.legacyPackages.${pkgs.system};
in {
  home.packages = with pkgs-new; [
    signal-desktop
  ];
}
