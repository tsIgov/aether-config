{ config, pkgs, ... }:

{
  	home.packages = with pkgs.digital-brain; [
		obsidian
		syncthing-tray
	];

	services.syncthing = with pkgs.digital-brain; {
		enable = true;
		package = syncthing;
		guiAddress = "127.0.0.1:8384";
		overrideDevices = true;
		overrideFolders = true;
		settings = {
			devices = {
				phone = {
					autoAcceptFolders = true;
					id = "2FXGDWQ-KA760UY-IYYNRDK-JVYG2VM-04T45JJ-NDDBWEA-YNJDBPD-LNPNAAP";
					name = "Pixel 6";
				};
			};
			folders = {
				digital-brain = {
					enable = true;
					id = "rr581-ecaao";
					label = "digital-brain";
					devices = [ "phone" ];
					copyOwnershipFromParent = false;
					path = "~/digital-brain";
					type = "sendreceive";
				};
			};
			options = {
				urAccepted = -1;
				relaysEnabled = true;
				localAnnounceEnabled = false;
			};
		};
	};
}