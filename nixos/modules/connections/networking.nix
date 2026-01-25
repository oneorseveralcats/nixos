{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.connections.networking;
in
{
  options.myConfig.connections.networking = {
    enable = lib.mkEnableOption "Enable network manager";
  };

  config = mkIf cfg.enable {
    networking = {
      networkmanager.enable = true;
      nameservers = [
        "194.242.2.4" # Mullvad Base
        "194.242.2.3" # Mullvad Adblocking
      ];

      wireless = {
        secretsFile = "/etc/secrets/wifi";
        networks = {
          NETGEAR21.pskRaw = "ext:PSK_HOME";
        };
      };
    };
  };
}


