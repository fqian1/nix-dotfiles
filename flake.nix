{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, disko,  ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
        packages.${system}.nvim-config = pkgs.vimUtils.buildVimPlugin {
	  name = "my-nvim-config";
	  src = ./nvim;
	};
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          disko.nixosModules.disko
          ./configuration.nix
          ./disk-config.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { 
	      inherit inputs; 
	      nvimConfigPkg = self.packages.${system}.nvim-config;
	    };
            home-manager.users.fqian = {
              imports = [
	        ./home.nix
              ];
            };
            home-manager.backupFileExtension = "backup";
          }
        ];
      };
    };
}

