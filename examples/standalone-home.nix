# Example of how to use home.nix as a standalone configuration
{ ... }:

{
  imports = [ ../home.nix ];
  
  crayon = {
    username = "crayon";
    features = {
      devtools = true;
      desktop = false;  # CLI-only setup
      fonts = false;
      localLinks = false;
    };
    system = {
      isCodespace = true;
      isWayland = false;
      isNoctalia = false;
    };
  };
}
