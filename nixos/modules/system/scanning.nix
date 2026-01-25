{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.system.scanning;
in
{
  options.myConfig.system.scanning = {
    enable = lib.mkEnableOption "Enable scanner support.";
  };

  config = mkIf cfg.enable {
    hardware.sane = {
      enable = true;
      brscan5.enable = true;
    };
  };
}


