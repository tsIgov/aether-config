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
  };
}
