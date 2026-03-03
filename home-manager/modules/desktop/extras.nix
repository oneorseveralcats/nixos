{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.desktop.extras;
in
{
  options.myHome.desktop.extras = {
    enable = lib.mkEnableOption "Enable extra programs and services.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      libreoffice-fresh hunspell hunspellDicts.tok hunspellDicts.en_US
      syncplay
    ]
      ++ lib.optional (pkgs.stdenv.hostPlatform.isx86) pkgs.tor-browser;
  };
}
