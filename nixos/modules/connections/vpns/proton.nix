{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.connections.vpns.proton;
in
{
  options.myConfig.connections.vpns.proton = {
    enable = lib.mkEnableOption "and configure protonvpn";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      proton-vpn-cli proton-vpn
      wireguard-tools
    ];

    networking.firewall.checkReversePath = "loose";
  };
}

