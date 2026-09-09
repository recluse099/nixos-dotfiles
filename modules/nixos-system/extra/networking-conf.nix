{pkgs, lib, ...}:
{
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  # networking.wireless.enable = lib.mkForce false;
  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}

