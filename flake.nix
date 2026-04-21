{
  description = "Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ nixpkgs, home-manager, ... }:
    let
      mkHome =
        { system
        , username
        , modules ? [
            ./modules/local-links.nix
          ]
        ,
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          # Pass the username to be used inside home.nix
          extraSpecialArgs = { inherit username inputs; };
          # Combine the base home.nix with any extra modules
          modules = [ ./home.nix ] ++ modules;
        };
    in
    {
      homeConfigurations = {
        "crayon@nixos" = mkHome {
          system = "x86_64-linux";
          username = "crayon";
        };

        "nova@nixos" = mkHome {
          system = "x86_64-linux";
          username = "nova";
          modules = [ ./modules/wayland.nix ./modules/noctalia.nix ./modules/local-links.nix ];
        };

        "kaungminkhant@DESKTOP-JA8S7GL" = mkHome {
          system = "x86_64-linux";
          username = "kaungminkhant";
        };

        "crayon@nixie" = mkHome {
          system = "x86_64-linux";
          username = "crayon";
        };

        "crayon@nixoswsl" = mkHome {
          system = "x86_64-linux";
          username = "crayon";
        };
        "vscode@codespaces" = mkHome {
          system = "x86_64-linux";
          username = "vscode";
          modules = [ ./modules/codespace.nix ];
        };
      };
    };
}
