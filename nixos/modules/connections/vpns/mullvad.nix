{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.connections.vpns.mullvad;
in
{
  options.myConfig.connections.vpns.mullvad = {
    enable = lib.mkEnableOption "and configure mullvad";
  };

  config = mkIf cfg.enable {
    services.mullvad-vpn.enable = true;
  };
}

