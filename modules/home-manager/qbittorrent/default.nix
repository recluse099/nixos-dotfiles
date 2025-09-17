{ pkgs, ... }:
{
  home.packages = [ pkgs.qbittorrent ];
  xdg.configFile."qBittorrent/themes/catppuccin-mocha.qbtheme".source = ./catppuccin_mocha.qbtheme;
}



