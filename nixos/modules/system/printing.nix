{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.printing;
in
{
  options.myConfig.printing = {
    enable = lib.mkOption {
      description = "Enable printer support.";
      type = types.bool;
      default = true;
    };
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

