{
  description = "fqian's nixos configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      impermanence,
      disko,
      darwin,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      sharedModules = [
        ./modules/common
      ];

      nixosModules = [
        disko.nixosModules.disko
        impermanence.nixosModules.impermanence
        home-manager.nixosModules.home-manager
        ./modules/nixos
      ];

      darwinModules = [
        home-manager.darwinModules.home-manager
        ./modules/darwin
      ];
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          myPkgs = import ./pkgs {
            inherit pkgs;
            inherit system;
          };
        in
        {
          neovim-custom = myPkgs.nvim.neovim-custom;
        }
      );

      overlays = {
        neovim-custom = final: prev: {
          neovim-custom = self.packages.${final.system}.neovim-custom;
        };
      };

      darwinConfigurations = {
        "darwin" = darwin.lib.darwinSystem {
          specialArgs = {
            inherit inputs outputs;
            lib = nixpkgs.lib;
          };
          modules = sharedModules ++ darwinModules ++ [ ./hosts/darwin/default.nix ];
        };
      };

      nixosConfigurations = {
        "nixos" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
            lib = nixpkgs.lib;
          };
          modules =
            sharedModules
            ++ nixosModules
            ++ [
              ./hosts/nixos/default.nix
              (
                { pkgs, ... }:
                {
                  nixpkgs.overlays = [ self.overlays.neovim-custom ];
                }
              )
            ];
        };
      };
    };
}
