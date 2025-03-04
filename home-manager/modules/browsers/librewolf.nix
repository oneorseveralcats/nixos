{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.browsers.librewolf;
  nur = import <nur> {};
in
{
  options.myHome.browsers.librewolf = {
    enable = lib.mkOption {
      description = "Enable and configure librewolf.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    myHome.browsers.tridactyl.enable = true;

    programs.librewolf = {
      enable = true;
      package = pkgs.librewolf.override {
        nativeMessagingHosts = with pkgs; [
          keepassxc
          tridactyl-native
          vdhcoapp
        ];
      };
      policies = {
        SearchEngine = {
          Default = "DuckDuckGo";
        };
      };
      settings = {
        "browser.compactmode.show" = true;
        "browser.uidensity" = 1;

        "pdfjs.forcePageColors" = true;
        "pdfjs.pageColorsBackground" = "#111111";
        "pdfjs.pageColorsForeground" = "#dddddd";

        "browser.startup.homepage" = "moz-extension://4952e6fa-ad04-49ec-aa79-b6104733ec3c/static/newtab.html";
        "browser.download.autohideButton" = true;
        "browser.toolbars.bookmarks.visibility" = "newtab";
        "browser.startup.page" = 3;

        "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
        "privacy.clearOnShutdown.downloads" = false;
        "privacy.clearOnShutdown.history" = false;

        # "webgl.disabled" = false;
        # "privacy.resistFingerprinting" = false;


        # https://web.archive.org/web/20120225050723/https://mike.kaply.com/2012/02/21/understanding-add-on-scopes/
        "extensions.autoDisableScopes" = 0;
      };
      profiles = rec {
        "personal" = {
          id = 0;
          extensions = with nur.repos.rycee.firefox-addons; [
            auto-tab-discard
            # bypass-paywalls-clean
            canvasblocker
            cookie-autodelete
            clearurls
            darkreader
            decentraleyes
            greasemonkey
            i-dont-care-about-cookies
            keepassxc-browser
            tridactyl
            video-downloadhelper

            overbitewx
            geminize
          ];
        };
        "school" = {
          id = 1;
          extensions = personal.extensions;
        };
        "offline" = {
          id = 2;
          extensions = personal.extensions;
        };
      };
    };
  };
}
