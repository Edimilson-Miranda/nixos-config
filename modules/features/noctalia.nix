{ lib, config, inputs, ... }:
{
  imports = [ inputs.noctalia.homeModules.default ];

  config = lib.mkIf config.myconfig.features.desktop {
    programs.noctalia-shell = {
      enable = true;
    };
  };
}
