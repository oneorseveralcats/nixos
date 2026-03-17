{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.connections.firewall;
in
{
  options.myConfig.connections.firewall = {
    enable = lib.mkEnableOption "Enable and configure firewall";
  };

  config = mkIf cfg.enable {
    networking = {
      nftables.enable = true;
      firewall.enable = true;
    };
  };
}

