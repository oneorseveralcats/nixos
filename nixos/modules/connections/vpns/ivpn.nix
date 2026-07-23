{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.connections.vpns.ivpn;
in
{
  options.myConfig.connections.vpns.ivpn = {
    enable = lib.mkEnableOption "and configure ivpn";
  };

  config = mkIf cfg.enable {
    services.ivpn.enable = true;
  };
}

