{ pkgs, lib, ... }:
{
  xdg.configFile."niri/config.kdl".source = pkgs.writeText "config.kdl" (
    lib.replaceStrings [ "@wukongWallpaper@" ] [
      "${../wpaperd/wallpapers/wukong-vs-heaven.jpg}"
    ] (builtins.readFile ./config.kdl)
  );
}
