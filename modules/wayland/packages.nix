{ lib, config, pkgs, ... }:
{
  home.packages = lib.optionals config.myconfig.features.desktop (with pkgs; [
    # Terminal
    alacritty

    # Launcher
    fuzzel

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
  ]);
}
