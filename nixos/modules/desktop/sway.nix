{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.desktop.sway;
in
{
  options.myConfig.desktop.sway = {
    enable = lib.mkEnableOption "Enable system settings for the sway home-manager module to work properly";
  };

  config = mkIf cfg.enable {
    hardware.graphics.enable = true;
    security.pam.services.swaylock = {};
  };
}

