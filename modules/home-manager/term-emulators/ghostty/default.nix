{pkgs, lib, ...}: {
  programs = {
    ghostty = {
      enable = true;
      settings = {
        gtk-single-instance = true;
        font-family = "JetBrainsMono Nerd Font";
        font-size = 18;
        freetype-load-flags = ["hinting"];
        background-opacity = 1;
        window-decoration = "auto";
        shell-integration = "detect";
        bold-color = "bright";
        command = lib.getExe pkgs.zsh;
        theme = "Catppuccin Mocha";
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
