
{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.desktop.others.wob;
in
{
  options.myHome.desktop.others.wob = {
    enable = lib.mkEnableOption "and configure wob.";
  };

  config = mkIf cfg.enable {
    services.wob = {
      enable = true;
    };
  };
}

