{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.browsers.floorp;
in
{
  options.myHome.browsers.floorp = {
    enable = lib.mkEnableOption "Enable and configure floorp.";
  };

  config = mkIf cfg.enable {
    programs.floorp = {
      enable = true;
      nativeMessagingHosts = with lib; [
        ff2mpv
        vdhcoapp
        tridactyl-native
      ];
    };
  };
}


