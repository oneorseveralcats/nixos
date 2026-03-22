{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.desktop.others.swayidle;
in
{
  options.myHome.desktop.others.swayidle = {
    enable = lib.mkEnableOption "and configure the swayidle service.";
  };

  config = mkIf cfg.enable {
    myHome.desktop.others.swaylock.enable = true;

    services.swayidle = {
      enable = true;
      events = [
        { 
          event = "before-sleep"; 
          command = "${pkgs.playerctl}/bin/playerctl pause; ${pkgs.swaylock}/bin/swaylock";
        }
        { 
          event = "lock"; 
          command = "${pkgs.swaylock}/bin/swaylock";
        }
      ];
      timeouts = [
        { 
          timeout = 3600; 
          command = "${pkgs.swaylock}/bin/swaylock";
        }
        { 
          timeout = 3660;
          command = "${pkgs.sway}/bin/swaymsg 'output * power off'";
          resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * power on'";
        }
      ];
    };

  };
}
