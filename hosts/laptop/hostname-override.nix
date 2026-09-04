{ lib, ... }:
{
  # modules/nixos-system/networking-conf.nix hardcodes hostName = "nixos" and is
  # shared with the root (single-host) flake, which must keep building that
  # hostname unchanged. Force it to "laptop" only for this flake's build.
  networking.hostName = lib.mkForce "laptop";
}
