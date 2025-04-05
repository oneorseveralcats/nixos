{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.connections.firewall;
in
{
  options.myConfig.connections.firewall = {
    enable = lib.mkOption {
      description = "Enable and configure firewall";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    networking.firewall.enable = true;
  };
}

