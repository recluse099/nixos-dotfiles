{pkgs, ...}:
{
  programs.sioyek = {
    enable = true;
    config = {
      # ---Appearance---
      "default_dark_mode" = "0"; 
      "background_color" = "0.094 0.094 0.145"; # mantle
      "dark_mode_background_color" = "0.094 0.094 0.145"; # mantle
      "text_highlight_color" = "0.98 0.7 0.53"; # peach 
      "search_highlight_color" = "0.96 0.76 0.90"; # pink
      "custom_background_color" = "0.118 0.118 0.180"; # base
      "custom_text_color" = "0.804 0.839 0.957"; # text
      "custom_color_mode_empty_background_color" = "0.094 0.094 0.145"; # mantle
      "status_bar_color" = "0.192 0.196 0.267"; # surface0
      "status_bar_text_color" = "0.804 0.839 0.957"; # text
      "ui_background_color" = "0.192 0.196 0.267"; # surface0
      "ui_text_color" = "0.804 0.839 0.957"; # text
      "ui_selected_background_color" = "0.118 0.118 0.180"; # base
      "ui_selected_text_color" = "0.651 0.678 0.784"; # subtext0
      "page_separator_color" = "0.0667 0.0667 0.1059"; # crust

      # ---Other---
      "page_separator_width" = "7";
      "touchpad_sensitivity" = "1";
      "should_launch_new_window" = "1";
      "show_document_name_in_statusbar" = "1";
      "status_bar_format" = "Page %{current_page} / %{num_pages}%{chapter_name}%{search_results}%{search_progress}%{link_status}%{waiting_for_symbol}%{indexing}%{preview_index}%{synctex}%{drag}%{presentation}%{visual_scroll}%{locked_scroll}%{highlight}%{closest_bookmark}%{close_portal}%{rect_select}%{custom_message}%{document_name}";
      "hover_overview" = "1";
      "show_doc_path" = "1";
      "prerender_next_page_presentation" = "1";
      "case_sensitive_search" = "0";
      "startup_commands" = "toggle_custom_color;toggle_scrollbar";
    };
  };
}
