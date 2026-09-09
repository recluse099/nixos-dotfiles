{lib, ...}:
{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
      return {
        color_scheme = "Catppuccin Mocha",
        font_size = 24,
        term = "wezterm",
        enable_wayland = true,
        default_cursor_style = SteadBar,
        front_end = "WebGpu",
      }
    '';
  };
}
