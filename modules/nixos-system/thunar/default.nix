{ pkgs, ... }:
{
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-volman
      thunar-vcs-plugin
      thunar-archive-plugin
      thunar-media-tags-plugin
      thunar-dropbox-plugin
    ];
  };
  environment.systemPackages = with pkgs; [ file-roller ];
  services.gvfs.enable = true;
  services.tumbler.enable = true;
}
