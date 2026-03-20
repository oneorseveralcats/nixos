{ config, lib, pkgs, ... }:
let 
  cfg = config.programs.nom;
in
{
  options.programs.nom = {
    enable = lib.mkEnableOption "Enable the nom rss feed reader.";

    package = lib.mkPackageOption pkgs "nom" { nullable = true; };

    settings = lib.mkOption {
      type = lib.types.attrsOf lib.types.anything; # TODO: replace anything with something more restrictive
      default = { };
      example = {
        autoread = true;
        showread = false;
        ordering = "desc";

        openers = [
          { regex = "youtube";  cmd = "mpv %s"; }
        ];
        
        theme = {
          glamour = "dark";
        };

        feeds = [
          { name = "vimjoyer"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC_zBdZ0_H_jn41FDRG7q4Tw"; }
        ];

      };
      description = ''
        Settings for nom including themes, rss feeds, and openers for specific url regexes.

        Options are listed on the github: <https://github.com/guyfedwards/nom>.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.mkIf (cfg.package != null) [
      cfg.package
    ];

    # nom's config uses yaml formatting.
    xdg.configFile."nom/config.yml"= lib.mkIf (cfg.settings != {}) {
      source = pkgs.writeText "config.yml" (lib.generators.toYAML {} cfg.settings);
    };
  };
}

