# Work laptop NixOS config. Sibling of hosts/laptop and hosts/desktop,
# importing only from the shared ../../modules/ tree.
#
# Pulls in the same modules/nixos-system/extra set as hosts/laptop, minus
# the files tied to that machine's specific hardware/swap setup (its
# AMD CPU, its disk's hibernation resume_offset, its swapfile size, its
# mouse's USB device path) - none of which apply to this machine.
{ config, pkgs, lib, self, ... }:
let
  helpers = (import ../../modules/helpers.nix) { inherit lib; };
in
{
  imports = [
    # Generate this on the real machine and drop it here, e.g.:
    #   sudo nixos-generate-config --show-hardware-config > hosts/work-laptop/hardware-configuration.nix
    ./hardware-configuration.nix

    ../../modules/nixos-system/minimal
  ] ++ helpers.importDirExcept {
    dir = ../../modules/nixos-system/extra;
    exclude = [
      "default.nix"
      "swapdevices-conf.nix"
      "zram-hibernate-fix"
      "boot-conf.nix"
      "kernel-params.nix"
      "disable-usb-devices-wakeup"
    ];
  };

  networking.hostName = lib.mkForce "work-laptop";

  # Bootloader. No hibernation setup here (no resume_offset/resumeDevice) -
  # that's tied to laptop's specific swapfile/disk and isn't configured for
  # this machine (see swapdevices-conf.nix/boot-conf.nix on hosts/laptop).
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  powerManagement.enable = true;

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
