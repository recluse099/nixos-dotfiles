{
  description = "Multi-host flake (laptop + work-desktop), built on top of the shared modules/ tree from the root flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
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
      pkgs = nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        # Laptop: identical to the root flake's "nixos" config, just re-keyed to its
        # real hostname. Reuses ../configuration.nix (and therefore the whole
        # modules/nixos-system tree) verbatim so edits to the shared modules stay
        # in sync with the root flake automatically.
        laptop = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit self inputs;
          };
          modules = [
            ../configuration.nix
            auto-cpufreq.nixosModules.default
            ./laptop/hostname-override.nix
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
            ../home.nix
          ];
          extraSpecialArgs = {
            inherit self inputs;
          };
        };

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
