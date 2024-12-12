{ ... }:
{ 
	users.mutableUsers = true;
	users.users."igov" = {
		description = "Tsvetan Igov";
		extraGroups = [ "wheel" "networkmanager"];
		isNormalUser = true;
		createHome = true;
		useDefaultShell = true;
	};
}
