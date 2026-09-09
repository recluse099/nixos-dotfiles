# Minimal NixOS config for the office desktop (Intel Core i7-14700, 32GB RAM,
# integrated graphics). Imports modules/nixos-system/minimal only - everything
# in modules/nixos-system/extra is laptop-only (hibernation/resume/USB-wakeup
# tuning, waydroid, postgres, the big app list, ...) and never reaches here.
{
  config,
  pkgs,
  lib,
  inputs,
  self,
  ...
}:
{
  imports = [
    # Generate this on the real machine and drop it here, e.g.:
    #   sudo nixos-generate-config --show-hardware-config > hosts/desktop/hardware-configuration.nix
    # It will auto-detect the Intel CPU (kvm-intel, hardware.cpu.intel.updateMicrocode)
    # and the real disk/filesystem UUIDs - none of that is hand-written here.
    ./hardware-configuration.nix

    ../../modules/nixos-system/minimal
  ];

  networking.hostName = "work-desktop";
  networking.networkmanager.enable = true;
  environment.systemPackages = with pkgs; [ networkmanagerapplet ];

  # Desktop: plain systemd-boot, no hibernation/resume tuning (that's laptop-only).
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Swap is whatever the real machine's partition layout gives it, via
  # hardware-configuration.nix's swapDevices - no swapfile/zram declared here.

  services.xserver.enable = false;

  users.users.recluse = {
    isNormalUser = true;
    description = "recluse";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
    ];
    shell = lib.getExe pkgs.zsh;
  };
  nix.settings.trusted-users = [ "recluse" ];

  nixpkgs.config.allowUnfreePredicate = _: true;

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 10";
    };
    # This flake lives in hosts/, not the repo root - keep nh pointed at it.
    flake = "/home/recluse/dotfiles/hosts";
  };
}
