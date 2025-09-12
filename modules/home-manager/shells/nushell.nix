{pkgs, lib, config, ...}: {
  programs = {
    nushell = {
      enable = true;
      shellAliases = {
        "ll" = "ls -la";
        "ze" = "zellij";
        "ga" = "git add";
        "clr" = "clear";
        "nhhs" = "nh home switch /home/recluse/dotfiles";
        "nhos" = "nh os switch /home/recluse/dotfiles";

      };
      settings = {
        show_banner = false;
        buffer_editor = "nvim";
      };
    };
  };
}
