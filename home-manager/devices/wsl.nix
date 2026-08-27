{ config, pkgs, lib, ... }:
{
  imports = [
    ../home.nix

    ../profiles/programming.nix
  ];

  home.username = "user";
  home.homeDirectory = "/home/user";
}
