{inputs, ...}: let
  system = "x86_64-linux";
  pkgs-new = inputs.nixpkgs-quick-update.legacyPackages.${system};
in {
  home.packages = with pkgs-new; [
    signal-desktop
  ];
}
