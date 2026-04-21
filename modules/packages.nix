{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Development Tools
    curl
    wget
    gcc
    gnumake
    unzip
    rustc
    cargo
    uv
    nodejs_24
    tree-sitter
    biome
    aider-chat-full

    # System Utilities
    fastfetch
    fzf
    fd
    nh
    ripgrep
    btop
    lsof

    # Fonts
    cascadia-code
    nerd-fonts.jetbrains-mono
    inter
    noto-fonts
    noto-fonts-color-emoji

    # Applications
    spotify
    google-chrome
    obsidian
    vlc
    webtorrent_desktop
    wootility

    # Desktop Environment
    xwayland-satellite
    cosmic-wallpapers
    gnome-control-center
    pavucontrol
    playerctl
    brightnessctl
    gnomeExtensions.cloudflare-warp-toggle
  ];
}
