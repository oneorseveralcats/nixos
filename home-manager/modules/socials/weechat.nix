{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.socials.weechat;
  weechat = pkgs.weechat.override {
    configure = { availablePlugins, ... }: {
      scripts = with pkgs.weechatScripts; [
        weechat-notify-send
      ];
    };
  };
in
{
  options.myHome.socials.weechat = {
    enable = lib.mkEnableOption "Enable the weechat irc client.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # python3Packages.notify2
      weechat
    ];
  };
}

