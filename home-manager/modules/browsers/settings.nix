{ config, lib, pkgs, ... }:
let
  inherit (lib)
    types;
  cfg = config.myHome.browsers.settings;
in
{
  options.myHome.browsers.settings = {
    search-engines = lib.mkOption {
      type = with types; attrsOf str;
      description = "All the search engines that browsers should have assigned by default";
      default = rec {
        # http
        archwiki = "https://wiki.archlinux.org/index.php?search=%s";
        archman = "https://man.archlinux.org/search?q=%s";
        duckduckgo = "https://duckduckgo.com/?q=%s";
        duckduckgolite = "https://lite.duckduckgo.com/lite/?q=%s";
        idiotbox = "https://codemadness.org/idiotbox/?q=%s"; # youtube frontend
        nixpkgs = "https://search.nixos.org/packages?query=%s";
        nixopts = "https://search.nixos.org/options?query=%s";
        nixwiki = "https://wiki.nixos.org/w/index.php?search=%s";
        hackage = "https://hackage.haskell.org/package/%s/docs/";
        reddit = "https://reddit.com/r/%s";
        terrariawiki = "https://terraria.wiki.gg/wiki/Special:Search?search=%s";
        youtube = "https://www.youtube.com/results?search_query=%s";
        wikipedia  = "https://en.wikipedia.org/w/index.php?search=%s";

        aw = archwiki;
        am = archman;
        d = duckduckgo;
        np = nixpkgs;
        no = nixopts;
        nw = nixwiki;
        ha = hackage;
        re = reddit;
        tw = terrariawiki;
        yt = youtube;
        w  = wikipedia;


        # gopher
        veronica2 = "gopher://gopher.floodgap.com/1/v2/vs?%s";
        gopherpedia = "gopher://gopherpedia.com/7/lookup?%s";

        v2 = veronica2;


        # gemini
        kennedy = "gemini://kennedy.gemi.dev/search?%s";
      };
    };
  };
}

