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
		# custom-pkgs = import /etc/aether/src/custom-packages/default.nix { inherit pkgs; };


		# overlay-packages = final: prev: {
		# 	custom = import /etc/aether/src/custom-packages/default.nix { inherit pkgs; };
		# 	digital-brain = importPackages inputs.digital-brain;
		# 	software-development = importPackages inputs.software-development;
		# };


	in {
		nixosConfigurations = {
			"igov-pc" = nixpkgs.lib.nixosSystem {
				pkgs = lib.importNixpkgs nixpkgs;
				specialArgs = { };
				modules = 
					[ aether.nixosModules.system ] ++
					(lib.getModulesRecursively ./system); 
			};
		};



		homeConfigurations = {
			"igov-pc" = home-manager.lib.homeManagerConfiguration {
				pkgs = lib.importNixpkgs nixpkgs;
				extraSpecialArgs = { inherit digital-brain-pkgs software-development-pkgs; };
				modules = 
					# [ ({ ... }: { nixpkgs.overlays = [ overlay-packages ]; }) ] ++ 
					[ aether.nixosModules.user ] ++
					(lib.getModulesRecursively ./user);
			};
		};

	};
}