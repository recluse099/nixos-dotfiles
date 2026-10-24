{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # To enable Hibernation
  boot.initrd.systemd.enable = true;
  # resume_offset is the physical block offset of /swapfile's first extent
  # (physical_offset from `sudo filefrag -v /swapfile`, in 4096-byte blocks,
  # matching PAGE_SIZE on this system). It must be recalculated any time
  # /swapfile is resized or recreated, since that can relocate it on disk.
  # Recalculated 2026-10-24 after resizing /swapfile from 10GB to 20GB.
  boot.kernelParams = [ "resume_offset=3426304" "mem_sleep_default=deep" ];
  boot.resumeDevice = "/dev/disk/by-uuid/87f2622a-b70d-471a-88fd-3c8b267fe4de";
  boot = {
    kernel.sysctl = {
      # Raised from 20: zram is now the preferred (higher-priority) swap
      # tier (see swapdevices-conf.nix), and swapping to compressed RAM is
      # cheap, so it's worth reclaiming cold anon pages earlier rather than
      # waiting for memory to get tight.
      "vm.swappiness" = 60;
    };
  };

  powerManagement.enable = true;
}

