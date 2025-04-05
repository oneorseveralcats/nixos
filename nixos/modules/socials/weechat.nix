{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.socials.weechat;
in
{
  options.myConfig.socials.weechat = {
    enable = mkEnableOption "Enable the weechat irc client.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      weechat
    ];

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

