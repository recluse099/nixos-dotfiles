{pkgs, self, ...}: {
  home.packages = with pkgs; [
    vimPlugins.haskell-vim
    stylish-haskell
    typst
    typst-live
    tinymist
    wl-gammarelay-rs
    wl-gammarelay-applet
    # haskell project shit
    haskellPackages.utf8-string
    haskellPackages.http-conduit
    pinta
  ];
}
