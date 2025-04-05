{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.flatpak;
in
{
  options.myConfig.flatpak = {
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

