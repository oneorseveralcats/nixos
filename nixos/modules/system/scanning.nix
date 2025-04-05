{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.system.scanning;
in
{
  options.myConfig.system.scanning = {
    enable = lib.mkOption {
      description = "Enable scanner support.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    hardware.sane = {
      enable = true;
      brscan5.enable = true;
    };
  };
}


