{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.software-development.git;
    userName  = "Tsvetan Igov";
    userEmail = "ts.igov@outlook.com";
  };

  home.packages = with pkgs.software-development; [
    dotnetCorePackages.sdk_8_0
    vscode-fhs
  ];
}
