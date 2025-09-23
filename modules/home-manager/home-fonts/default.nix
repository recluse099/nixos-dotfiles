{pkgs, ...}:
{
  home.packages = with pkgs; [ 
  nerd-fonts.jetbrains-mono
  nerd-fonts.adwaita-mono
  nerd-fonts.fira-code
  nerd-fonts.droid-sans-mono
  nerd-fonts.symbols-only
  nerd-fonts.comic-shanns-mono
  ];
}
