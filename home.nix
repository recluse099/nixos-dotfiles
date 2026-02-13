{
  pkgs,
  inputs,
  lib,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "recluse";
  home.homeDirectory = "/home/recluse";

  home.stateVersion = "25.05"; # Please read the comment before changing.
  news.display = "notify";
  imports = [
    inputs.zen-browser.homeModules.twilight
    ./modules/home-manager
  ];
  # for custom packages(not derived from nixpkgs)
  home.packages =  [
    (pkgs.callPackage ./custom-packages/weathr/weathr.nix {})
  ];

  home.file = {
    ".config/weathr/config.toml".source = ./custom-packages/weathr/weathr.toml;
  };

  home.sessionVariables = {
    TERMINAL = lib.getExe pkgs.ghostty;
    LAUNCHER = /home/recluse/.nix-profile/bin/fuzzel;
    SHELL = lib.getExe pkgs.zsh;
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    fastfetch.enable = true;
    wlogout.enable = true;
  };
  services.network-manager-applet.enable = true;
  nixpkgs.config.allowUnfreePredicate = _: true;
}
