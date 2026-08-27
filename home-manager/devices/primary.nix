{ config, pkgs, lib, ... }:

{
  imports = [
    ../home.nix

    ../profiles/games.nix
    ../profiles/programming.nix
    ../profiles/socials.nix
    ../profiles/testing.nix
    ../profiles/wayland.nix
  ];
}
