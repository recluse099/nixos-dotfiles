# Everything only "full" hosts (currently just the laptop) want. Auto-imports
# every module in this directory - drop a new one in here and it's picked up
# with no edits anywhere else. Add here unless the module belongs on every
# host, in which case it goes in ../minimal instead.
{ lib, ... }:
let
  helpers = (import ../../helpers.nix) { inherit lib; };
in
{
  imports = helpers.importDirAll ./.;
}
