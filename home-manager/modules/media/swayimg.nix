{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.media.swayimg;
in
{
  options.myHome.media.swayimg = {
    enable = lib.mkEnableOption "Enable and configure the swayimg image viewer.";
  };

  config = mkIf cfg.enable {
    programs.swayimg = {
      enable = true;
      settings = {
        general = {
          decoration = "yes";
        };
        list = {
          all = "yes";
        };
        viewer = {
          preload = 5;
          scale = "fit";
          window = "#${config.lib.stylix.colors.base00-hex}";
        };

        info = {
          show = "no";
        };
        "info.viewer" = {
          top_left = "none";
          top_right = "status";
          bottom_left = "name";
          bottom_right = "scale,index,frame";
        };

        "keys.gallery" = {
          h = "step_left";
          j = "step_down";
          k = "step_up";
          l = "step_right";

          g = "first_file";
          "Shift+g" = "last_file";
        };
        "keys.viewer" = {
          h = "prev_file";
          l = "next_file";

          g = "first_file";
          "Shift+g" = "last_file";
          "Shift+space" = "prev_file";
        };
      };
    };
  };
}
