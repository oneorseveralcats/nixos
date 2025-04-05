{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.system.flatpak;
in
{
  options.myConfig.system.flatpak = {
    enable = mkOption {
      description = "Enable flatpak support.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    services.flatpak.enable = true;
    xdg.portal.wlr.enable = true;
    xdg.portal.config.common.default = "*";
  };
}

