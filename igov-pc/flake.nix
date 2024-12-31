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

	outputs = inputs:
	let
		hostname = "igov-pc";
		system = "x86_64-linux";
		importArguments = { inherit system; config.allowUnfree = true; };

		pkgs = import inputs.nixpkgs importArguments;
		specialArgs = {
			inherit inputs;
			digital-brain-pkgs = import inputs.digital-brain importArguments;
			software-development-pkgs = import inputs.software-development importArguments;
			photography-pkgs = import inputs.photography importArguments;
		};
	in {
		nixosConfigurations = import ./configuration.nix { inherit hostname inputs pkgs specialArgs; };
	};
}