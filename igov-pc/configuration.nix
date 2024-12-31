{ hostname, inputs, pkgs, specialArgs }:
let
	lib = inputs.nixpkgs.lib;
	getNixFilesRecursively = path: builtins.filter (n: lib.strings.hasSuffix ".nix"(toString n)) (lib.filesystem.listFilesRecursive path);
	usersList = lib.attrNames (lib.filterAttrs (name: value: value == "directory" && name != "system") (builtins.readDir ./.));

	createUserModule = name: args: { imports = getNixFilesRecursively (./. + "/${name}"); };
	users = lib.listToAttrs (map (name: { name = name; value = createUserModule name; }) usersList);
in
{
	${hostname} = inputs.nixpkgs.lib.nixosSystem {
		inherit pkgs specialArgs;
		modules = getNixFilesRecursively ./system ++ [ 
			./hardware-configuration.nix 
			inputs.aether.nixosModule
			inputs.home-manager.nixosModules.home-manager
			{
				home-manager = {
					useGlobalPkgs = true;
					useUserPackages = true;
					extraSpecialArgs = specialArgs;
					sharedModules = [ inputs.aether.homeManagerModule ];
					inherit users;
				};
			}
		]; 
	};
}