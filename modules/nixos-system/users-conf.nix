{pkgs, lib, ...}:
{
  users.users.recluse = {
  isNormalUser = true;
  description = "recluse";
  extraGroups = [ "networkmanager" "wheel" "video" ];
  shell = lib.getExe pkgs.zsh;
  # packages = with pkgs; [
  # ];
  };
  nix.settings.trusted-users = [ "recluse" ];
}
