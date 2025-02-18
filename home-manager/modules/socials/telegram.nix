{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.socials.telegram;
in
{
  options.myHome.socials.telegram = {
    enable = lib.mkOption {
      description = "Enable telegram.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      telegram-desktop
    ];
  };
}
