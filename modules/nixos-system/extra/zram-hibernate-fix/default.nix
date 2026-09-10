# The disk swapfile is preferred over zram (see swapdevices-conf.nix), but
# hibernation still needs zram's remaining RAM-backed swap fully cleared
# before writing the memory image, since zram-resident pages can't be part
# of a disk-persisted hibernation image. Swap it off before hibernating and
# back on once resumed, via systemd-hibernate.service's own start/stop
# lifecycle.
#
# Ordering against hibernate.target alone isn't enough: hibernate.target and
# systemd-hibernate.service (the unit that actually performs the sleep) are
# both pulled in together and start in parallel, so a plain
# `before = [ "hibernate.target" ]` races the real hibernate attempt - the
# kernel's task-freezer can interrupt swapoff mid-syscall before it
# finishes. Ordering explicitly before systemd-hibernate.service itself
# forces swapoff to fully complete first. The retry loop is extra insurance
# against a stray EINTR.
{ pkgs, ... }:
{
  systemd.services.zram-swapoff-before-hibernate = {
    description = "Disable zram swap before hibernation so the disk swapfile holds the hibernation image";
    before = [ "systemd-hibernate.service" "hibernate.target" ];
    wantedBy = [ "hibernate.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.bash}/bin/sh -c 'until ${pkgs.util-linux}/bin/swapoff /dev/zram0; do sleep 0.2; done'";
      ExecStop = "${pkgs.util-linux}/bin/swapon /dev/zram0";
    };
  };
}
