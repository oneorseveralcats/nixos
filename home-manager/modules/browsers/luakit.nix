{ config, lib, pkgs, ... }:
let 
  cfg = config.myHome.browsers.luakit;
in
{
  options.myHome.browsers.luakit = {
    enable = lib.mkEnableOption "Enable and configure luakit.";
  };

  config = lib.mkIf cfg.enable {
    myHome.stylix.enable = true;

    home.packages = [
      pkgs.luakit
    ];

    xdg.configFile."luakit/userconf.lua" = {
      text = /* lua */ ''
        local settings = require "settings"
        settings.application.prefer_dark_mode = true
        settings.session.always_save = true
        settings.window.default_search_engine = "duckduckgo"
        settings.window.home_page = "luakit://newtab"
        settings.window.scroll_step = 200
        settings.webview.default_charset = "utf-8"

        local engines = settings.window.search_engines
        engines.aw = "https://wiki.archlinux.org/index.php?search=%s"
        engines.am = "https://man.archlinux.org/search?q=%s"
        engines.np = "https://search.nixos.org/packages?query=%s"
        engines.no = "https://search.nixos.org/options?query=%s"
        engines.nw = "https://wiki.nixos.org/w/index.php?search=%s"
        engines.ha = "https://hackage.haskell.org/package/%s/docs/"
        engines.re = "https://reddit.com/r/%s"
        engines.tw = "https://terraria.wiki.gg/wiki/Special:Search?search=%s"
        engines.yt = "https://www.youtube.com/results?search_query=%s"
        engines.w  = engines.wikipedia

        local modes = require "modes"
        local binds = require "binds"
        modes.remap_binds("normal", {
          { "J", "K" },
          { "K", "J" },
          {"<C-n>", "<Down>", true},
          {"<C-p>", "<Up>", true},
        })

        modes.add_binds("normal", {
          { "b", "Open tab menu.", function (w) w:run_cmd(":tabmenu") end },
        })

        local cmdhist = require("cmdhist")
        modes.add_binds("cmdhist", {
          { "<control-p>", "Previous in command history.", cmdhist.history_prev_func },
          { "<control-n>", "Next in command history.", cmdhist.history_next_func },
        })


        -- Use home row (and a bit) characters for generating labels
        local select = require "select"
        select.label_maker = function (s)
            return s.sort(s.reverse(s.charset("uhetonasidkbjmyg")))
        end
        -- Match only hint label text
        local follow = require "follow"
        follow.pattern_maker = follow.pattern_styles.match_label

        local rdr_view require "rdr_view" 
      '';
    };

    xdg.configFile."luakit/theme.lua" = {
      # text = /* lua */ ''
      #   local theme = dofile("${pkgs.luakit}/etc/xdg/luakit/theme.lua")
      #   return theme
      # '';
      text = with config.lib.stylix.colors; /* lua */ ''
        local theme = {}

        -- Default settings
        theme.font = "16px monospace"
        theme.fg   = "#${base07-hex}"
        theme.bg   = "#${base00-hex}"

        -- General colours
        theme.success_fg = "#${base0B-hex}"
        theme.loaded_fg  = "#${base0C-hex}"
        theme.error_fg = "#${base07-hex}"
        theme.error_bg = "#${base08-hex}"

        -- Warning colours
        theme.warning_fg = "#${base07-hex}"
        theme.warning_bg = "#${base08-hex}"

        -- Notification colours
        theme.notif_fg = "#${base07-hex}"
        theme.notif_bg = "#${base00-hex}"

        -- Menu colours
        theme.menu_fg                   = "#${base07-hex}"
        theme.menu_bg                   = "#${base00-hex}"
        theme.menu_selected_fg          = "#${base0D-hex}"
        theme.menu_selected_bg          = "#${base00-hex}"
        theme.menu_title_bg             = "#${base00-hex}"
        theme.menu_primary_title_fg     = "#${base08-hex}"
        theme.menu_secondary_title_fg   = "#${base0B-hex}"

        theme.menu_disabled_fg = "#${base05-hex}"
        theme.menu_disabled_bg = theme.menu_bg
        theme.menu_enabled_fg = theme.menu_fg
        theme.menu_enabled_bg = theme.menu_bg
        theme.menu_active_fg = "#${base0B-hex}"
        theme.menu_active_bg = theme.menu_bg

        -- Proxy manager
        theme.proxy_active_menu_fg      = "#${base0D-hex}"
        theme.proxy_active_menu_bg      = "#${base00-hex}"
        theme.proxy_inactive_menu_fg    = "#${base07-hex}"
        theme.proxy_inactive_menu_bg    = "#${base00-hex}"

        -- Statusbar specific
        theme.sbar_fg         = "#${base07-hex}"
        theme.sbar_bg         = "#${base00-hex}"

        -- Downloadbar specific
        theme.dbar_fg         = "#${base07-hex}"
        theme.dbar_bg         = "#${base00-hex}"
        theme.dbar_error_fg   = "#${base08-hex}"

        -- Input bar specific
        theme.ibar_fg           = "#${base07-hex}"
        theme.ibar_bg           = "#${base00-hex}"

        -- Tab label
        theme.tab_fg            = "#${base07-hex}"
        theme.tab_bg            = "#${base00-hex}"
        theme.tab_hover_bg      = "#${base02-hex}"
        theme.tab_ntheme        = "#${base06-hex}"
        theme.selected_fg       = "#${base00-hex}"
        theme.selected_bg       = "#${base0D-hex}"
        theme.selected_ntheme   = "#${base06-hex}"
        theme.loading_fg        = "#${base0C-hex}"
        theme.loading_bg        = "#${base00-hex}"

        theme.selected_private_tab_bg = "#${base0E-hex}"
        theme.private_tab_bg    = "#${base00-hex}"

        -- Trusted/untrusted ssl colours
        theme.trust_fg          = "#${base0B-hex}"
        theme.notrust_fg        = "#${base08-hex}"

        -- Follow mode hints
        theme.hint_font = "16px monospace, courier, sans-serif"
        theme.hint_fg = "#fff"
        theme.hint_bg = "#000088"
        theme.hint_border = "1px dashed #000"
        theme.hint_opacity = "0.3"
        theme.hint_overlay_bg = "rgba(255,255,153,0.3)"
        theme.hint_overlay_border = "1px dotted #000"
        theme.hint_overlay_selected_bg = "rgba(0,255,0,0.3)"
        theme.hint_overlay_selected_border = theme.hint_overlay_border

        -- General colour pairings
        theme.ok = { fg = "#${base07-hex}", bg = "#${base00-hex}" }
        theme.warn = { fg = "#${base08-hex}", bg = "#${base00-hex}" }
        theme.error = { fg = "#${base07-hex}", bg = "#${base08-hex}" }

        -- Gopher page style (override defaults)
        theme.gopher_light = { bg = "#${base07-hex}", fg = "#${base00-hex}", link = "#${base0D-hex}" }
        theme.gopher_dark  = { bg = "#${base00-hex}", fg = "#${base07-hex}", link = "#${base0D-hex}" }

        return theme
      '';
    };

    home.file = {
      ".local/share/luakit/adblock/easylist.txt".source = builtins.fetchurl "https://easylist.to/easylist/easylist.txt";
      ".local/share/luakit/adblock/easyprivacy.txt".source = builtins.fetchurl "https://easylist.to/easylist/easyprivacy.txt";
      ".local/share/luakit/adblock/fanboy-annoyance.txt".source = builtins.fetchurl "https://secure.fanboy.co.nz/fanboy-annoyance.txt";
      ".local/share/luakit/adblock/fanboy-cookiemonster.txt".source = builtins.fetchurl "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt";
      ".local/share/luakit/adblock/fanboy-social.txt".source = builtins.fetchurl "https://easylist.to/easylist/fanboy-social.txt";
    };
  };
}


