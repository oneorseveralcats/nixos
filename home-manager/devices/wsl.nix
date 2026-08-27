{ config, pkgs, lib, ... }:
{
  imports = [
    ../home.nix

    ../profiles/programming.nix
  ];
}
