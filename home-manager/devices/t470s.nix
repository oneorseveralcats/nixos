{ config, pkgs, lib, ... }:
{
  imports = [
    ../profiles/programming.nix
    ../profiles/wayland.nix
  ];

  myHome.socials.thunderbird.enable = true;

  home.packages = with pkgs; [
  ];
}
