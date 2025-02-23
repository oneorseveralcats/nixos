{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.browsers.qutebrowser;
in
{
  options.myHome.browsers.qutebrowser = {
    enable = lib.mkEnableOption "Enable and configure qutebrowser.";
  };

  config = mkIf cfg.enable {
    programs.qutebrowser = {
      enable = true;
      settings = {
        auto_save.session = true;
        colors.webpage.darkmode.enabled = false;
        tabs = {
          show = "multiple";
          background = false;
        };
      };
      searchEngines = {
        aw = "https://wiki.archlinux.org/index.php?search={}";
        am = "https://man.archlinux.org/search?q={}";
        np = "https://search.nixos.org/packages?query={}";
        no = "https://search.nixos.org/options?query={}";
        nw = "https://wiki.nixos.org/w/index.php?search={}";
        ha = "https://hackage.haskell.org/package/{}/docs/";
        yt = "https://www.youtube.com/results?search_query={}";
        w =  "https://en.wikipedia.org/w/index.php?search={}";
      };
    };
  };
}

