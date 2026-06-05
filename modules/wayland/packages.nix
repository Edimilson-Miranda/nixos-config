{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.myconfig.features.desktop {
  home.file.".config/alacritty/alacritty.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/myNixOS/stow/alacritty/.config/alacritty/alacritty.toml";
  };

  home.file.".config/ghostty/config.ghostty" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/myNixOS/stow/ghostty/.config/ghostty/config.ghostty";
  };

  home.file.".config/fuzzel/fuzzel.ini" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/myNixOS/stow/fuzzel/.config/fuzzel/fuzzel.ini";
  };

  home.file.".config/niri/config.kdl" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/myNixOS/stow/niri/.config/niri/config.kdl";
  };

  home.packages = with pkgs; [
    # Terminal
    alacritty
    kitty
    ghostty

    # Launcher
    xdg-utils

    # Lock/idle/wallpaper
    swaylock
    swayidle
    swaybg

    # Notifications
    mako

    # Screenshot/region
    grim
    slurp

    # Clipboard
    wl-clipboard
    cliphist
  ];
}
