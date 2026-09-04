# Minimal home-manager config for the office desktop: just the pieces you
# asked for, plus the small amount of theming baseline (cursor/gtk/qt/kvantum)
# niri+noctalia look right with. Nothing from the laptop's big app list
# (home-packages.nix, texlive, thunderbird, discord, etc.).
{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  home.username = "recluse";
  home.homeDirectory = "/home/recluse";
  home.stateVersion = "25.05";
  news.display = "notify";

  imports = [
    # noctalia-shell/default.nix already imports inputs.noctalia.homeModules.default itself
    ../../modules/home-manager/nocatlia-shell/default.nix
    ../../modules/home-manager/nvf/default.nix
    ../../modules/home-manager/shells/zsh/default.nix
    ../../modules/home-manager/librewolf/default.nix
    ../../modules/home-manager/term-emulators/kitty/default.nix
    ../../modules/home-manager/term-emulators/ghostty/default.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/cursor.nix
    ../../modules/home-manager/gtk.nix
    ../../modules/home-manager/qt/default.nix
    ../../modules/home-manager/kvantum/default.nix
  ];

  home.sessionVariables = {
    TERMINAL = lib.getExe pkgs.ghostty;
    SHELL = lib.getExe pkgs.zsh;
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfreePredicate = _: true;
}
