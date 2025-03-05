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

    programs.librewolf = with config.programs; {
      enable = true;
      package = pkgs.librewolf.override {
        nativeMessagingHosts = firefox.nativeMessagingHosts;
      };
      profiles = rec {
        "personal" = firefox.profiles.personal // {
          search.default = firefox.profiles.personal.search.default;
        };
        "school" = firefox.profiles.school // {
          search.default = personal.search.default;
        };
        "offline" = firefox.profiles.offline // {
          search.default = personal.search.default;
        };
      };
      settings = {
        "browser.compactmode.show" = true;
        "browser.uidensity" = 1;

        "pdfjs.forcePageColors" = true;
        "pdfjs.pageColorsBackground" = "#111111";
        "pdfjs.pageColorsForeground" = "#dddddd";

        "browser.startup.homepage" = "https://lite.duckduckgo.com";
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
    };
  };
}
