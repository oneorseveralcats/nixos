{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.browsers.tridactyl;
  generateSearchUrls = with pkgs.lib.generators;
    set: toKeyValue {
      mkKeyValue = mkKeyValueDefault {} " ";
      indent="set searchurls.";
  } set;
in
{
  options.myHome.browsers.tridactyl = {
    enable = lib.mkEnableOption "Configure tridactyl for Firefox based-browsers.";
  };

  config = mkIf cfg.enable {
    xdg.configFile."tridactyl/tridactylrc".text = ''
      colorscheme shydactyl

      guiset_quiet gui none
      guiset_quiet navbar autohide
      guiset_quiet tabs always
      guiset_quiet tabs count

      set allowautofocus false
      set tabopenpos last
      set tabsort mru

      set editorcmd ${config.home.sessionVariables.TERMINAL} --app-id=floating ${pkgs.helix}/bin/hx
      set externalclipboardcmd wl-copy

      set hintchars uhetidonasyfkb

      # Search Engines
      set searchengine duckduckgo
      ${generateSearchUrls config.myHome.browsers.settings.search-engines}

      # Bindings
      bind ge scrollto 100
    '';

    xdg.configFile."tridactyl/themes/stylix.css".text = with config.lib.stylix.colors; ''
      :root {
        --base00: #${base00-hex};
        --base01: #${base01-hex};
        --base02: #${base02-hex};
        --base03: #${base03-hex};
        --base04: #${base04-hex};
        --base05: #${base05-hex};
        --base06: #${base06-hex};
        --base07: #${base07-hex};
        --base08: #${base08-hex};
        --base09: #${base09-hex};
        --base0A: #${base0A-hex};
        --base0B: #${base0B-hex};
        --base0C: #${base0C-hex};
        --base0D: #${base0D-hex};
        --base0E: #${base0E-hex};
        --base0F: #${base0F-hex};

        --tridactyl-fg: var(--base05);
        --tridactyl-bg: var(--base00);
        --tridactyl-url-fg: var(--base08);
        --tridactyl-url-bg: var(--base00);
        --tridactyl-highlight-box-bg: var(--base0B);
        --tridactyl-highlight-box-fg: var(--base00);
        --tridactyl-hintspan-fg: var(--base00) !important;
        --tridactyl-hintspan-bg: var(--base0A) !important;
        --tridactyl-hint-active-fg: none;
        --tridactyl-hint-active-bg: none;
        --tridactyl-hint-active-outline: none;
        --tridactyl-hint-bg: none;
        --tridactyl-hint-outline: none;
    }
    '';
  };
}

