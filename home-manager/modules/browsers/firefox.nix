{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.browsers.firefox;
  nur = import <nur> {};
in
{
  options.myHome.browsers.firefox = {
    enable = lib.mkEnableOption "Enable and configure firefox.";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      myHome.browsers.tridactyl.enable = true;
      programs.firefox.enable = true;

      home.sessionVariables.BROWSER = lib.mkDefault "firefox";

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
    })
    ({
      programs.firefox = {
        package = pkgs.firefox.override { cfg.speechSynthesisSupport = true; };
        policies = {
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DisplayBookmarksToolbar = "newtab";
          HttpsOnlyMode = "enabled";
          Homepage = {
            URL = "duckduckgo.com";
          };
          PasswordManagerEnabled = false;
        };
        profiles = rec {
          "personal" = {
            id = lib.mkDefault 0;
            search = {
              force = true;
              default = "DuckDuckGo";
            };
            extensions = with nur.repos.rycee.firefox-addons; [
              auto-tab-discard
              # bypass-paywalls-clean
              canvasblocker
              cookie-autodelete
              clearurls
              darkreader
              decentraleyes
              greasemonkey
              istilldontcareaboutcookies
              keepassxc-browser
              tridactyl
              video-downloadhelper

              overbitewx
              geminize
            ];
          };
          "school" = personal // {
            id = lib.mkDefault 1;
          };
          "offline" = personal // {
            id = lib.mkDefault 2;
          };
        };
        nativeMessagingHosts = with pkgs; [
          keepassxc
          vdhcoapp
          tridactyl-native
        ];
      };
    })
  ];
}
