{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.desktop.others.wlr-packages;
in
{
  options.myHome.desktop.others.wlr-packages = {
    enable = lib.mkEnableOption "default packages for wlr-roots compositors.";
  };

  config =  mkIf cfg.enable {
    home.packages = with pkgs; [
      grim 
      slurp 
      dragon-drop
      wf-recorder wl-clipboard wl-clipboard-x11 
      wev wlprop
    ];
  };
}
