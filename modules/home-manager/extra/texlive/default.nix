{ pkgs, ... }:
{
  # texliveFull (scheme-full) pulls in asymptote, whose PyQt5 dependency is
  # currently broken to build on this nixpkgs revision. pkgs.texliveMedium is
  # overridden flake-wide (see hosts/flake.nix) to exclude asymptote - revert
  # to plain `texliveFull` once upstream fixes PyQt5/python3.14.
  home.packages = [ pkgs.texliveMedium ];
}
