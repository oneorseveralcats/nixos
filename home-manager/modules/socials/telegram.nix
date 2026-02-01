{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.socials.telegram;
in
{
  options.myHome.socials.telegram = {
    enable = lib.mkEnableOption "Enable telegram.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      telegram-desktop
    ];

    home.file.".local/share/TelegramDesktop/tdata/shortcuts-custom.json" = {
      force = true;
      text = builtins.toJSON [
        { command = "previous_chat"; keys = "alt+k"; }
        { command = "next_chat"; keys = "alt+j"; }
        { command = "search"; keys = "alt+/"; }
      ];
    };
  };
}
