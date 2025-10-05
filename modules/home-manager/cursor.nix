{ pkgs, ... }:
{
  home.pointerCursor = {
    enable = true;
    name = "catppuccin-mocha-dark-cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    x11.enable = true;
    gtk.enable = true;
  };
}

