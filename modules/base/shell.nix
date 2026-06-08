{ config, pkgs, lib, ... }:
{
  programs.fish = {
  enable = true;

  interactiveShellInit = ''
    set -g fish_greeting
 
    if test -f "$HOME/.secrets"
      source "$HOME/.secrets"
    end

    function ai
      if test (count $argv) -eq 0
        echo "Usage: ai <description>" >&2
        return 1
      end

      set result ("${config.home.homeDirectory}/myNixOS/scripts/ai-cmd" $argv)
      or return 1

      echo $result
    end
    '';
  };
  

  #npm config
  programs.npm = {
    enable = true;
    settings = {
      prefix = "$HOME/.npm-global";
    };
  };
  home.file.".npm-global/.keep".text = "";

  programs.carapace = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = [
      "--cmd cd"
    ];
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  home.file.".config/starship.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/myNixOS/stow/starship/.config/starship.toml";
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
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
    listallusers = "${config.home.homeDirectory}/myNixOS/scripts/listallusers.sh";

    # Home-manager
    rebuild = "cd myNixOS/ && sudo nixos-rebuild switch --flake .#nixos";
    update = "cd myNixOS/ && sudo nix flake update && sudo nixos-rebuild switch --flake .#nixos";
    cleanup = "sudo nix-collect-garbage -d";
    hhr = "home-manager switch --flake . && gnome-session-quit --logout";
    programs.fish.functions.hh = ''
      cd ~/myNixOS
      nix run home-manager -- switch --flake .#miranda@nixos $argv
    '';

    # NixOS search
    ns = "nix search nixpkgs";
    nsh = "nix shell nixpkgs";

    # edit nvim
    vi = "cd ~/myNixOS && nvim .";

    kilo = "npx -y --package @kilocode/cli@7.1.2 kilo";
    nvim-fresh = "rm -rf ~/.local/share/nvim/lazy ~/.local/share/nvim/site ~/.cache/nvim && nvim";
  };
}
