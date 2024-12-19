{ ... }:
{
	config.aether.system = { 

		users = {
			"igov" = {
				description = "Tsvetan Igov";
				isSystemUser = false;
				sudoer = true;
				initialPassword = "aether";
			};
		};

		garbage-collection = {
			automatic = true;
			schedule = "*-*-01 06:00";
			days-old = 30;
		};
		
		networking = {
			hostname = "igov-pc";
		};
	};
}