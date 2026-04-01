{
  description = "Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      mkHome =
        {
          system,
          username,
          modules ? [ ],
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          # Pass the username to be used inside home.nix
          extraSpecialArgs = { inherit username; };
          # Combine the base home.nix with any extra modules
          modules = [ ./home.nix ] ++ modules;
        };
    in
    {
      homeConfigurations = {
        "kaungminkhant@DESKTOP-JA8S7GL" = mkHome {
          system = "x86_64-linux";
          username = "kaungminkhant";
        };
        "crayon@nixie" = mkHome {
          system = "x86_64-linux";
          username = "crayon";
        };
      };
    };
}
