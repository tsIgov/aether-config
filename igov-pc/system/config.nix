{ ... }:
{
	config.aether.system = { 
		graphics = {
			nvidia = true;
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