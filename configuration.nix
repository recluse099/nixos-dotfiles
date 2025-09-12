{ config, pkgs, self, ... }:

{
  imports =
    [
      ./modules/nixos-system
    ];

  services.fwupd.enable = true;

  # Disable the X11 windowing system.
  services.xserver.enable = false;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.wayland = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
}
