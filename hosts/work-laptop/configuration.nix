# Work laptop NixOS config. Sibling of hosts/laptop and hosts/desktop,
# importing only from the shared ../../modules/ tree.
{ config, pkgs, lib, self, ... }:

{
  imports = [
    # Generate this on the real machine and drop it here, e.g.:
    #   sudo nixos-generate-config --show-hardware-config > hosts/work-laptop/hardware-configuration.nix
    ./hardware-configuration.nix

    ../../modules/nixos-system/minimal
    ../../modules/nixos-system/extra
  ];

  networking.hostName = lib.mkForce "work-laptop";

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
  system.stateVersion = "25.11";
}
