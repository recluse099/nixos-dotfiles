{pkgs, self, ...}: {
  environment.systemPackages = with pkgs; [ 
    wget
    libreoffice
    python3
    python313Packages.pynvim-pp # required dependency for cocktail
    python313Packages.pynvim
    chromium
    ghc
    python312Packages.z3-solver
    obsidian
    google-chrome
    discord
    vlc
    xwayland-satellite
    pamixer
    pavucontrol
    jq
    iproute2
    radeontop
    brightnessctl
    matugen
    # bluetooth tools
    bluez
    haskell-language-server
    nodejs_24
    nix-init
  ];
}
