{
  # Swapfile
  swapDevices = [
    {
      device = "/swapfile";
      size = 10 * 1024; # in MB(10GB)
    }
  ];
  zramSwap.enable = true;
}
