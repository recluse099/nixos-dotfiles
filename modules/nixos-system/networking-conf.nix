{pkgs, ...}:
{
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}

