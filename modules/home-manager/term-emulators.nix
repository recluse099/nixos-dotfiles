{pkgs, config, lib, ...}: {
  programs = {
    ghostty = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      settings = {
        font-family = "JetBrainsMono Nerd Font";
        font-size = 18;
        freetype-load-flags = ["hinting"];
        background-opacity = 0.8;
        window-decoration = "auto";
        shell-integration = "detect";
        bold-is-bright = true;
        command = lib.getExe pkgs.zsh;
        theme = "catppuccin-mocha";
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
