{ pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		git-agecrypt
	];
}