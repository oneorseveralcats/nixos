{ config, pkgs, lib, ... }:
{
  imports = [
    ../profiles/programming.nix
    ../profiles/testing.nix
    ../profiles/wayland.nix
  ];

  myHome.socials.thunderbird.enable = true;
}
