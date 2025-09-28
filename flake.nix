{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nvf.url = "github:notashelf/nvf?ref=v0.8";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.home-manager.follows = "home-manager";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, nvf, ... }: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;
    in {
      /*packages.${system}.default =
        (nvf.lib.neovimConfiguration {
          inherit pkgs;
          modules = [ ./nvf-configuration.nix ];
        }).neovim;*/

      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self; };    #  <- pass self here
          modules = [
            ./configuration.nix
            #nvf.nixosModules.default
          ];
        };
      };
      homeConfigurations.recluse = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          nvf.homeManagerModules.default  
          ./home.nix
        ];
        extraSpecialArgs = { inherit self; inherit inputs; }; 
      };
    };
}

