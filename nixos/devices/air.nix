{ config, inputs, lib, pkgs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.apple-macbook-air-7
    ../hardware-configuration/air.nix

    ../configuration.nix

    ../profiles/desktop.nix
    ../profiles/games.nix
    ../profiles/print_scan.nix
    ../profiles/virtualization.nix
  ];

  networking.hostName = "air";
  nixpkgs.config = {
    # allowUnfreePackages = [ "broadcom_sta" ];
    permittedInsecurePackages = [ "broadcom_sta" ];
  };

  boot = {
    kernelModules = [ "wl" ];
    kernelParams = [ "hid_apple.swap_opt_cmd=1" ];
    initrd.kernelModules = [ "wl" ];
    extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  };

  # myConfig.system.lanzaboote.enable = true;
}
