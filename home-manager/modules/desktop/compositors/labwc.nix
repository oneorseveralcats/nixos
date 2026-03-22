{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.desktop.compositors.labwc;
in
{
  options.myHome.desktop.compositors.labwc = {
    enable = lib.mkEnableOption "Enable and configure the labwc wayland compositor.";
  };

  config =  mkIf cfg.enable {
    myHome.desktop = {
      bars.waybar.enable = true;
      launchers.fuzzel.enable = true;

      others = {
        mako.enable = true;
        swayidle.enable = true;
        swaylock.enable = true;
        wlr-packages.enable = true;
        wlr-portals.enable = true;
      };
    };

    wayland.windowManager.labwc = {
      enable = true;
    };
  };
}
