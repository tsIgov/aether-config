{ photography-pkgs, ... }:
{
	home.packages = with photography-pkgs; [
		gimp
		rawtherapee
	];
}