{ config, inputs, pkgs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t470s
    ../hardware-configuration/t470s.nix

    ../configuration.nix

    ../profiles/desktop.nix
    ../profiles/print_scan.nix
    ../profiles/virtualization.nix
  ];

  networking.hostName = "t470s";
}
