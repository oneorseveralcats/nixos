{ config, pkgs, lib, ... }:

{
  imports = [
    ./modules
    ./pkgs

    ./profiles/base.nix
  ];

  programs.home-manager.enable = true;
  home.username = "user";
  home.homeDirectory = "/home/user";
  
  home.stateVersion = "26.05";
}
