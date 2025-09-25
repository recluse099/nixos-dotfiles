{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # To enable Hibernation
  boot.kernelParams = [ "resume_offset=41621504" ];
  boot.resumeDevice = "/dev/disk/by-uuid/87f2622a-b70d-471a-88fd-3c8b267fe4de";

  powerManagement.enable = true;
}

