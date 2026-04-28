{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.niri.homeModules.niri
    ./packages.nix
  ];

  config = lib.mkIf config.myconfig.features.desktop {
    nixpkgs.overlays = [ inputs.niri.overlays.niri ];

    programs.niri.enable = true;
    programs.niri.package = pkgs.niri-unstable;

    home.file.".config/niri/config.kdl" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/stow/niri/.config/niri/config.kdl";
    };
  };
}
