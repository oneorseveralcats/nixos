{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.desktop.bars.quickshell;
in
{
  options.myHome.desktop.bars.quickshell = {
    enable = lib.mkEnableOption "and configure the quickshell bar and widget toolkit.";
  };

  config =  mkIf cfg.enable {
    programs.quickshell = {
      enable = true;
    };
  };
}
