{ lib, pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    settings = {
      default_shell = lib.getExe pkgs.zsh;
      theme = "catppuccin-macchiato";
      show_startup_gips = false;
      show_startup_tips = false;
      default_layout = "default";

    };
  };
}


