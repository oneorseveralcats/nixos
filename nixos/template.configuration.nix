{ config, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
      ./modules

      ./profiles/base.nix

      # Uncomment the correct device
      # ./devices/primary.nix
      # ./devices/desktop.nix
      # ./devices/rock64.nix
      # ./devices/server.nix
      # ./devices/t470s.nix
      # ./devices/wsl.nix
  ];

  system.stateVersion = "21.11";
}
