{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    config = {
      niri = {
        default = [
          "gnome"
          "gtk"
        ];
        "org.freedesktop.impl.portal.FileChooser" = "gnome";
      };
    };
    extraPortals = builtins.attrValues {
      inherit (pkgs)
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
        ;
    };
  };
}

