{lib, ...}:
let
  helpers = (import ../helpers.nix) { inherit lib; };
in
{
  imports = helpers.importDirExcept {
    dir = ./.; 
    exclude = [ "default.nix" "ctp-mocha.nix" "eww.nix" ];
  };
}
