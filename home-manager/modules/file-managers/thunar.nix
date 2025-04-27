{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.file-managers.thunar;
in
{
  options.myHome.file-managers.thunar = {
    enable = lib.mkEnableOption "Enable the thunar file manager.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      xfce.thunar
    ];
  };
}

