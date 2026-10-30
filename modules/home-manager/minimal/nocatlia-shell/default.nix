{ inputs, ... }:
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;
    settings = builtins.readFile ./noctalia_config.toml;
  };

  # Launcher icon, referenced from noctalia_config.toml as
  # ~/.config/noctalia/nix-snowflake.svg.
  xdg.configFile."noctalia/nix-snowflake.svg".source = ./nix-snowflake.svg;
}
