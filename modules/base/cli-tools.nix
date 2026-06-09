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
        top =1;
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
      { type = "custom"; format = "══════ Sistema ══════"; }
      { type = "os";          key = " ";   keyColor = "#90CDE2"; }
      { type = "kernel";      key = " ";  keyColor = "#90CDE2"; }
      { type = "packages";    key = " ";  keyColor = "#90CDE2"; format = "{} (nix)"; }
      { type = "shell";       key = " ";  keyColor = "#90CDE2"; }
      { type = "terminal";    key = " ";  keyColor = "#90CDE2"; }
      { type = "wm";          key = " ";  keyColor = "#90CDE2"; }
      { type = "cursor";      key = " ";  keyColor = "#90CDE2"; }
      { type = "terminalfont"; key = " "; keyColor = "#90CDE2"; }
      "break"
      { type = "custom"; format = "══════ Hardware ══════"; }
      { type = "cpu";     key = " ";  keyColor = "38;2;235;219;178"; format = "{1} ({3}) @ {7} GHz"; }
      { type = "gpu";     key = "󰢮 ";  keyColor = "38;2;235;219;178"; format = "{1} {2} @ {12} GHz"; }
      { type = "memory";  key = " ";  keyColor = "38;2;235;219;178"; }
      { type = "display"; key = "󰍛 "; keyColor = "38;2;235;219;178"; }
      { type = "disk";    key = " ";  keyColor = "38;2;235;219;178"; folders = "/"; }
      { type = "uptime";  key = " ";  keyColor = "#90CDE2"; }
      { type = "media";   key = "󰝚 "; keyColor = "#90CDE2"; }
      "break"
      { type = "command";
        key = " ";
        keyColor = "38;2;198;160;246";
        text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
      }
      "break"
      { type = "colors"; key = " "; keyColor = "38;2;235;219;178"; symbol = "circle"; }
      "break"
      "break"
    ];
  };
};
}
