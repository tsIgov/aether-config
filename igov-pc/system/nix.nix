{ ... }:
{
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	system.stateVersion = "24.11"; 

	nix.optimise = {
		automatic = true;
		dates = [ "Mon 06:00" ];
	};

	nix.gc = {
		automatic = true;
		dates = "Mon 06:00";
		persistent = true;
		options = "--delete-older-than 7d";
	};
}