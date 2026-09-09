{pkgs, lib, ...}: {
  programs.kitty = {
    enable = true;
    font = {
      package = pkgs.nerd-fonts.fantasque-sans-mono;
      name = "VictorMono Nerd Font"; 
      size = 22;
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
      background_opacity = 1;
      wayland_enable_ime = "no";
      touch_scroll_multiplier = 7;
      cursor_blink_interval = 0;
      window_padding_width = 0000;
      placement_strategy = "top";
      foreground = "#bac2de";
    };
    extraConfig = ''
      font_family family="VictorMono Nerd Font Mono" style="Regular" 
    '';
  };    
}
