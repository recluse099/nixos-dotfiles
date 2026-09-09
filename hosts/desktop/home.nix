# Minimal home-manager config for the office desktop: just
# modules/home-manager/minimal (nvf, noctalia-shell, zsh, librewolf, kitty,
# ghostty, git, plus cursor/gtk/qt/kvantum theming baseline). Nothing from
# modules/home-manager/extra (the laptop's big app list - texlive,
# thunderbird, discord, etc.).
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

  imports = [ ../../modules/home-manager/minimal ];

  home.sessionVariables = {
    TERMINAL = lib.getExe pkgs.ghostty;
    SHELL = lib.getExe pkgs.zsh;
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfreePredicate = _: true;
}
