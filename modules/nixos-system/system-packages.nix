{pkgs, self, ...}: {
  environment.systemPackages = with pkgs; [ 
    wget
    libreoffice
    python3
    chromium
    ghc
    python312Packages.z3-solver
    obsidian
    google-chrome
    discord
    deluge
    vlc
    xwayland-satellite
    pamixer
    pavucontrol
    jq
    iproute2
    radeontop
    brightnessctl
    matugen
    blueberry
    haskell-language-server
    nodejs_24
  ];
}
