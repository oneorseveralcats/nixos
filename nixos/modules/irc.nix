{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.irc;
in
{
  options.myConfig.irc = {
    enable = mkOption {
      description = "Enable Weechat and Bitlbee";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      weechat
    ];

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

    services.weechat = {
      enable = true;
    };

    programs.screen.screenrc = ''
      multiuser on
      acladd user
      term screen-256color
    '';

  };
}
