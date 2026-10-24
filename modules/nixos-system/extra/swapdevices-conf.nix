{
  # zram kept at a higher priority than the disk swapfile so it's used
  # first: it's RAM-backed and compressed, so swapping to it is cheap and
  # fast, unlike the disk swapfile which is I/O-bound and can make the
  # system grind to a halt under memory pressure (12GB RAM -> 16GB RAM
  # upgrade, Oct 2026 freeze postmortem). This is safe for hibernation
  # because memoryPercent is capped low (see zramSwap below): zram's actual
  # size stays small enough that the pre-hibernate `swapoff /dev/zram0` (see
  # zram-hibernate-fix) can always evacuate it back into free RAM
  # reliably - the capped size, not the priority order, is what keeps that
  # swapoff safe.
  swapDevices = [
    {
      device = "/swapfile";
      size = 20 * 1024; # in MB(20GB) - RAM (16GB) + margin, needed to hold the full hibernation image
      options = [ "pri=5" ];
    }
  ];
  zramSwap = {
    enable = true;
    memoryPercent = 25;
    priority = 10;
  };
  systemd.tmpfiles.rules = [
    "w /sys/power/image_size - - - - 0"
  ];
}
