# Example of how to use the home.nix configuration in a NixOS configuration
{ config, pkgs, ... }:

{
  # Import home-manager module
  imports = [
    <home-manager/nixos>
    # or if using flakes:
    # inputs.home-manager.nixosModules.home-manager
  ];

  # Configure home-manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    
    users.crayon = { ... }: {
      imports = [ ../home.nix ];
      
      crayon = {
        username = "crayon";
        features = {
          devtools = true;
          desktop = true;
          fonts = true;
          localLinks = true;
        };
        system = {
          isCodespace = false;
          isWayland = true;
          isNoctalia = false;
        };
      };
    };
  };

  # System-level user configuration
  users.users.crayon = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.bash;
  };
}
