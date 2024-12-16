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

	outputs = { self, nixpkgs, aether, digital-brain, software-development, home-manager, ... } @inputs:
	let
		lib = aether.lib;

		digital-brain-pkgs = lib.importNixpkgs digital-brain;
		software-development-pkgs = lib.importNixpkgs software-development;
	in {
		nixosConfigurations = {
			"igov-pc" = nixpkgs.lib.nixosSystem {
				pkgs = lib.importNixpkgs nixpkgs;
				specialArgs = { };
				modules = 
					[ aether.nixosModules.system ] ++
					(lib.getNixFilesRecursively ./system); 
			};
		};



		homeConfigurations = {
			"igov-pc" = home-manager.lib.homeManagerConfiguration {
				pkgs = lib.importNixpkgs nixpkgs;
				extraSpecialArgs = { inherit digital-brain-pkgs software-development-pkgs; };
				modules = 
					# [ ({ ... }: { nixpkgs.overlays = [ overlay-packages ]; }) ] ++ 
					[ aether.nixosModules.user ] ++
					(lib.getNixFilesRecursively ./user);
			};
		};

	};
}