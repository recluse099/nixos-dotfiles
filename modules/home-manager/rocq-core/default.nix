{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rocq-core_9_1
    coq_9_1
    coqPackages.coq-lsp
    coqPackages.stdlib
    coqPackages.stdpp
  ];
}
