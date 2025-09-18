{pkgs, ...}:
{
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-volman
      thunar-vcs-plugin
      thunar-archive-plugin
      thunar-media-tags-plugin
    ];
  };
}
