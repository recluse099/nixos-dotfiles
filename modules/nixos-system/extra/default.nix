# Laptop-only: mostly hardware/power-management modules tied to this specific
# machine (hibernation/resume tuning, USB wakeup quirks, lid-switch handling,
# swap), plus a few laptop-only apps and services. Auto-imports every module
# in this directory - drop a new laptop-only module in here and it's picked
# up with no edits elsewhere. Add here unless the module applies regardless
# of hardware, in which case it goes in ../minimal instead.
{ lib, ... }:
let
  helpers = (import ../../helpers.nix) { inherit lib; };
in
{
  imports = helpers.importDirAll ./.;
}
