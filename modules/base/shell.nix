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

    initContent = ''
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
    listallusers = "zsh ${config.home.homeDirectory}/myNixOS/scripts/listallusers.sh";

    # Home-manager
    rebuild = "cd myNixOS/ && sudo nixos-rebuild switch --flake .#nixos";
    update = "cd / myNixOS/ && sudo nix flake update && sudo nixos-rebuild switch --flake .#nixos";
    hh = "cd myNixOS/ && home-manager switch --flake .#miranda@nixos";
    cleanup = "sudo nix-collect-garbage -d";
    hhr = "home-manager switch --flake . && gnome-session-quit --logout";

    # NixOS search
    ns = "nix search nixpkgs";
    nsh = "nix shell nixpkgs";

    # edit nvim
    vi = "cd ~/myNixOS && nvim .";

    kilo = "npx -y --package @kilocode/cli@7.1.2 kilo";
    nvim-fresh = "rm -rf ~/.local/share/nvim/lazy ~/.local/share/nvim/site ~/.cache/nvim && nvim";
  };
}
