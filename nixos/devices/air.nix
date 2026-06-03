{ config, lib, pkgs, ... }:
{
  imports = [
    <nixos-hardware/apple/macbook-air/7>

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
