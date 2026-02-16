{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.cli.hyfetch;
in
{
  options.myHome.cli.hyfetch = {
    enable = lib.mkEnableOption "Enable the hyfetch system information tool.";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.fastfetch ];
    programs.hyfetch = {
      enable = true;
      settings = {
        backend = "fastfetch";
        pride_month_disable = true;
        light_dark = "dark";
        mode = "rgb";
        preset = "agender";
        color_align = {
          mode = "horizontal";
        };
      };
    };
  };
}
