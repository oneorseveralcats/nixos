{ config, pkgs, lib, ... }:

{
  imports = [
    ../profiles/games.nix
    ../profiles/programming.nix
    ../profiles/socials.nix
    ../profiles/testing.nix
    ../profiles/wayland.nix
  ];
}
