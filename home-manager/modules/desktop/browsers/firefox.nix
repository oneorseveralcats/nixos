{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.desktop.browsers.firefox;
in
{
  options.myHome.desktop.browsers.firefox = {
    enable = lib.mkOption {
      description = "Enable and configure firefox.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    myHome.desktop.browsers.tridactyl.enable = true;

    home.sessionVariables.BROWSER = lib.mkDefault "firefox";

    programs.firefox = {
      enable = true;
      package = pkgs.firefox.override { cfg.speechSynthesisSupport = true; };
      nativeMessagingHosts = with pkgs; [
        ff2mpv
        vdhcoapp
        tridactyl-native
      ];
    };

    home.file.".local/bin/schoolfox" = {
      executable = true;
      text = ''
        exec ${pkgs.firefox}/bin/firefox -p school
      '';
    };

    home.file.".local/bin/offlinefox" = {
      executable = true;
      text = ''
        exec ${pkgs.firefox}/bin/firefox -p offline
      '';
    };

  };
}
