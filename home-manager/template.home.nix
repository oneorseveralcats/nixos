{ config, pkgs, lib, ... }:

{
  home.username = lib.mkDefault "user";
  home.homeDirectory = lib.mkDefault "/home/user";
  programs.home-manager.enable = true;

  imports = [
    ./modules
    ./pkgs

    ./profiles/base.nix

    # uncomment or add the correct device
    # ./devices/desktop.nix
    # ./devices/primary.nix
    # ./devices/pbp.nix
    # ./devices/server.nix
    # ./devices/t470s.nix
    # ./devices/nix-on-droid.nix
  ];

  # original nixos version
  home.stateVersion = "21.11";
}
