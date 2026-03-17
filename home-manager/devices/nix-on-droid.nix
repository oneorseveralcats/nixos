{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    gnugrep
    ncurses
  ];

  myHome.media.mpv.enable = lib.mkForce false;
}
