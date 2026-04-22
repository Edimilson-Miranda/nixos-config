{ lib, config, inputs, ... }:
{
  imports = [ inputs.niri.homeModules.niri ./packages.nix ];

  config = lib.mkIf config.myconfig.features.desktop {
    programs.niri.enable = true;
  };
}
