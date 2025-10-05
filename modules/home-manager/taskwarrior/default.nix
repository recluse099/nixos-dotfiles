{pkgs, ...}: 
{
  programs.taskwarrior = {
    enable = true;
    package = pkgs.taskwarrior3;
    colorTheme = "solarized-dark-256";
    config = {
      confirmation = false;
    };
  };
}
