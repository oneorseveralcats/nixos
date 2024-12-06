{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.desktop.firefox;
in
{
  options.myHome.desktop.firefox = {
    enable = lib.mkOption {
      description = "Enable and configure firefox.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.sessionVariables.BROWSER = "firefox";

    programs.firefox = {
      enable = true;
      nativeMessagingHosts = with pkgs; [
        ff2mpv
        vdhcoapp
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
