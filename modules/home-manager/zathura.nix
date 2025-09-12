{pkgs, ...}: 
{
  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
      selection-notification = false;
      recolor = true;
      # --- Core colors ---
      default-fg = "#cdd6f4"; # text
      default-bg = "#11111b"; # crust
      recolor-keephue = true;
      recolor-lightcolor = "#1e1e2e"; # base
      recolor-darkcolor  = "#cdd6f4"; # text

      # --- Completion ---
      completion-bg = "#313244";         # surface0
      completion-fg = "#cdd6f4";         # text
      completion-highlight-bg = "#585b70"; # surface2
      completion-highlight-fg = "#cdd6f4"; # text
      completion-group-bg = "#313244";   # surface0
      completion-group-fg = "#89b4fa";   # blue

      # --- Statusbar ---
      statusbar-fg = "#cdd6f4"; # text
      statusbar-bg = "#313244"; # surface0

      # --- Notifications ---
      notification-bg = "#313244";       # surface0
      notification-fg = "#cdd6f4";       # text
      notification-error-bg = "#313244"; # surface0
      notification-error-fg = "#f38ba8"; # red
      notification-warning-bg = "#313244"; # surface0
      notification-warning-fg = "#fab387"; # peach

      # --- Inputbar ---
      inputbar-fg = "#cdd6f4"; # text
      inputbar-bg = "#313244"; # surface0

      # --- Index ---
      index-fg = "#cdd6f4";       # text
      index-bg = "#1e1e2e";       # base
      index-active-fg = "#cdd6f4"; # text
      index-active-bg = "#45475a"; # surface1

      # --- Render/loading ---
      render-loading-bg = "#1e1e2e"; # base
      render-loading-fg = "#cdd6f4"; # text

      # --- Highlights (semi-transparent if supported) ---
      highlight-color        = "rgba(203,166,247,0.55)"; # mauve
      highlight-active-color = "rgba(245,194,231,0.65)"; # pink
      highlight-fg           = "rgba(255,255,255,0.9)";  # white
      # ---Girara options
      guioptions = "v s";
    };
  };  
}
