{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # To enable Hibernation
  boot.initrd.systemd.enable = true;
  boot.kernelParams = [ "resume_offset=29411328" "mem_sleep_default=deep" ];
  boot.resumeDevice = "/dev/disk/by-uuid/87f2622a-b70d-471a-88fd-3c8b267fe4de";
  boot = {
    kernel.sysctl = {
      "vm.swappiness" = 20;
    };
  };

  powerManagement.enable = true;
}

