{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.browsers.librewolf;
in
{
  options.myHome.browsers.librewolf = {
    enable = lib.mkOption {
      description = "Enable and configure librewolf.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    myHome.browsers.tridactyl.enable = true;

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
