{ inputs, ... }:
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia-shell = {
    enable = false;
    settings = (builtins.fromJSON (builtins.readFile ./noctalia.json)).settings;
  };
}
