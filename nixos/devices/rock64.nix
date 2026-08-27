{ config, pkgs, ... }:
{
  imports = [
    ../hardware-configuration/rock64.nix

    ../configuration.nix
  ];

  networking.hostName = "rock64";

  boot.loader = {
    grub.enable = false;
    generic-extlinux-compatible.enable = true;
  };   
}
