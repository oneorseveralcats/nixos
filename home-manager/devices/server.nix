{ config, pkgs, lib, ... }:
{
  imports = [
    ../profiles/programming.nix
  ];

  home.packages = with pkgs; [
  ];
}
