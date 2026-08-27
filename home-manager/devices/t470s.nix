{ config, pkgs, lib, ... }:
{
  imports = [
    ../home.nix

    ../profiles/programming.nix
    ../profiles/testing.nix
    ../profiles/wayland.nix
  ];

  home.username = "user";
  home.homeDirectory = "/home/user";

  myHome.socials.thunderbird.enable = true;
}
