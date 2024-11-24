{ config, pkgs, ... }:

let
  unstableTarball =
    fetchTarball
      "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
in
{
  imports = [
      ./hardware-configuration.nix
      ./modules

      # Uncomment the correct device
      # ./devices/primary.nix
      # ./devices/desktop.nix
      # ./devices/labtop.nix
      # ./devices/rock64.nix
      # ./devices/pbp.nix
      # ./devices/t470s.nix
  ];

  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };

  system.stateVersion = "21.11";
}
