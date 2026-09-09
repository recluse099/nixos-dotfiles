# Laptop NixOS config. hosts/laptop and hosts/desktop are symmetric
# siblings, each importing only from the shared ../../modules/ tree.
{ config, pkgs, lib, self, ... }:

{
  imports = [
    ../../modules/nixos-system/minimal
    ../../modules/nixos-system/extra
    ../../modules/nixos-system/hardware-configuration.nix
  ];

  networking.hostName = lib.mkForce "laptop";

  services.fwupd.enable = true;

  # Disable the X11 windowing system.
  services.xserver.enable = false;

  # Enable the GNOME Desktop Environment.
  services.displayManager = {
    dms-greeter = {
      enable = false;
      compositor.name = "niri";
    };
  };
  # services.desktopManager.gnome.enable = true;
  # services.displayManager.gdm.wayland = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
