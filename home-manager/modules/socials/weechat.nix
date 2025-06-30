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
    enable = lib.mkOption {
      description = "Enable the weechat irc client.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # python3Packages.notify2
      weechat
    ];
  };
}

