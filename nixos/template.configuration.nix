{ config, pkgs, ... }:

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

  system.stateVersion = "21.11";
}
