{
  pkgs,
  ...
}:
{
  home.file = {
    ".config/nvim" = {
      source = ../nvim/.config/nvim;
      recursive = true;
    };
    ".config/starship.toml" = {
      source = ../starship/.config/starship.toml;
    };
    ".tmux.conf" = {
      source = ../tmux/.tmux.conf;
    };
  };
  programs.git = {
    enable = true;
    settings = {
      extraConfig = {
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        pull.rebase = true;
      };
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
  # home.packages = with pkgs; [
  #   nil
  #   nixfmt-rfc-style
  # ];
}
