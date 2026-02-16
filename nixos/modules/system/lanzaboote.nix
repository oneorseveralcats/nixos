{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.system.lanzaboote;
  lanzaboote = import <lanzaboote> {};
in
{
  imports = [ lanzaboote.nixosModules.lanzaboote ]; 

  options.myConfig.system.lanzaboote = {
    enable = lib.mkEnableOption "Enable secure-boot through lanzaboote.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      sbctl
    ];

    boot.loader.systemd-boot.enable = lib.mkForce false;

    boot.lanzaboote = {
      enable = true;
      autoGenerateKeys.enable = true;
      autoEnrollKeys = {
        enable = true;
        autoReboot = true;
      };
      pkiBundle = "/var/lib/sbctl";
    };
  };
}

