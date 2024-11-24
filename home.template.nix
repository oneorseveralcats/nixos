{ config, pkgs, lib, ... }:

{
  home.username = "user";
  home.homeDirectory = "/home/user";
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "libretro-genesis-plus-gx"
    "steam" "steam-original" "steam-run"
    "terraria-server"
    "unrar"
    "zerotierone"
  ];

  imports = [
    ./modules
    ./pkgs

    # uncomment or add the correct device
    # ./devices/desktop.nix
    # ./devices/primary.nix
    # ./devices/pbp.nix
    # ./devices/t470s.nix
  ];

  # original nixos version
  home.stateVersion = "21.11";
}
