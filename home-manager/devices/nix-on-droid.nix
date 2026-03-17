{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    findutils
    gnugrep gnused
    ncurses
  ];

  myHome.media.mpv.enable = lib.mkForce false;
}
