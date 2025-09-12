{pkgs, ...}:
{
  programs.eza = {
    enable = true;
    git = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    enableNushellIntegration = false;
    theme = ./catppuccin-eza.nix;
    icons = "always";
    extraOptions = [
      "--header"
    ];
  }; 
}
