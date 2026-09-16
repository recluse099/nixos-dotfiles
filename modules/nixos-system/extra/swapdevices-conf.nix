{
  # Swapfile - kept at a higher priority than zram so it's used first. This
  # is inverted from the usual "zram first" setup on purpose: hibernation
  # needs to write the whole memory image to disk-backed swap, and zram
  # (RAM-backed) can't hold it. Filling the disk swapfile first keeps zram's
  # footprint small, so it stays small enough to reliably swapoff/reclaim at
  # hibernate time (see zram-hibernate-fix). Preferring zram first, as
  # before, works great for day-to-day performance but reliably breaks
  # hibernation once zram fills to its default ~50% of RAM.
  swapDevices = [
    {
      device = "/swapfile";
      size = 10 * 1024; # in MB(10GB)
      options = [ "pri=10" ];
    }
  ];
  zramSwap = {
    enable = true;
    memoryPercent = 15;
    priority = 5;
  };
  systemd.tmpfiles.rules = [
    "w /sys/power/image_size - - - - 0"
  ];
}
