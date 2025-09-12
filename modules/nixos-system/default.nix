let 
  importDir = import ../importDir.nix;
in 
  {
    imports = importDir ./.;
  }

