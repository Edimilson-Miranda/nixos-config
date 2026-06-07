{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:

  let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
  in
{
  imports = [ spicetify-nix.homeManagerModules.default ];  

  config = lib.mkIf config.myconfig.features.desktop {
    gtk.iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    programs.kitty = {
      enable = false;
    };

    xdg.mimeApps.defaultApplications = {
      "x-scheme-handler/terminal" = "kitty.desktop";
    };

    home.file.".config/kitty/kitty.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/myNixOS/stow/kitty/.config/kitty/kitty.conf";
    };

    home.packages = lib.optionals config.myconfig.features.software (
      with pkgs;
      [
        spotify
        google-chrome
        obsidian
        vlc
        webtorrent_desktop
        steam
        adw-gtk3
        nwg-look
        
      ]
    );
    
    programs.spicetify = lib.mkIf config.myconfig.features.software {
      enable = true;
      theme = spice-lib.themes.onepunch; 
      enabledExtensions = with spicetify-nix.extensions; [
        adblock
        shuffle
      ];
    };

    programs.brave = {
      enable = config.myconfig.features.software;
    };

    programs.qutebrowser = {
      enable = config.myconfig.features.software;
    };

    programs.vesktop = {
      enable = config.myconfig.features.software;
    };

    programs.opencode = {
      enable = config.myconfig.features.software;
    };

    programs.claude-code = {
      enable = config.myconfig.features.software;
    };

    home.file.".config/opencode/opencode.json" = lib.mkIf config.myconfig.features.software {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/myNixOS/stow/opencode/.config/opencode/opencode.json";
    };
  };
}
