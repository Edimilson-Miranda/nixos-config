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

  "display": {
    "separator": " ",
  },
  "modules": [
    {
      "type": "title",
      "keyWidth": 10,
    },
    {
      "type": "custom",
      "format": "══════ Sistema ══════",
    },
    {
      "type": "os",
      "key": " ",
      "keyColor": "34", // = color4
    },
    {
      "type": "kernel",
      "key": " ",
      "keyColor": "34",
    },
    {
      "type": "packages",
      "format": "{} (nix)",
      "key": " ",
      "keyColor": "34",
    },
    {
      "type": "shell",
      "key": " ",
      "keyColor": "34",
    },
    {
      "type": "terminal",
      "key": " ",
      "keyColor": "34",
    },
    {
      "type": "wm",
      "key": " ",
      "keyColor": "34",
    },
    {
      "type": "cursor",
      "key": " ",
      "keyColor": "34",
    },
    {
      "type": "terminalfont",
      "key": " ",
      "keyColor": "34",
    },
    {
      "type": "break",
    },
    {
      "type": "custom",
      "format": "══════ Hardware ══════",
    },
    {
      "type": "cpu",
      "format": "{1} ({3}) @ {7} GHz",
      "key": " ",
      "keyColor": "33",
    },
    {
      "type": "gpu",
      "format": "{1} {2} @ {12} GHz",
      "key": "󰢮 ",
      "keyColor": "33",
    },
    {
      "type": "memory",
      "key": " ",
      "keyColor": "33",
    },
    {
      "type": "display",
      "key": "󰍛 ",
      "keyColor": "green",
    },
    {
      "type": "disk",
      "key": " ",
      "keyColor": "green",
    },
    {
      "type": "command",
      "key": " ",
      "keyColor": "magenta",
      "text": "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days",
    },
  ],
}
}
