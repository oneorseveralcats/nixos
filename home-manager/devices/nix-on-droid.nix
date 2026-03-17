{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    findutils
    gnugrep gnused
    ncurses
    openssh
    procps
  ];

  home.shellAliases.home-manager = "nix-on-droid";

  programs.zellij.settings.default_shell = "bash";

  myHome.testing.enable = true;
  myHome.media.mpv.enable = lib.mkForce false;
}
