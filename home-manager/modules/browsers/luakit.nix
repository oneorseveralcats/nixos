{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.browsers.luakit;
in
{
  options.myHome.browsers.luakit = {
    enable = lib.mkEnableOption "Enable and configure luakit.";
  };

  config = mkIf cfg.enable {
    home.packages = with lib; [
      luakit
    ];
  };
}


