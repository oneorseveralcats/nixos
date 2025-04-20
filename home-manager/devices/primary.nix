{ config, pkgs, lib, ... }:

{
  imports = [
    ../profiles/wayland.nix
    ../profiles/socials.nix
  ];
}
