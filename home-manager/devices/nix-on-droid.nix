{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    gnugrep
    ncurses
  ];
}
