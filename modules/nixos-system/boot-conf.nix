{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "resume_offset=33443840" ];
  boot.resumeDevice = "/dev/disk/by-uuid/87f2622a-b70d-471a-88fd-3c8b267fe4de";
}
