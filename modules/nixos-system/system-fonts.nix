{pkgs, ...}: {
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.adwaita-mono
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.symbols-only
    nerd-fonts.comic-shanns-mono
    cascadia-code
    nerd-fonts.monaspace
    nerd-fonts.victor-mono
    fantasque-sans-mono
  ];
}
