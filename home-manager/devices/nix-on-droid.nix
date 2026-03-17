{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    findutils
    gnugrep gnused
    ncurses
  ];

  programs.zellij.settings.default_shell = "bash";

  home.shellAliases.home-manager = "nix-on-droid";

  myHome.testing.enable = true;
  myHome.media.mpv.enable = lib.mkForce false;
}
