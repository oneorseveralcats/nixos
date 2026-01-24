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
  };
}
