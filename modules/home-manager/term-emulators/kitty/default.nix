{pkgs, lib, ...}: {
  programs.kitty = {
    enable = true;
    font = {
      package = pkgs.nerd-fonts.fantasque-sans-mono;
      name = "VictorMono Nerd Font"; 
      size = 24;
    };
    themeFile = "Catppuccin-Mocha";
    enableGitIntegration = true;
    shellIntegration = {
      mode = "";
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
    settings = {
      shell = lib.getExe pkgs.zsh;
      editor = "nvim";
      linux_display_server = "wayland";
      enable_audio_bell = "no";
      background_opacity = 0.9;
      wayland_enable_ime = "no";
      touch_scroll_multiplier = 7;
      cursor_blink_interval = 0;
    };
  };    
}
