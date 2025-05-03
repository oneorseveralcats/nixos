{ config, pkgs, lib, ... }:

{
  imports = [
    ../profiles/programming.nix
    ../profiles/socials.nix
    ../profiles/wayland.nix
  ];
}
