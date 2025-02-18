{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.desktop.extras;
in
{
  options.myHome.desktop.extras = {
    enable = lib.mkOption {
      description = "Enable extra programs and services.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      libreoffice hunspell hunspellDicts.tok hunspellDicts.en_US
      syncplay
    ] ++
      (if pkgs.system == "aarch64-linux" then
        []
      else
        [ pkgs.tor-browser-bundle-bin 
          pkgs.session-desktop
          # pkgs.logseq  
        ])
    ;

    services.kdeconnect = {
      enable = false;
      indicator = true;
    };
  };
}
