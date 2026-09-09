{
  programs.starship = {
    enable = false;
    enableNushellIntegration = true;
    enableFishIntegration = true;
    settings = builtins.fromTOML (builtins.readFile ./starship.toml);
  };
}
