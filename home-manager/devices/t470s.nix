{ config, pkgs, lib, ... }:
{
  imports = [
    ../home.nix

    ../profiles/programming.nix
    ../profiles/testing.nix
    ../profiles/wayland.nix
  ];

  myHome.socials.thunderbird.enable = true;
}
