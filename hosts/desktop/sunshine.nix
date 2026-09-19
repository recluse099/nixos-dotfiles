# Streams grace's desktop to Moonlight clients (e.g. the laptop), so
# LibreWolf here can be driven remotely using this machine's hardware.
# capSysAdmin is needed for DRM/KMS screen capture since there's no
# physical monitor and services.xserver is disabled (see configuration.nix).
{ ... }:
{
  services.sunshine = {
    enable = true;
    openFirewall = true;
    capSysAdmin = true;
  };
}
