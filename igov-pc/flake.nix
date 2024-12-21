{
	description = "Aether desktop environment";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		aether.url = "path:/home/igov/repositories/tsIgov/aether-desktop-environment";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		digital-brain.url = "github:nixos/nixpkgs/nixos-unstable";
		software-development.url = "github:nixos/nixpkgs/nixos-unstable";
	};

	outputs = { self, nixpkgs, aether, home-manager, ... } @inputs:
	let
		lib = aether.lib;
		pkgs = lib.importNixpkgs nixpkgs;

		digital-brain-pkgs = lib.importNixpkgs inputs.digital-brain;
		software-development-pkgs = lib.importNixpkgs inputs.software-development;
	in {
		nixosConfigurations = {
			"igov-pc" = nixpkgs.lib.nixosSystem {
				inherit pkgs;
				specialArgs = { };
				modules = [ 
					aether.nixosModules.system
					/etc/nixos/hardware-configuration.nix 
				] ++ (lib.getNixFilesRecursively ./system); 
			};
		};

		homeConfigurations = {
			"igov" = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				extraSpecialArgs = { inherit digital-brain-pkgs software-development-pkgs; };
				modules = 
					[ aether.nixosModules.user ] ++
					(lib.getNixFilesRecursively ./user);
			};
		};

	};
}