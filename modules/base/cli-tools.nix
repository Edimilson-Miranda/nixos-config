{ lib, pkgs, config, ... }:
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

  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
        source = "~/.config/fastfetch/nixos.txt";
        padding = {
          top = 2;
          right = 6;
        };
        color."1" = "38;2;144;205;226";
      };
      display.separator = "   ";
      modules = [
        "break"
        "break"
        { type = "title"; keyWidth = 10; }
        "break"
        { type = "os";       key = "{icon} "; keyColor = "#90CDE2"; }
        { type = "kernel";   key = " ";      keyColor = "#90CDE2"; }
        { type = "packages"; key = " ";      keyColor = "#90CDE2"; format = "{} (nix)"; }
        { type = "shell";    key = " ";      keyColor = "#90CDE2"; }
        { type = "terminal"; key = " ";      keyColor = "#90CDE2"; }
        { type = "wm";       key = " ";      keyColor = "#90CDE2"; }
        { type = "disk";     key = "󰉉 ";     keyColor = "38;2;235;219;178"; folders = "/"; }
        { type = "memory";   key = " ";      keyColor = "38;2;235;219;178"; }
        { type = "uptime";   key = " ";      keyColor = "#90CDE2"; }
        { type = "media";    key = "󰝚 ";     keyColor = "#90CDE2"; }
        { type = "colors";   key = " ";      keyColor = "38;2;235;219;178"; symbol = "circle"; }
        "break"
        "break"
      ];
    };
  };

}
