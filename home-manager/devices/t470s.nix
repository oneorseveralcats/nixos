{ config, pkgs, lib, ... }:
{
  imports = [
    ../profiles/wayland.nix
  ];

  home.packages = with pkgs; [
  ];
}
