{
  description = "fqian's nixos configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lix = {
      url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
      flake = false;
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.lix.follows = "lix";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    impermanence,
    lix-module,
    lix,
    disko,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
    pkgsFor = forAllSystems (
      system:
        import nixpkgs {
          inherit system;
          overlays = [
            self.overlays.additions
            self.overlays.modifications
            self.overlays.unstable-packages
          ];
        }
    );
  in {
    overlays = import ./overlays {inherit inputs;};
    packages = forAllSystems (system: import ./pkgs pkgsFor.${system});
    formatter = forAllSystems (system: pkgsFor.${system}.alejandra);
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      "desktop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          disko.nixosModules.disko
          impermanence.nixosModules.impermanence
          lix-module.nixosModules.default
          ./hosts/desktop/configuration.nix
        ];
      };
      "laptop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          disko.nixosModules.disko
          impermanence.nixosModules.impermanence
          lix-module.nixosModules.default
          ./hosts/laptop/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "fqian" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor."x86_64-linux";
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home-manager/home.nix
        ];
      };
    };
  };
}
