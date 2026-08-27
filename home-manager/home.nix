{ config, pkgs, lib, ... }:

{
  imports = [
    ./modules
    ./pkgs

    ./profiles/base.nix
  ];

  programs.home-manager.enable = true;
  
  home.stateVersion = "26.05";
}
