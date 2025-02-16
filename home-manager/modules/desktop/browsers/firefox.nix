{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.desktop.browsers.firefox;
in
{
  options.myHome.desktop.browsers.firefox = {
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
      package = pkgs.firefox.override { cfg.speechSynthesisSupport = true; };
      nativeMessagingHosts = with pkgs; [
        ff2mpv
        vdhcoapp
        tridactyl-native
      ];
    };

    xdg.configFile."tridactyl/tridactylrc".text = ''
      colorscheme shydactyl

      guiset_quiet gui none

      set allowautofocus false

      set editorcmd ${config.home.sessionVariables.TERMINAL} --app-id=floating ${pkgs.helix}/bin/hx
      set externalclipboardcmd wl-copy

      # Search Engines
      set searchengine duckduckgo
      set searchurls.aw: https://wiki.archlinux.org/index.php?search=%s
      set searchurls.am: https://man.archlinux.org/search?q=%s
      set searchurls.np: https://search.nixos.org/packages?query=%s
      set searchurls.no: https://search.nixos.org/options?query=%s
      set searchurls.nw: https://wiki.nixos.org/w/index.php?search=%s
      set searchurls.hd: https://hackage.haskell.org/package/%s/docs/
      set searchurls.w:  https://en.wikipedia.org/w/index.php?search=%s


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
