{pkgs, lib, ...}: {
  programs = {
    ghostty = {
      enable = true;
      settings = {
        gtk-single-instance = true;
        font-family = "VictorMono Nerd Font";
        font-size = 20;
        freetype-load-flags = ["hinting"];
        background-opacity = 0.8;
        window-decoration = "auto";
        shell-integration = "detect";
        shell-integration-features = "no-cursor";
        bold-color = "bright";
        command = lib.getExe pkgs.zsh;
        theme = "Catppuccin Mocha";
        cursor-style-blink = false;
        cursor-style = "bar";
        keybind = [
          "ctrl+alt+h=goto_split:left"
          "ctrl+alt+l=goto_split:right"
          "ctrl+alt+j=goto_split:down"
          "ctrl+alt+k=goto_split:up"
          "ctrl+alt+shift+h=resize_split:left,10"
          "ctrl+alt+shift+l=resize_split:right,10"
          "ctrl+alt+shift+j=resize_split:down,10"
          "ctrl+alt+shift+k=resize_split:up,10"
        ];
      };
    };
  };
}
