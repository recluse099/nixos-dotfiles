{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rocq-core
    coq
    coqPackages.coq-lsp
    coqPackages.stdlib
    coqPackages.stdpp
  ];
}
