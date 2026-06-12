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
    myConfig.sops.enable = true;
    sops.secrets."wifi/home/ssid" = {};
    sops.secrets."wifi/home/password" = {};

    sops.templates."wifi-credentials".content = ''
      home_ssid=${config.sops.placeholder."wifi/home/ssid"}
      home_password=${config.sops.placeholder."wifi/home/password"}
    '';

    networking = {
      networkmanager.enable = true;
      nameservers = [
        "194.242.2.4" # Mullvad Base
        "194.242.2.3" # Mullvad Adblocking
      ];

      # convert to networkmanager
      # 
      # wireless = {
      #   secretsFile = config.sops.templates."wifi-credentials".path;
      #   networks = {
      #     home = {
      #       ssid = "ext:home_ssid";
      #       pskRaw = "ext:home_password";
      #     };
      #   };
      # };
    };
  };
}


