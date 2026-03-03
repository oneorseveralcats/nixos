{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.media.inori;
in
{
  options.myHome.media.inori = {
    enable = lib.mkEnableOption "Enable and configure the inori mpd client.";
  };

  config = mkIf cfg.enable {
    programs.inori = {
      enable = true;
      settings = {
        qwerty_keybindings = true;
      };
    };
  };
}

