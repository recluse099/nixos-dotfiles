{ pkgs, ... }:
{
  home.pointerCursor = {
    enable = true;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    # x11.enable = true;
    gtk.enable = true;
  };
}

