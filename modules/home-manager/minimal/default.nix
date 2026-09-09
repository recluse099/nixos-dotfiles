# Everything every host wants, laptop and desktop alike. Auto-imports every
# module in this directory - drop a new one in here and it's picked up with
# no edits anywhere else. Add here only if it belongs on every host; anything
# host-specific to "full" installs goes in ../extra instead.
{ lib, ... }:
let
  helpers = (import ../../helpers.nix) { inherit lib; };
in
{
  imports = helpers.importDirAll ./.;
}
