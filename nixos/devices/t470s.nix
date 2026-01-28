{ config, pkgs, ... }:
{
  imports = [
    <nixos-hardware/lenovo/thinkpad/t470s>

    ../profiles/desktop.nix
    ../profiles/print_scan.nix
    ../profiles/virtualization.nix
  ];

  boot.loader.systemd-boot.enable = true;

  networking.hostName = "t470s";
}
