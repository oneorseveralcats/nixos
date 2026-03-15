#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash jq

# Script to generate .nix-channels file. This is mainly useful to make the
# initial nixos/home-manager install on a device possible. After that it will
# only rely on the npins sources.
git_root=$(git rev-parse --show-toplevel)

exec jq -r '.pins | to_entries[] | .value.url + " " + .key' "${git_root}/npins/sources.json" > "${git_root}/.nix-channels"
