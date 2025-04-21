{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.socials.weechat;
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
      weechat
    ];
  };
}

