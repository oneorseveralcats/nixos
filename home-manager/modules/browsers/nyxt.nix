{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.browsers.nyxt;
in
{
  options.myHome.browsers.nyxt = {
    enable = lib.mkEnableOption "Enable and configure nyxt.";
  };

  config = mkIf cfg.enable {
    home.packages = with lib; [
      nyxt
    ];
  };
}

