{ pkgs, ... }:
{
  systemd.services."hibernate-lock" = {
    description = "Lock screen before hibernation";
    before = [ "sleep.target" ];
    wantedBy = [ "sleep.target" ];
    serviceConfig = {
      Type = "forking";
      User = "recluse";
      Environment = "WAYLAND_DISPLAY=wayland-1 XDG_RUNTIME_DIR=/run/user/1000";
      ExecStart = "${pkgs.swaylock}/bin/swaylock -f";
    };
  };
}
