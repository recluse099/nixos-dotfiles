# Every host wants this - laptop and desktop alike. Auto-imports every module
# in this directory, so a new one dropped in here needs no edits elsewhere.
# Add here only if it applies regardless of hardware; anything laptop-specific
# (power/hibernation tuning, laptop-only hardware quirks, laptop-only apps)
# goes in ../extra instead.
{ lib, ... }:
let
  helpers = (import ../../helpers.nix) { inherit lib; };
in
{
  imports = helpers.importDirAll ./.;
}
