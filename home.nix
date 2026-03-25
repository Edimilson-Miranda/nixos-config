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
    curl
    wget
    fastfetch
    fzf
    fd
    nh
    ripgrep
    gcc
    gnumake
    unzip
    rustc
    cargo
  ];

  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        pageSize = 20;
        scrollHeight = 2;
        theme = {
          activeBorderColor = [
            "blue"
            "bold"
          ];
          inactiveBorderColor = [ "white" ];
        };
      };
      git = {
        autoFetch = true;
        branch = {
          logOrder = "date-order";
        };
      };
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "crayonnova";
        email = "kaungminkhant.dev@gmail.com";
      };
      alias = {
        # co = "checkout";
        # ci = "commit";
        # st = "status";
        # br = "branch";
        # lg = "log --oneline --graph";
      };
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
        push = {
          autoSetupRemote = true;
        };
        pull = {
          rebase = true;
        };
      };
    };
  };

  programs.ripgrep = {
    enable = true;
    arguments = [
      "--smart-case"
      "--hidden"
      "--glob=!.git/"
      "--glob=!node_modules/"
    ];
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Dracular";
      style = "numbers,changes,header";
      paging = "never";
    };
  };
  programs.bash = {
    enable = true;
    historyControl = [
      "ignoredups"
      "ignorespace"
    ];
    historyFileSize = 10000;
    historySize = 10000;
    shellOptions = [
      "histappend"
      "checkwinsize"
      "extglob"
      "globstar"
    ];

    profileExtra = ''
      if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
      fi
    '';
    initExtra = "";
  };

  programs.tmux = {
    enable = true;
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
  home.file = {
    ".config/nvim" = {
      # source = ~/dotfiles/nvim/.config/nvim;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim/.config/nvim";
      recursive = true;
    };

    ".config/starship.toml" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/starship/.config/starship.toml";
    };
    ".tmux.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/tmux/.tmux.conf";
    };
  };
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs.home-manager.enable = true;
}
