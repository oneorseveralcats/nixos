{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.desktop.others.wlr-portals;
in
{
  options.myHome.desktop.others.wlr-portals = {
    enable = lib.mkEnableOption "xdg portals configuration for wlr-roots compositors.";
  };

  config =  mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      config = {
        common = {
          default = [
            "gtk"
          ];
        };
        sway = {
          default = [
            "wlr"
            "gtk"
          ];
          "org.freedesktop.impl.portal.Secret" = [
            "gnome-keyring"
          ];
        };
      };
      extraPortals = with pkgs; [
        gnome-keyring
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };
}

