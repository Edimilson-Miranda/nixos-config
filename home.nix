{ lib, config, pkgs, ... }:

with lib;

let
  cfg = config.crayon;
in
{
  options.crayon = {
    username = mkOption {
      type = types.str;
      description = "Username for the home directory";
    };

    homeDirectory = mkOption {
      type = types.str;
      default = "/home/${cfg.username}";
      description = "Home directory path";
    };

    stateVersion = mkOption {
      type = types.str;
      default = "25.05";
      description = "Home Manager state version";
    };

    features = {
      devtools = mkEnableOption "development tools and configurations";
      desktop = mkEnableOption "desktop applications and GUI tools";
      fonts = mkEnableOption "font packages";
      localLinks = mkEnableOption "local symlinks to dotfiles";
    };

    system = {
      isCodespace = mkEnableOption "codespace-specific configurations";
      isWayland = mkEnableOption "wayland-specific configurations";
      isNoctalia = mkEnableOption "noctalia-specific configurations";
    };
  };

  config = {
    # Base modules - always included
    imports = [
      ./modules/base/packages.nix
      ./modules/base/shell.nix
      ./modules/base/cli-tools.nix
    ] ++ optionals cfg.features.devtools [
      ./modules/features/dev-tools.nix
    ] ++ optionals cfg.features.desktop [
      ./modules/features/desktop.nix
    ] ++ optionals cfg.features.fonts [
      ./modules/fonts.nix
    ] ++ optionals cfg.features.localLinks [
      ./modules/user/local-links.nix
    ] ++ optionals cfg.system.isCodespace [
      ./modules/system/codespace.nix
    ] ++ optionals cfg.system.isWayland [
      ./modules/wayland.nix
    ] ++ optionals cfg.system.isNoctalia [
      ./modules/noctalia.nix
    ];

    home.username = cfg.username;
    home.homeDirectory = cfg.homeDirectory;
    home.stateVersion = cfg.stateVersion;

    programs.home-manager.enable = true;
  };
}
