{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.sway;
in
{
  options.myConfig.sway = {
    enable = lib.mkOption {
      description = "Enable system settings for sway home-manager module to work properly";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    hardware.graphics.enable = true;
    security.pam.services.swaylock = {};
  };
}

