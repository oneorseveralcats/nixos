{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.desktop.compositors.wlr-extras;
in
{
  options.myHome.desktop.compositors.wlr-extras = {
    enable = lib.mkEnableOption "Enable extra programs and services for wlroots compositors.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      grim 
      slurp 
      dragon-drop
      wf-recorder wl-clipboard wl-clipboard-x11 
      wev wlprop
    ];

    programs.swaylock = {
      enable = true;
      settings = {
        daemonize = true;
        hide-keyboard-layout = true;
      };
    };

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
