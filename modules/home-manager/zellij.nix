{ lib, pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      default_shell = lib.getExe pkgs.zsh;
      theme = "catppuccin-macchiato";
      show_startup_gips = false;
    };
  };
}


