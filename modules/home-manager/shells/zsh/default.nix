{
  pkgs,
  lib,
  ...
}: {
  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
      strategy = ["match_prev_cmd"];
    };
    enableCompletion = true;
    syntaxHighlighting = {
      enable = true;
    };
    shellAliases = {
      "ll" = "ls -la";
      "ze" = "zellij";
      "ga" = "git add";
      "clr" = "clear";
      "nhhs" = "nh home switch /home/recluse/dotfiles";
      "nhos" = "nh os switch /home/recluse/dotfiles";
    };
    initContent = lib.mkOrder 500 ''
      eval "$(starship init zsh)"
      # Prevent blinking cursor.
      function __set_beam_cursor {
        echo -ne '\e[6 q'
      }
      function __set_block_cursor {
        echo -ne '\e[2 q'
      }
      function zle-keymap-select {
        case $KEYMAP in
          vicmd) __set_block_cursor;;
          viins|main) __set_beam_cursor;;
        esac
      }
      zle -N zle-keymap-select
      precmd_functions+=(__set_beam_cursor)
    '';
  };
}
