{ config, pkgs, lib, ... }:
{
  imports = [
    ../profiles/games.nix
    ../profiles/programming.nix
    ../profiles/socials.nix
    ../profiles/wayland.nix
  ];

  home.packages = with pkgs; [
    piper
  ];
  programs.i3status.modules = {
    "battery all".enable = false;
    "wireless _first_".enable = false;
  };

}
