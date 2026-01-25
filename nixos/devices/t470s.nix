{ config, pkgs, ... }:
{
  imports = [
    <nixos-hardware/lenovo/thinkpad/t470s>

    ../profiles/desktop.nix
    ../profiles/print_scan.nix
    ../profiles/virtualization.nix
  ];

  myConfig.boot-amd64.enable = true;

  networking.hostName = "t470s";
}
