{ pkgs, lib, ... }:
{
  xdg = {
    portal = {
      enable = true;
      config = {
        niri = {
          default = lib.mkDefault [
            "wlr"
            "gtk"
            "gnome"
          ];
          "org.freedesktop.impl.portal.FileChooser" = "gtk";
        };
        common.default = [
          "wlr"
          "gtk"
          "gnome"
        ];
      };
      wlr.enable = true;
      xdgOpenUsePortal = true;
      extraPortals = builtins.attrValues {
        inherit (pkgs)
          xdg-desktop-portal-gtk
          xdg-desktop-portal-gnome
          ;
        inherit (pkgs.kdePackages)
          xdg-desktop-portal-kde
          ;
      };
    };
  };
}
