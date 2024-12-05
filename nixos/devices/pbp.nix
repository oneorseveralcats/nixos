{ config, pkgs, ... }:
{
  imports = 
    [
      <nixos-hardware/pine64/pinebook-pro>
    ];

  networking.hostName = "pbp";

  boot.loader = {
    efi.canTouchEfiVariables = false;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
  };   
}
