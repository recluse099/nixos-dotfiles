{pkgs, ...}:
let
  ctp-mocha = import ./ctp-mocha.nix;
  makeColor = c: "#" + c;
  colors = ctp-mocha.colors;
in
{
  home.packages = [ pkgs.libnotify ];
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = ctp-mocha.font;
        background = makeColor colors.base;
        corner_radius = 8;
        foreground = makeColor colors.text;
        frame_color = makeColor colors.blue;
        frame_width = 4;
        icon_corner_radius = 4;
        monitor = 3;
        offset = "(30, 30)";
        origin = "bottom-right";
        progress_bar_corner_radius = 4;
        timeout = 10;
        transparency = 90;
      };

      urgency_critical = {
        frame_color = makeColor colors.peach;
        timeout = 0;
      };
    };
  };
}

