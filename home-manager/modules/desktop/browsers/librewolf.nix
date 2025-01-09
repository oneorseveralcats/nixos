{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.desktop.browsers.librewolf;
in
{
  options.myHome.desktop.browsers.librewolf = {
    enable = lib.mkOption {
      description = "Enable and configure librewolf.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.librewolf = {
      enable = true;
      nativeMessagingHosts = with pkgs; [
        ff2mpv
        vdhcoapp
        tridactyl-native
      ];
    };
  };
}
