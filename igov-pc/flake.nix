{
	description = "Igov's personal computer";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		
		aether = {
			url = "path:/home/igov/repositories/tsIgov/aether-desktop-environment";
			#url = "github:tsIgov/aether-desktop-environment";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		digital-brain.url = "github:nixos/nixpkgs/nixos-unstable";
		software-development.url = "github:nixos/nixpkgs/nixos-unstable";
		photography.url = "github:nixos/nixpkgs/nixos-unstable";
	};

	outputs = { nixpkgs, aether, home-manager, ... } @inputs:
	let
		lib = aether.lib;
		packages = {
			pkgs = lib.importNixpkgs nixpkgs;
			digital-brain-pkgs = lib.importNixpkgs inputs.digital-brain;
			software-development-pkgs = lib.importNixpkgs inputs.software-development;
			photography-pkgs = lib.importNixpkgs inputs.photography;
		};
	in {
		nixosConfigurations = {
			"igov-pc" = nixpkgs.lib.nixosSystem {
				pkgs = packages.pkgs;
				modules = [ 
					aether.nixosModules.aether
					aether.nixosModules.scripts
					/etc/nixos/hardware-configuration.nix 
					(lib.createRecursiveModuleWithExtraArgs ./system packages)
					home-manager.nixosModules.home-manager
					{
						home-manager = {
							useGlobalPkgs = true;
            				useUserPackages = true;
							sharedModules = [ aether.homeManagerModules.aether ];
							users = {
								"igov" = lib.createRecursiveModuleWithExtraArgs ./igov packages;
							};
						};
					}
				]; 
			};
		};
	};
}