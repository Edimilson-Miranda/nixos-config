{ username, ... }:
{
  imports = [
    ./modules/packages.nix
    ./modules/fonts.nix
    ./modules/shell.nix
    ./modules/development.nix
    ./modules/applications.nix
    ./modules/cli-tools.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
