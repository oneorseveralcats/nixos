{ config, pkgs, lib, ... }:
{
  imports = [
    ../profiles/programming.nix
    ../profiles/wayland.nix
  ];

  home.packages = with pkgs; [
  ];
}
