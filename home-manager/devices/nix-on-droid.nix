{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    gnugrep gnused
    ncurses
  ];

  myHome.media.mpv.enable = lib.mkForce false;
}
