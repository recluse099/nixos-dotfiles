{pkgs, lib, ...}:
let 
 inherit ((import ./ctp-mocha.nix)) colors;
 makeColor = color: color + "ff";
in

  {
    programs.fuzzel = {
      enable = true;
      settings = {
        border.width = 4; 
        colors = {
          background = makeColor colors.base;
          text = makeColor colors.text;
          prompt = makeColor colors.subtext1;
          placeholder = makeColor colors.overlay1;
          input = makeColor colors.text;
          match = makeColor colors.blue;
          selection = makeColor colors.surface2;
          selection-text = makeColor colors.text;
          selection-match = makeColor colors.blue;
          counter = makeColor colors.overlay1;
          border = makeColor colors.blue;
        };
        main = {
          icon-theme = "Papirus";
          horizontal-pad = 10;
          prompt = "λ "; # This is actually a en space since normal space gets collapsed.
          terminal = "${lib.getExe pkgs.ghostty} -e";
        };
      };
    };
  }
