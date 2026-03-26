{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.desktop.others.swayosd;
in
{
  options.myHome.desktop.others.swayosd = {
    enable = lib.mkEnableOption "and configure the swayosd program.";
  };

  config = mkIf cfg.enable {
    services.swayosd = {
      enable = true;
      topMargin = 0.035;
    };
  };
}

