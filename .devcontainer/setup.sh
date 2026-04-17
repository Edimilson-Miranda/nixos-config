#!/usr/bin/env bash
set -euo pipefail
export NIX_CONFIG="experimental-features = nix-command flakes"
if ! command -v home-manager >/dev/null 2>&1; then
  nix profile install github:nix-community/home-manager
fi
home-manager switch --flake ".#vscode@codespaces -b hmbackup"
