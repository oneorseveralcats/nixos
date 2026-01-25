{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.system.flatpak;
in
{
  options.myConfig.system.flatpak = {
    enable = mkEnableOption "Enable flatpak support.";
  };

  config = mkIf cfg.enable {
    services.flatpak.enable = true;
    xdg.portal.wlr.enable = true;
    xdg.portal.config.common.default = "*";
  };
}

