{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.browsers.firefox;
in
{
  options.myHome.browsers.firefox = {
    enable = lib.mkEnableOption "Enable and configure firefox.";
  };

  config = mkIf cfg.enable {
    myHome.browsers.tridactyl.enable = true;
    programs.firefox.enable = true;

    home.sessionVariables.BROWSER = lib.mkDefault "firefox";

    home.file.".local/bin/schoolfox" = {
      executable = true;
      text = /* sh */ ''
        exec ${pkgs.firefox}/bin/firefox -p school
      '';
    };

    home.file.".local/bin/offlinefox" = {
      executable = true;
      text = /* sh */ ''
        exec ${pkgs.firefox}/bin/firefox -p offline
      '';
    };

    programs.firefox = {
      package = pkgs.firefox.override { cfg.speechSynthesisSupport = true; };
      policies = {
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisplayBookmarksToolbar = "newtab";
        DontCheckDefaultBrowser = true;
        GenerativeAI.Enabled = false;
        HttpsOnlyMode = "enabled";
        Homepage.URL = "duckduckgo.com";
        PasswordManagerEnabled = false;
      };
      profiles = rec {
        "personal" = {
          id = lib.mkDefault 0;
          search = {
            force = true;
            default = "ddg";
          };
          extensions = {
            packages = with pkgs.nur.repos.rycee.firefox-addons; [
              auto-tab-discard
              # bypass-paywalls-clean
              canvasblocker
              cookie-autodelete
              clearurls
              darkreader
              decentraleyes
              firemonkey
              istilldontcareaboutcookies
              # keepassxc-browser
              sponsorblock
              tridactyl
              video-downloadhelper
              videospeed
              ublock-origin

              overbitewx
              geminize
            ];
            settings = {
              # # vimium
              # "{d7742d87-e61d-4b78-b8a1-b469842139fa}".settings = {
              # };
            };
          };
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
        tridactyl-native
      ];
    };
  };
}
