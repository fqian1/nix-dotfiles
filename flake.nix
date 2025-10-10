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
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        packages = {
	  nvim-config = pkgs.vimUtils.buildVimPlugin {
	    name = "nvim-config";
	    src = "./nvim";
	  };
	};
        modules = [
          disko.nixosModules.disko
          ./configuration.nix
          ./disk-config.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
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

