{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.media.pqiv;
in
{
  options.myHome.media.pqiv = {
    enable = lib.mkEnableOption "Enable and configure the pqiv image viewer.";
  };

  config = mkIf cfg.enable {
    programs.pqiv = {
      enable = true;
      settings = {
        options = {
          browse = true;
          hide-info-box = true;
          max-depth = 1;
          window-position = "1510,0";
        };
      };
      extraConfig = ''
        [actions]
        set_cursor_auto_hide(1)
        set_scale_mode_fit_px(400,500)
      '';
    };
  };
}
