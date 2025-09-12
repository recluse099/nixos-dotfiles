{pkgs, lib, ...}:
{
  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
      strategy = [ "match_prev_cmd" ];
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
    initContent = lib.mkOrder 1000 ''
      eval "$(starship init zsh)"   
      '';
  };
}
