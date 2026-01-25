{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.system.printing;
in
{
  options.myConfig.system.printing = {
    enable = lib.mkEnableOption "Enable printer support.";
  };

  config = mkIf cfg.enable {
    services.avahi = {
      enable = true;
      openFirewall = true;
    };

    services.printing ={
      enable = true;
      startWhenNeeded = true;
      drivers = [ pkgs.hplip ];
    };
  };
}

