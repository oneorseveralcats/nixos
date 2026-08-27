{ config, pkgs, lib, ... }:
{
  imports = [
    ../home.nix
  ];

  home.username = "user";
  home.homeDirectory = "/home/user";
}
