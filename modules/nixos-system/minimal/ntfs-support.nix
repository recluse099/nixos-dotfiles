# Lets udisks/the file manager mount external NTFS drives (e.g. a Seagate
# backup drive) - without ntfs3g, mounting one fails with a generic "wrong
# fs type, bad superblock" error since there's no driver/helper for it.
{ pkgs, ... }:
{
  boot.supportedFilesystems = [ "ntfs" ];
  environment.systemPackages = [ pkgs.ntfs3g ];
}
