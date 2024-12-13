{
	description = "Aether desktop environment";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		digital-brain.url = "github:nixos/nixpkgs/nixos-unstable";
		software-development.url = "github:nixos/nixpkgs/nixos-unstable";
	};

	outputs = { self, nixpkgs, home-manager, ... } @inputs:
	let
		lib = nixpkgs.lib;
		pkgs = importPackages nixpkgs;

		importPackages = input: import input { system = "x86_64-linux"; config.allowUnfree = true; };
		importModules = path: lib.filter (n: lib.strings.hasSuffix ".nix" (toString n)) (lib.filesystem.listFilesRecursive path);

		overlay-packages = final: prev: {
			custom = import /etc/aether/src/custom-packages/default.nix { inherit pkgs; };
			digital-brain = importPackages inputs.digital-brain;
			software-development = importPackages inputs.software-development;
		};

	in {
		homeConfigurations = {
			"aether" = home-manager.lib.homeManagerConfiguration {
				pkgs = pkgs;
				extraSpecialArgs = { };
				modules = [ 
					({ ... }: { nixpkgs.overlays = [ overlay-packages ]; }) ] ++ 
					(importModules /etc/aether/src/user/modules) ++ 
					(importModules ~/.config/aether/modules) ++ 
					(importModules ~/.config/aether/secrets) ++ [
					~/.config/aether/config.nix
				];
			};
		};
	};
}
