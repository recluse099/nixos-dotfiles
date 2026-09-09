{ pkgs, ... }:
{
  home.packages = [ pkgs.wl-clipboard-rs ];

  services.cliphist.enable = true;
}

