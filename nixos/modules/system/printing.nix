{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.print_scan;
in
{
  options.myConfig.print_scan = {
    enable = lib.mkOption {
      description = "Enable printer and scanner support for models that I own.";
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

    hardware.sane = {
      enable = true;
      brscan5.enable = true;
    };
  };
}

