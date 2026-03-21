{ config, lib, pkgs, ... }:
let 
  cfg = config.myHome.browsers.chawan;
in
{
  options.myHome.browsers.chawan = {
    enable = lib.mkEnableOption "chawan and its configuration.";
  };

  config = lib.mkIf cfg.enable {
    programs.chawan = {
      enable = true;
      package = pkgs.unstable.chawan;
      settings = {
        buffer = {
          images = true;
          styling = false;
          user-style = /* css */ ''
            body {
              background-color: none;
            }
          '';
        };
        line = {
          "Escape" = "line.cancel";
        };
        page = {
         "o" = "loadEmpty";
         "O" = "load";
         "M-o" = "loadCursor";

         "d" = "discardBuffer";
         "r" = "reloadBuffer";

         "yy" = "copyUrl";
         "p" = "copyUrl";

         "gh" = "cursorLineTextStart";
         "gl" = "cursorLineEnd";
         "ge" = "gotoLineOrEnd";

         "C-l" = "redraw";
         "C-L" = "reshape";

         "v" = "toggleSource";
         ":" = "enterCommand";
        };
        siteconf = {
          gemini = {
            url = "^gemini:";
            insecure-ssl-no-verify = true;
          };
        };

        
        omnirule = let
          engines = with config.myHome.browsers.settings; search-engines // {
            d = search-engines.duckduckgolite;
          };
          generateSearchEngines = set: builtins.mapAttrs (
            k: v: {
              match = ''^\s*${k}\s+'';
              substitute-url = /* js */ ''(x) => "${v}".replace("%s", encodeURIComponent(x.split(" ").slice(1).join(" ")))'';
            }
          ) set;
        in generateSearchEngines engines;
      };
    };

  };
}
