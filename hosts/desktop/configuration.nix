# Minimal NixOS config for the office desktop (Intel Core i7-14700, 32GB RAM,
# integrated graphics). Hand-picked imports from the shared modules/nixos-system
# tree instead of the laptop's import-everything default.nix, since most of the
# laptop's modules are laptop-specific (hibernation, lid switch, USB wakeup
# tuning, waydroid, postgres, ...) or just extra apps not wanted here.
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

    # --- baseline plumbing niri/noctalia need to actually work as a desktop ---
    ../../modules/nixos-system/allow-unfree-pkgs.nix
    ../../modules/nixos-system/experimental-features.nix
    ../../modules/nixos-system/audio-services.nix
    ../../modules/nixos-system/bluetooth/default.nix
    ../../modules/nixos-system/hardware-graphics-conf.nix
    ../../modules/nixos-system/portals-conf.nix
    ../../modules/nixos-system/printing/default.nix
    ../../modules/nixos-system/system-fonts.nix
    ../../modules/nixos-system/direnv/default.nix # needed: zsh module below runs `direnv hook zsh`

    # --- personal defaults carried over (not hardware-specific) ---
    ../../modules/nixos-system/locale-conf.nix
    ../../modules/nixos-system/timezone-conf.nix
    ../../modules/nixos-system/env-vars-conf.nix
    ../../modules/nixos-system/xdg-terminal-default.nix
    ../../modules/nixos-system/stateVersion.nix

    # --- what you actually asked for ---
    ../../modules/nixos-system/niri.nix
    ../../modules/nixos-system/noctalia-greeter/default.nix
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
