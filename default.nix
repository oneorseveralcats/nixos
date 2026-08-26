let
  pkgs = import <nixpkgs> {};
  lib = pkgs.lib;
  nixPath = lib.concatStringsSep " " (
    lib.mapAttrsToList (k: v: lib.optionalString (lib.isAttrs v) "${k}=${v}")
    (import ./npins/default.nix)
  );
in pkgs.mkShell {
  shellHook = ''
    export NIX_PATH="nixos-config=$HOME/git/nixos/nixos/configuration.nix ${nixPath}"
  ''; 
}
