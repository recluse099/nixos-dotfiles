{pkgs, lib, config, ...}: {
  programs = {
    nushell = {
      enable = true;
      shellAliases = {
        "ll" = "ls -la";
        "ze" = "zellij";
        "yz" = "yazi";
        "ga" = "git add";
        "clr" = "clear";
        "nhhs" = "nh home switch /home/recluse/dotfiles";
        "nhos" = "nh os switch /home/recluse/dotfiles";
        "la" = "eza";
      };
      settings = {
        show_banner = false;
        buffer_editor = "nvim";
      };
    };
  };
}
