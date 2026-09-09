{
  description = "Multi-host flake (laptop + work-desktop), built on top of the shared ../modules/ tree";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-quick-update.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.home-manager.follows = "home-manager";
    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nvf,
      auto-cpufreq,
      ...
    }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;

      # texliveMedium (and anything else pulling in TeX Live's "asymptote")
      # needs asymptote's xasy GUI, which needs PyQt5, which is currently
      # broken to build against python3.14 on this nixpkgs revision.
      # Excluding asymptote here fixes it everywhere that reads
      # pkgs.texliveMedium - including modules/home-manager/extra/texlive and
      # zettlr's own internal PDF-export dependency, which hardcodes
      # pkgs.texliveMedium and can't be reached any other way.
      # Revert once upstream fixes PyQt5/python3.14.
      pkgs = (nixpkgs.legacyPackages.${system}).extend (
        final: prev: {
          texliveMedium = prev.texlive.combine {
            inherit (prev.texlive) scheme-medium;
            pkgFilter =
              pkg:
              (pkg.tlType == "run" || pkg.tlType == "bin" || pkg.pname == "core" || pkg.hasManpages or false)
              && pkg.pname != "asymptote";
          };
        }
      );
    in
    {
      nixosConfigurations = {
        # Laptop and work-desktop are symmetric siblings here: each has its own
        # configuration.nix/home.nix under hosts/<name>/, both drawing only from
        # the shared ../modules/ tree - neither host's config references the other's.
        laptop = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit self inputs;
          };
          modules = [
            ./laptop/configuration.nix
            auto-cpufreq.nixosModules.default
          ];
        };

        # Desktop: minimal, hand-picked module set. See hosts/desktop/configuration.nix.
        work-desktop = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit self inputs;
          };
          modules = [
            ./desktop/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        "recluse@laptop" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            nvf.homeManagerModules.default
            ./laptop/home.nix
          ];
          extraSpecialArgs = {
            inherit self inputs;
          };
        };

        # Fallback for `nh home switch`'s auto-detect, which tries
        # `recluse@$(hostname)` first and then plain `recluse`. Needed until
        # the laptop actually switches over and its hostname becomes
        # "laptop" (matching the entry above directly).
        recluse = self.homeConfigurations."recluse@laptop";

        "recluse@work-desktop" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            nvf.homeManagerModules.default
            ./desktop/home.nix
          ];
          extraSpecialArgs = {
            inherit self inputs;
          };
        };
      };
    };
}
