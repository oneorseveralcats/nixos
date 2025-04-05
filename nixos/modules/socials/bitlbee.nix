{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.socials.bitlbee;
in
{
  options.myConfig.socials.bitlbee = {
    enable = mkEnableOption "Enable the BitlBee IRC to other platform bridge.";
  };

  config = mkIf cfg.enable {
    services.bitlbee = {
      enable = true;
      plugins = with pkgs; [
        bitlbee-mastodon
      ];
      libpurple_plugins = with pkgs.pidginPackages; [
        purple-discord
        purple-signald
        # tdlib-purple
      ];
    };
  };
}

