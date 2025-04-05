{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.connections.networkmanager;
in
{
  options.myConfig.connections.networkmanager = {
    enable = lib.mkOption {
      description = "Enable network manager";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    networking = {
      networkmanager.enable = true;
      nameservers = [
        "194.242.2.4" # Mullvad Base
        "194.242.2.3" # Mullvad Adblocking
      ];
    };
  };
}


