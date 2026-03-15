#!/bin/sh

# used to generate the relevant symlinks for home-manager and nixos configs.
dir=$(git rev-parse --show-toplevel)

if [ -n "$XDG_CONFIG_HOME" ]; then
  cfg_dir="$XDG_CONFIG_HOME"
else
  cfg_dir="$HOME/.config"
fi

mkdir -p "$cfg_dir"

ln -sf "$dir/.nix-channels" "$HOME/.nix-channels"
ln -s "$dir/home-manager" "$cfg_dir/"
ln -s "$dir/nixpkgs" "$cfg_dir/"

sudo ln -s "$dir/nixos" "/etc/"

  



