{
  config,
  pkgs,
  username,
  ...
}:
{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    # Utilities
    git
    curl
    wget
    fastfetch
    fzf
    fd
    nh
    ripgrep
    bat
    gcc
    gnumake
    unzip
  ];

  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        pageSize = 20;
        scrollHeight = 2;
        theme = {
          activeBorderColor = ["blue" "bold"];
          inactiveBorderColor = ["white"];
        };
      };
    };
  };

  programs.bash = {
    enable = true;
    # This makes login shells also source .bashrc
    profileExtra = "if [ -f \"$HOME/.bashrc\" ]; then . \"$HOME/.bashrc\"; fi";
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    options = [
      "--cmd cd"
    ];
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    git = true;
    icons = "auto";
    extraOptions = [
      "--long"
      "--all"
    ];
  };

  programs.gh = {
    enable = true;
    settings = {
      editor = "nvim";
      git_protocol = "ssh";
    };
    gitCredentialHelper.enable = true;
  };

  programs.gh-dash.enable = true;

  home.shellAliases = {
    ll = "eza -l";
    la = "eza -a";
    lt = "eza --tree";
    hh = "home-manager switch --flake .";
  };
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      imagemagick
    ];
  };
  home.file.".config/nvim" = {
    source = ./nvim/.config/nvim;
    recursive = true;
  };
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs.home-manager.enable = true;
}
