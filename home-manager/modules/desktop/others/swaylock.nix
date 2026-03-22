{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.desktop.others.swaylock;
in
{
  options.myHome.desktop.others.swaylock = {
    enable = lib.mkEnableOption "and configure the swaylock program.";
  };

  config = mkIf cfg.enable {
    programs.swaylock = {
      enable = true;
      settings = {
        daemonize = true;
        hide-keyboard-layout = true;
      };
    };
  };
}
