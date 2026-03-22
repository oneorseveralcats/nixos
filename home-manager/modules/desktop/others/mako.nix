{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.desktop.others.mako;
in
{
  options.myHome.desktop.others.mako = {
    enable = lib.mkEnableOption "and configure the mako notification service.";
  };

  config = mkIf cfg.enable {
    services.mako = {
      enable = true;
      settings = {
        default-timeout = 15000;
        width = 500;
        height = 500;
        border-size = 2;
      };
    };
  };
}
