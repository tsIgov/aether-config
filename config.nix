{ pkgs, ... }:
{
	config =  {
		appearance = {
			cursor = {
				package = pkgs.bibata-cursors;
				name = "Bibata-Modern-Classic";
				size = 20;
			};

			fonts = {
				propo-name = "Ubuntu Nerd Font";
				mono-name = "UbuntuMono Nerd Font";
				default-name = "UbuntuMono Nerd Font";
				default-size = 12;
			};

			icons = {
				package = pkgs.iconpack-obsidian;
				name = "Obsidian-Green";
			};
		};

		directories = {
			screenshot = "~/temp/Screenshot";
		};
	};
}