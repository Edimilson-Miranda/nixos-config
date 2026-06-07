{
  description = "NixOS System and Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
    noctalia.url = "github:noctalia-dev/noctalia-shell";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      # 1. Configuração do Sistema (NixOS)
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.miranda = {
              imports = [ ./home.nix ];
              config.myconfig.username = "miranda";
            };
          }
        ];
      };

      # 2. Configuração apenas do Home Manager (opcional, para testes rápidos)
      homeConfigurations."miranda@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;  # <- isso resolve o spotify
        };
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home.nix ./users/miranda.nix ./profiles/desktop.nix ];
      };
    };
}
