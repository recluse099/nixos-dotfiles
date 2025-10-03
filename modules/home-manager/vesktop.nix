{ pkgs, ... }:
#let 
  #ctp-mocha = import ./ctp-mocha.nix;
#in
{  
  programs.vesktop.enable = true;
  xdg.configFile."vesktop/themes/catppuccin_mocha.css".source = pkgs.writeTextFile {
    name = "catppuccin_mocha.css";
    text = ''
      /**
       * @name Catppuccin Mocha 
       * @description Catppuccin Mocha Lavender with ComicShannsMono Nerd Font
       **/
      @import url("https://catppuccin.github.io/discord/dist/catppuccin-mocha-lavender.theme.css");
      :root {
        --font-display: ${"Fantasque Sans Mono"} !important;
        --font-primary: ${"Fantasque Sans Mono"} !important;
      }
    '';
  };
}

