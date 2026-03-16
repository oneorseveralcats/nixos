{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    coreutils
    ncurses
  ];
}
