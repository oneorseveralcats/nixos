{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.desktop.others.avizo;
in
{
  options.myHome.desktop.others.avizo = {
    enable = lib.mkEnableOption "and configure the avizo volume and brightness notification program.";
  };

  config = mkIf cfg.enable {
    services.avizo = {
      enable = true;
      settings = with config.lib.stylix.colors; {
        default = {
          time = 1.0;
          y-offset = 0.25;
          background = "rgba(160, 160, 160, 0.8)";
          border-color = "rgba(90, 90, 90, 0.8)";
          bar-fg-color = "rgba(0, 0, 0, 0.8)";
        };
      };
    };
  };
}


