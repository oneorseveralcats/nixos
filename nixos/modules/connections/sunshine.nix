{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.connections.sunshine;
in
{
  options.myConfig.connections.sunshine = {
    enable = lib.mkEnableOption "Sunshine, an opensource implementation of nvidia game streaming";
  };

  config = mkIf cfg.enable {
    services.sunshine = {
      enable = true;    
      capSysAdmin = true;
      openFirewall = true;
    };
  };
}


