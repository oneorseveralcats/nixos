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
    ] ++
      (if pkgs.stdenv.hostPlatform.system == "aarch64-linux" then
        []
      else
        [ pkgs.tor-browser
          # pkgs.logseq  
        ])
    ;
  };
}
