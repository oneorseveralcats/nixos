{ config, pkgs, lib, ... }:

{
  imports = [
    ../profiles/games.nix
    ../profiles/programming.nix
    ../profiles/socials.nix
    ../profiles/wayland.nix
    ../profiles/vpn.nix
  ];
}
