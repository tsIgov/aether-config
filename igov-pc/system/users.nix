{ ... }:
{
	users = {
		mutableUsers = true;
		users = {
			"igov" = {
				description = "Tsvetan Igov";
				extraGroups = [ "wheel" "networkmanager"];
				isNormalUser = true;
				isSystemUser = false;
			};
		};
	};
}


