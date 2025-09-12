{pkgs, ...}:
{
  users.users.recluse = {
  isNormalUser = true;
  description = "recluse";
  extraGroups = [ "networkmanager" "wheel" "video" ];
  shell = pkgs.nushell;
  # packages = with pkgs; [
  #  thunderbird
  # ];
  };
}
