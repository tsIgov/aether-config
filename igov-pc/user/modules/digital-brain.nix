{ config, lib, digital-brain-pkgs, ... }:
let
	secrets = config.secrets.digital-brain;
in
{

	options.secrets.digital-brain = with lib; with types; {
		phone-id = mkOption { type = singleLineStr; };
	};

	config = {
		home.packages = with digital-brain-pkgs; [
			obsidian
		];

		services.syncthing = {
			enable = true;
			package = digital-brain-pkgs.syncthing;
			cert = "../secrets/syncthing-certs/cert.pem";
			key = "../secrets/syncthing-certs/key.pem";
			guiAddress = "127.0.0.1:8384";
			overrideDevices = true;
			overrideFolders = true;
			settings = {
				devices = {
					phone = {
						autoAcceptFolders = true;
						id = secrets.phone-id;
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
	};
}