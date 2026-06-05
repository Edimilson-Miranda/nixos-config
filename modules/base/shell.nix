{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      size = 10000;
      save = 10000;
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };

    initExtra = ''
      [ -f "$HOME/.secrets" ] && source "$HOME/.secrets"

      ai() {
        if [[ $# -eq 0 ]]; then
          echo "Usage: ai <description>" >&2
          return 1
        fi
        local result
        result=$("${config.home.homeDirectory}/myNixOS/scripts/ai-cmd" "$@") || return 1
        local edited
        read -e "$ " edited < /dev/tty
        vared -p "$ " -c edited
        if [[ -n "$edited" ]]; then
          print -s "$edited"
          eval "$edited"
        fi
      }
    '';
  };

  programs.npm = {
    enable = true;
    settings = {
      prefix = "\${HOME}/.npm";
    };
  };

  programs.carapace = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd cd"
    ];
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file.".config/starship.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/myNixOS/stow/starship/.config/starship.toml";
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
    icons = "auto";
    extraOptions = [
      "--long"
      "--all"
    ];
  };

  home.shellAliases = {
    ll = "eza -l";
    la = "eza -a";
    lt = "eza --tree";
    listallusers = "bash ${config.home.homeDirectory}/myNixOS/scripts/listallusers.sh";

    # Home-manager
    hh = "home-manager switch --flake .";
    hhr = "home-manager switch --flake . && gnome-session-quit --logout";

    # NixOS configuration
    seconfig = "cd /etc/nixos && sudoedit /etc/nixos/configuration.nix";
    seflake = "cd /etc/nixos && sudoedit /etc/nixos/flake.nix";
    osbuild = "cd /etc/nixos && sudo nixos-rebuild switch --flake .";

    # edit
    edot = "cd ~/myNixOS && nvim .";

    kilo = "npx -y --package @kilocode/cli@7.1.2 kilo";
    nvim-fresh = "rm -rf ~/.local/share/nvim/lazy ~/.local/share/nvim/site ~/.cache/nvim && nvim";
  };
}
