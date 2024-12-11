{ config, pkgs, ... }:

{
  	home.packages = with pkgs.digital-brain; [
		obsidian
		syncthing-tray
	];

	services.syncthing = {
		enable = true;
		# There is no package options so this will be updated along with the shell for now.
	};
}