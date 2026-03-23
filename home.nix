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
    # profileExtra = "if [ -f \"$HOME/.bashrc\" ]; then . \"$HOME/.bashrc\"; fi";
    initExtra = ''
      # Enables zoxide's own 'z' command and database tracking
      eval "$(zoxide init bash)"
      # Custom function to gracefully override 'cd'
      cd() {
        # Try to use zoxide's smart search first.
        # The '-e' flag makes zoxide echo the path instead of cd-ing to it.
        # The '2>/dev/null' suppresses errors if zoxide finds no match.
        local new_dir
        new_dir=$(zoxide query "$@" 2>/dev/null)
        if [ -n "$new_dir" ]; then
          # If zoxide found a directory, go there
          builtin cd "$new_dir"
        else
          # Otherwise, use the standard 'cd' command
          builtin cd "$@"
        fi
      }
    '';
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
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
