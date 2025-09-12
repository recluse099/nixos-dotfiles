{ pkgs, inputs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "recluse";
  home.homeDirectory = "/home/recluse";

  home.stateVersion = "25.05"; # Please read the comment before changing.
  news.display = "notify";
  imports = [
    inputs.zen-browser.homeModules.twilight
    ./modules/home-manager
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = { 
    TERMINAL = lib.getExe pkgs.ghostty;
    LAUNCHER = /home/recluse/.nix-profile/bin/fuzzel;
    SHELL = /home/recluse/.nix-profile/bin/nu;
    FLAKE = "/home/recluse/source/nix/"; # path to flake
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    fastfetch.enable = true;
    wlogout.enable = true;
  };
  services.network-manager-applet.enable = true;
}
