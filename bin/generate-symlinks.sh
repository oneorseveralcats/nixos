#!/bin/sh

# used to generate the relevant symlinks for home-manager and nixos configs.
git_root=$(git rev-parse --show-toplevel)

if [ -n "$XDG_CONFIG_HOME" ]; then
  cfg_dir="$XDG_CONFIG_HOME"
else
  cfg_dir="$HOME/.config"
fi

mkdir -p "$cfg_dir"

ln -sf "$git_root/.nix-channels" "$HOME/.nix-channels"
ln -s "$git_root/home-manager" "$cfg_dir/"
ln -s "$git_root/nixpkgs" "$cfg_dir/"

sudo ln -s "$git_root/nixos" "/etc/"

  



