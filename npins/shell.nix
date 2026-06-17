let
  pkgs = import <nixpkgs> {};
  lib = pkgs.lib;
  nixPath = lib.concatStringsSep " " (
    lib.mapAttrsToList (k: v: lib.optionalString (lib.isAttrs v) "${k}=${v}")
    (import ./default.nix)
  );
in pkgs.mkShell {
  shellHook = ''
    export NIX_PATH="${nixPath}"
  ''; 
}
