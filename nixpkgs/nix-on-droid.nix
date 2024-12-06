{ pkgs, ... }:

{
  # Read Nix-on-Droid changelog before changing this value
  system.stateVersion = "21.11";

  home-manager.config = ../home-manager/home.nix;
}
