{ lib, config, ... }:
{
  home.sessionVariables = {
    NPM_CONFIG_USERCONFIG = lib.mkForce "$HOME/.config/npm/npmrc";
    TERMINAL = "kitty";
  };

  home.sessionPath = [ "$HOME/.npm/bin" ];

  home.activation.npmUserConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/.config/npm"
    if [ ! -f "$HOME/.config/npm/npmrc" ]; then
      echo "prefix=$HOME/.npm" > "$HOME/.config/npm/npmrc"
    fi
  '';

  programs.ripgrep = {
    enable = true;
    arguments = [
      "--smart-case"
      "--hidden"
      "--glob=!.git/"
      "--glob=!node_modules/"
    ];
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Dracular";
      style = "numbers,changes,header";
      paging = "never";
    };
  };

}
