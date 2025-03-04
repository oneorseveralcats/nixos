#!/bin/sh

dir=$(readlink -f "$(dirname "$0")")

if [ -z "$XDG_CONFIG_HOME" ]; then
  cfg_dir="$XDG_CONFIG_HOME"
else
  cfg_dir="$HOME/.config"
fi

mkdir -p "$cfg_dir"

ln -s "$dir/home-manager" "$cfg_dir/"
ln -s "$dir/nixpkgs" "$cfg_dir/"
ln -s "$dir/nixos" "/etc/"

  



