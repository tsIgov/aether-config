{ config, lib, software-development-pkgs, ... }:

let
  secrets = config.secrets.software-development;
in
{
  options.secrets.software-development = with lib; with types; {
		git-email = mkOption { type = singleLineStr; };
	};

  config = {
    programs.git = {
      enable = true;
      package = software-development-pkgs.git;
      userName  = "Tsvetan Igov";
      userEmail = secrets.git-email;
    };

    home.packages = with software-development-pkgs; [
      dotnetCorePackages.sdk_8_0
      vscode-fhs
      git-crypt
      age
    ];

    home.file = {
		  ".vscode/argv.json".text = ''
{
	// Use software rendering instead of hardware accelerated rendering.
	// This can help in cases where you see rendering issues in VS Code.
	// "disable-hardware-acceleration": true,

	"enable-crash-reporter": false,
	"crash-reporter-id": "fff3759e-696d-42e9-9acf-da40604eb18e",
	"password-store": "gnome-libsecret"
}
      '';
	  };
  };
}
