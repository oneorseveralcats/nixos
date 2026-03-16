{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.desktop.testing;
in
{
  options.myHome.desktop.testing = {
    enable = lib.mkEnableOption "Destop programs that are being tested.";
  };

  config = mkIf cfg.enable {
    myHome.browsers.chromium.enable = true;

    myHome.browsers.luakit = {
      enable = true;
    };
  };
}
