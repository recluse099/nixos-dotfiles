{ pkgs, lib, ... }:
{
  users.users = {
    recluse = {
      isNormalUser = true;
      description = "recluse";
      extraGroups = [
        "networkmanager"
        "wheel"
        "video"
      ];
      shell = lib.getExe pkgs.zsh;
      # packages = with pkgs; [
      # ];
    };
    postgres = {
      shell = lib.getExe pkgs.nushell;
    };
  };
  nix.settings.trusted-users = [ "recluse" ];
}
