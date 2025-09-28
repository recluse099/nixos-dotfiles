{
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    enableFishIntegration = true;
    settings = builtins.fromTOML (builtins.readFile ./starship.toml);
  };
}
