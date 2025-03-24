{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    piper
  ];
  programs.i3status.modules = {
    "battery all".enable = false;
    "wireless _first_".enable = false;
  };
}
