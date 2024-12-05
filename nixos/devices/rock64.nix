{ config, pkgs, ... }:
{
  networking.hostName = "rock64";

  boot.loader = {
    grub.enable = false;
    generic-extlinux-compatible.enable = true;
  };   
}
