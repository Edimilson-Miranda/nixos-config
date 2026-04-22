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
        , useDevtools ? false
        , useDesktop ? false
        , useSoftware ? false
        , modules ? []
        }:
        let
          # Create a dynamic home configuration using the new options-based system
          homeConfig = { ... }: {
            imports = [ ./home.nix ];
            
            crayon = {
              inherit username;
              features = {
                devtools = useDevtools;
                desktop = useDesktop;
                fonts = useSoftware;
                localLinks = builtins.any (m: builtins.baseNameOf (toString m) == "local-links.nix") modules;
              };
              system = {
                isCodespace = builtins.any (m: builtins.baseNameOf (toString m) == "codespace.nix") modules;
                isWayland = builtins.any (m: builtins.baseNameOf (toString m) == "wayland.nix") modules;
                isNoctalia = builtins.any (m: builtins.baseNameOf (toString m) == "noctalia.nix") modules;
              };
            };
          };
        in
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          extraSpecialArgs = { inherit username inputs; };
          modules = [ homeConfig ];
        };
    in
    {
      homeConfigurations = {
        # Full desktop setup with all features
        "crayon@nixos" = mkHome {
          system = "x86_64-linux";
          username = "crayon";
          useDevtools = true;
          useDesktop = true;
          useSoftware = true;
          modules = [ ./modules/user/local-links.nix ];
        };

        # Full desktop setup with wayland and noctalia
        "nova@nixos" = mkHome {
          system = "x86_64-linux";
          username = "nova";
          useDevtools = true;
          useDesktop = true;
          useSoftware = true;
          modules = [ ./modules/wayland.nix ./modules/noctalia.nix ./modules/user/local-links.nix ];
        };

        # Full desktop setup
        "kaungminkhant@DESKTOP-JA8S7GL" = mkHome {
          system = "x86_64-linux";
          username = "kaungminkhant";
          useDevtools = true;
          useDesktop = true;
          useSoftware = true;
        };

        # Full desktop setup
        "crayon@nixie" = mkHome {
          system = "x86_64-linux";
          username = "crayon";
          useDevtools = true;
          useDesktop = true;
          useSoftware = true;
        };

        # WSL setup - no desktop but with dev tools
        "crayon@nixoswsl" = mkHome {
          system = "x86_64-linux";
          username = "crayon";
          useDevtools = true;
          useDesktop = false;
          useSoftware = false;
        };

        # Codespaces - CLI only with dev tools
        "vscode@codespaces" = mkHome {
          system = "x86_64-linux";
          username = "vscode";
          useDevtools = true;
          useDesktop = false;
          useSoftware = false;
          modules = [ ./modules/system/codespace.nix ];
        };
      };
    };
}
