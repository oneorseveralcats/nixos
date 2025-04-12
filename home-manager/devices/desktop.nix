{ config, pkgs, lib, ... }:
{
  imports = [
    ../profiles/wayland.nix
  ];

  home.packages = with pkgs; [
    piper
  ];
  programs.i3status.modules = {
    "battery all".enable = false;
    "wireless _first_".enable = false;
  };

  myHome.socials.enable = true;
}
