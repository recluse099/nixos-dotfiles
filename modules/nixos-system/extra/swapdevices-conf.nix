{
  # Swapfile
  swapDevices = [
    {
      device = "/swapfile";
      size = 10 * 1024; # in MB(10GB)
    }
  ];
  zramSwap = {
    enable = true;
    priority = 50;
  };
  systemd.tmpfiles.rules = [
    "w /sys/power/image_size - - - - 0"
  ];
}
