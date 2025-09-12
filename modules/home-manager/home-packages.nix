{pkgs, ...}: {
  home.packages = with pkgs; [
    stylish-haskell
    typst
    typst-live
    tinymist
    ferdium
  ];
}
