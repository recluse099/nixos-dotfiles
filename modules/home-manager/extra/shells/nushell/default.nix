{pkgs, ...}: {
  programs = {
    nushell = {
      enable = true;
      shellAliases = {
        "ll" = "ls -la";
        "ze" = "zellij";
        "yz" = "yazi";
        "ga" = "git add";
        "clr" = "clear";
        "nhhs" = "nh home switch";
        "nhos" = "nh os switch";
        "la" = "eza";
      };
      plugins = with pkgs.nushellPlugins; [
        gstat
      ];
      settings = {
        show_banner = false;
        buffer_editor = "nvim";
      };
    };
  };
}
