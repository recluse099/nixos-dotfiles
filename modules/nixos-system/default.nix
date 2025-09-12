{lib, ...}:
let 
  helpers = (import ../helpers.nix) { inherit lib; };
in 
  {
    imports = helpers.importDirAll ./.;
  }

