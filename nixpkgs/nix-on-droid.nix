{ lib, pkgs, ... }:
let
  npinsPaths = lib.mapAttrsToList (k: v: "${k}=${v}") (import ../npins);
in {
  android-integration = {
    termux-open.enable = true;
    termux-open-url.enable = true;
    termux-reload-settings.enable = true;
    termux-setup-storage.enable = true;
    xdg-open.enable = true;
  };

  nix.nixPath = npinsPaths;

  home-manager.config = ../home-manager/home.nix;
  system.stateVersion = "21.11";
}
