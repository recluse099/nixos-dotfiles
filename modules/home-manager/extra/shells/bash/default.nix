{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      "ll" = "ls -la";
      "ze" = "zellij";
      "ga" = "git add";
      "clr" = "clear";
      "nhhs" = "nh home switch";
      "nhos" = "nh os switch";
    };
    #initExtra = ''
    #  eval "$(starship init bash)"
    #'';
  };
}
