{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.connections.wifi;
in
{
  options.myConfig.connections.wifi = {
    enable = lib.mkOption {
      description = "Enable wifi through network manager.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    myConfig.connections.networkmanager.enable = true;

    networking = {
      wireless = {
        secretsFile = "/etc/secrets/wifi";
        networks = {
          NETGEAR21.pskRaw = "ext:PSK_HOME";
        };
      };
    };
  };
}

