{pkgs, self, ...}: {
  home.packages = with pkgs; [
    stylish-haskell
    typst
    typst-live
    tinymist
    wl-gammarelay-rs
    wl-gammarelay-applet
    (self.packages.${pkgs.system}.default)
  ];
}
