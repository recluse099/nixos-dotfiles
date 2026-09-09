{
  pkgs,
  lib,
  ...
}:
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
      "nhhs" = "nh home switch";
      "nhos" = "nh os switch";
      "wlog" = "~/scripts/weeklylog.sh";
      "wpush" = "~/scripts/logpush.sh";
    };
    initContent = lib.mkOrder 500 ''
      eval "$(direnv hook zsh)"
    '';
  };
}
