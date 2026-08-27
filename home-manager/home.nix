{ config, pkgs, lib, ... }:

{
  imports = [
    ./modules
    ./pkgs

    ./profiles/base.nix
  ];

  programs.home-manager.enable = true;
  home.username = lib.mkDefault "user";
  home.homeDirectory = lib.mkDefault "/home/user";
  
  home.stateVersion = "26.05";
}
