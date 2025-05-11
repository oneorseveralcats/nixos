{ config, pkgs, lib, ... }:

{
  imports = [
    ../profiles/programming.nix
    ../profiles/socials.nix
    ../profiles/wayland.nix
    ../profiles/vpn.nix
  ];
}
