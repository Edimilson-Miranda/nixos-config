{
  lib,
  config,
  pkgs,
  ...
}:
{
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

    programs.wezterm = {
      enable = true;
      enableBashIntegration = false;
    };

    home.file.".wezterm.lua" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/myNixOS/stow/wezterm/.wezterm.lua";
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
      ]
    );
    
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
