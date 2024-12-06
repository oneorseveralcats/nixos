{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.base;
  fonts = with pkgs; [
    corefonts
    fira-code-nerdfont
    mno16
    noto-fonts
    noto-fonts-cjk-sans
    spleen
    twemoji-color-font
  ];
in
{
  options.myHome.base = {
    enable = lib.mkOption {
      description = "Enable the most basic configuration operations and programs.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "corefonts"
      "libretro-genesis-plus-gx"
      "steam" "steam-original" "steam-run"
      "terraria-server"
      "unrar"
      "zerotierone"
    ];

    home = {
      sessionPath = [
        "$HOME/.appimages"
      ];
      sessionVariables = {
        background = "000000";
        foreground = "ffffff";

        selectionBackground = "3c3c3c";
        selectionForeground = "ffffff";

        black   = "000000";
        red     = "ff8059";
        green   = "44bc44";
        yellow  = "d0bc00";
        blue    = "2fafff";
        magenta = "feacd0";
        cyan    = "00d3d0";
        white   = "bfbfbf";

        brightBlack   = "595959";
        brightRed     = "ef8b50";
        brightGreen   = "70b900";
        brightYellow  = "c0c530";
        brightBlue    = "79a8ff";
        brightMagenta = "b6a0ff";
        brightCyan    = "6ae4b9";
        brightWhite   = "ffffff";

        MANPAGER = "${pkgs.bat}/bin/bat -p";
      };
    };

    home.shellAliases = {
      n = "lf";
      nn = "gd";
      neofetch = "${pkgs.hyfetch}/bin/neowofetch";
      weather = "${pkgs.curl}/bin/curl wttr.in/Cincinnati?2QFu";

      ze = "${pkgs.zellij}/bin/zellij";
    };

    home.packages = with pkgs; [
      asciinema
      python3Packages.aria2p 
      exiftool
      httrack
      imagemagickBig
      magic-wormhole megatools mpvc
      ncdu
      pulsemixer python3Packages.yq
      rdrview 
      termdown
      ventoy-bin 
      w3m wcalc wget woof 

      distrobox lilipod

      # archives
      atool bzip2 gzip p7zip unrar unzip xz zip

      # lf
      moreutils

      # terminal powerpoint
      presenterm typst
      # haskellPackages.patat
    ] ++ fonts;

    home.preferXdgDirectories = true;

    fonts.fontconfig = {
      enable = false;      
      defaultFonts = {
          serif = [ "Noto Serif Light" "Noto Serif" ];
          sansSerif = [ "Noto Sans Light" "Noto Sans" ];
          monospace = [ "Fira Code Nerd Font Light" "Fira Code Light" "Noto Sans Mono" ];
          emoji = [ "Twitter Color Emoji" ];
      };
    };
  
    programs.lesspipe.enable = true;
    programs.jq.enable =true;


    home.file.".config/presenterm/config.yaml".text = ''
      defaults:
        theme: tokyonight-storm

      typst:
        ppi: 300

      options:
        implicit_slide_ends: true
        incremental_lists: true
        strict_front_matter_parsing: false
        end_slide_shorthand: true
    '';

    programs.aria2 = {
      enable = true;
      settings = {
        enable-rpc = true;
        rpc-listen-all = false;
      };
    };

    programs.bash = {
      enable = true;
      bashrcExtra = ''
        source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

        complete -cf doas
        [ -n "$NNNLVL" ] && PS1="N$NNNLVL $PS1"
        [ -n "$LF_LEVEL" ] && PS1="LF$LF_LEVEL $PS1"

        gd () {
          if [ -z "$@" ]; then
            cd "$(lf -print-last-dir)"
          else
            cd "$@"
          fi
        }

        # auto launches sway on tty1
        if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
          exec ${pkgs.sway}/bin/sway
        fi
      '';
    };

    programs.bat = {
      enable = true;
      config = {
        theme = "base16";
      };
      extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep batwatch ];
    };

    programs.htop = {
      enable = true;
      package = pkgs.htop-vim;
      settings = {
        color_scheme = 1;
        fields = with config.lib.htop.fields; [
          PID
          NICE
          PERCENT_CPU
          PERCENT_MEM
          TIME
          COMM
        ];
        highlight_base_name = 1;
        highlight_megabytes = 1;
        highlight_threads = 1;
        } // (with config.lib.htop; leftMeters [
          (bar "AllCPUs2")
          (bar "MemorySwap")
        ]) // (with config.lib.htop; rightMeters [
          (text "Tasks")
          (text "LoadAverage")
          (text "Uptime")
        ]);
    };

    programs.hyfetch = {
      enable = true;
      settings = {
        light_dark = "dark";
        mode = "rgb";
        preset = "agender";
        color_align = {
          mode = "horizontal";
        };
      };
    };

    programs.mpv = {
      enable = true;
      bindings = {
        "ctrl+p" = "show_text \${playlist}";
        "ctrl+w"  = "ignore";
        "WHEEL_UP" = "ignore";
        "WHEEL_DOWN" = "ignore";
        "b" = "cycle-values vf \"sub,lavfi=negate\" \"\"";

        "alt+f" = "script-binding file_browser/browse-files";
        "alt+p" = "script-binding playlistmanager/showplaylist";
        "alt+q" = "script-binding quality_menu/video_formats_toggle";
      };
      config = {
        af = "scaletempo2=max-speed=10";
        osc = "no";
        osd-font-size = "20";
        osd-level = "3";
        osd-msg3 = "\${time-pos}/\${duration} (\${playtime-remaining})";
        sub-scale = "0.75";
        volume = "70";
        alang = "eng,epo";
        slang = "eng,epo";
        sub-auto = "fuzzy";
        screenshot-directory = "~/pictures/mpv/";
        geometry = "480";
        ytdl-format = ''bv[height<=1080][vcodec!~='vp0?9']+ba/bv+ba/best'';
        ytdl-raw-options = "format-sort=[res,size,fps,quality,br]";
      };
      scripts = with pkgs.mpvScripts; [
        mpris
        mpv-playlistmanager
        quality-menu
        reload
        sponsorblock-minimal # sponsorblock
      ];
      scriptOpts = {
        playlistmanager = {
          # example: https://github.com/jonniek/mpv-playlistmanager/blob/master/playlistmanager.conf
          key_moveup = "k";
          key_movedown = "j";
          key_movepageup = "alt+k";
          key_movepagedown = "alt+j";
          key_movebegin = "g";
          key_moveend = "shift+g";
          key_selectfile = "Space";
          key_playfile = "l";
          key_removefile = "d";
          key_closeplaylist = "ESC";

          resolve_url_titles = "yes";

          loadfiles_on_start = "yes";
          loadfiles_filetypes = ''["mp3","wav","ogm","flac","m4a","wma","ogg","opus","mkv","avi","mp4","ogv","webm","rmvb","flv","wmv","mpeg","mpg","m4v","3gp"]'';

          playlist_display_timeout = "15";
        };
        file_browser = {}; # TODO? https://github.com/CogentRedTester/mpv-file-browser/blob/master/docs/file_browser.conf
      };
    };

    programs.helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        theme = "base16_transparent";
        editor = {
          bufferline = "multiple";
          color-modes = true;
          mouse = false;
          lsp.display-messages = true;
          soft-wrap.enable = true;
          auto-pairs = {
            "(" = ")";
            "{" = "}";
            "[" = "]";
            "\"" = "\"";
          };
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          indent-guides = {
            render = true;
            character = "╎";
            skip-levels = 1;
          };
          statusline = {
            left = [ "mode" "spinner" "file-name" "read-only-indicator" "file-modification-indicator" ];
            center = [ "file-type" ];
            right = [ "diagnostics" "spacer" "selections" "spacer" "position-percentage" "spacer" "position" "spacer" "register" ];
            mode = {
              normal = "NORMAL";
              insert = "INSERT";
              select = "SELECT";
            };
          };
        };
        keys.normal = {
          Z.Z = [ ":wqa!" ];
          g.t = [ ":buffer-next" ];
          g.T = [ ":buffer-previous" ];
          X = [ "extend_line_up"  "extend_to_line_bounds" ];
        };
        keys.select = {
          X = [ "extend_line_up"  "extend_to_line_bounds" ];
        };
      };
      languages = {
        # language-server.jdtls = {
        #   command = "${pkgs.jdt-language-server}/bin/jdt-language-server";
        # };
      };
      extraPackages = with pkgs; [
        clang-tools
        elixir-ls elmPackages.elm-language-server erlang-ls
        haskellPackages.haskell-language-server
        # jdt-language-server
        lua-language-server
        marksman
        nil nodePackages.bash-language-server nodePackages.purescript-language-server nushell
        python3Packages.python-lsp-server
        yaml-language-server
      ];
    };

    programs.pandoc = {
      enable = true;
      defaults = {
        pdf-engine = "typst";
      };
    };

    programs.pistol = {
      enable = true;
      associations = [
        # Books
        { mime = "image/vnd.djvu*"; command = "sh: ${pkgs.imagemagickBig}/bin/convert %pistol-filename%[0] JPG:- | ${pkgs.chafa}/bin/chafa -s %pistol-extra0%x%pistol-extra1% --polite on"; }
        { mime = "application/pdf"; command = "sh: ${pkgs.poppler_utils}/bin/pdftoppm -png -singlefile %pistol-filename% | ${pkgs.chafa}/bin/chafa -f sixel -s %pistol-extra0%x%pistol-extra1% --polite on"; }
        { mime = "application/epub\\+zip"; command = "${pkgs.bk}/bin/bk -m %pistol-filename%"; }

        # Documents/Text
        { mime = "text/rtf"; command = "sh: ${pkgs.unrtf}/bin/unrtf --html %pistol-filename% | ${pkgs.w3m}/bin/w3m -T 'text/html' -dump"; }
        { mime = "text/html"; command = "${pkgs.w3m}/bin/w3m -T text/html -dump %pistol-filename%"; }
        { mime = "application/json"; command = "sh: ${pkgs.jq}/bin/jq -C '.' %pistol-filename%"; }
        { mime = "application/x-subrip"; command = "cat %pistol-filename%"; }
        { fpath = ".*\\.opml$"; command = "sh: ${pkgs.yq}/bin/xq -x '.' %pistol-filename% | ${pkgs.bat}/bin/bat --color=always -pp -l xml"; }
      
        # Archives
        { mime = "application/x-7z-compressed"; command = "sh: ${pkgs.atool}/bin/atool -l %pistol-filename% | tail -n +19"; }


        { mime = "audio/*"; command = "${pkgs.exiftool}/bin/exiftool -Title -Artist -Album -Comment -Duration -AudioBitrate  %pistol-filename%"; }
        { mime = "image/*"; command = "${pkgs.chafa}/bin/chafa -f sixel -s %pistol-extra0%x%pistol-extra1% --animate off %pistol-filename% --polite on"; }
        { mime = "video/*"; command = "sh: ${pkgs.ffmpegthumbnailer}/bin/ffmpegthumbnailer -i %pistol-filename% -c jpg -s 0 -o - | ${pkgs.chafa}/bin/chafa -f sixel -s %pistol-extra0%x%pistol-extra1% --polite on"; }

      ];
    };

    programs.yazi = {
      enable = false;
      enableBashIntegration = true;
      settings = {
        sort_by = "natural";
        sort_dir_first = true;
        sort_sensitive = false;
        sort_translit = true;
      };
    };

    home.file.".config/lf/colors".source = builtins.fetchurl "https://raw.githubusercontent.com/gokcehan/lf/master/etc/colors.example";
    home.file.".config/lf/icons".source = builtins.fetchurl "https://raw.githubusercontent.com/gokcehan/lf/master/etc/icons.example";

    programs.lf = {
      enable = true;
      previewer = {
        source = "${pkgs.pistol}/bin/pistol";
      };
      settings = {
        drawbox = true;
        ifs = "\n";
        incfilter = true;
        incsearch = true;
        promptfmt = "\\033[34;1m%d\\033[0m\\033[1m%f\\033[0m";
        sixel = true;
      };
      keybindings = {
        "." = "set hidden!";
        DD = "delete";
        gd = "cd ~/downloads";
        gD = "cd ~/documents";
        ge = "bottom";
        gh = "cd ~";
        gp = "cd ~/pictures";
        gr = "cd /media/removable";
        gs = "cd /media/storage";
        gS = "cd ~/documents/school";
        gv = "cd ~/videos/";
        "g/" = "cd /";

        "<a-f>" = "filter";

        "xd" = ''& ${pkgs.ripdrag}/bin/ripdrag -A -x $fx'';
        "xr" = ''''${{ [ -n "$fs" ] && vidir $fs || vidir $PWD }}'';
        "xm" = ''$mpv $fx'';
        "xw" = ''$pandoc -t html "$f" | w3m -T text/html'';
      };
      extraConfig = ''
      '';
    };

    programs.readline = {
      enable = true;
      includeSystemConfig = true;
      bindings = {
        "\\C-l" = "clear-screen";
      };
      extraConfig = ''
        set editing-mode vi
        set show-mode-in-prompt on
        set vi-ins-mode-string \1\e[6 q\2
        set vi-cmd-mode-string \1\e[2 q\2
        set editing-mode vi
        $if mode=vi
        set keymap vi-command
        # these are for vi-command mode
        "\e[A": history-search-backward
        "\e[B": history-search-forward
        j: history-search-forward
        k: history-search-backward
        set keymap vi-insert
        # these are for vi-insert mode
        "\e[A": history-search-backward
        "\e[B": history-search-forward
        $endif
      '';
    };

    services.syncthing.enable = true;

    programs.yt-dlp = {
      enable = true;
      settings = {
        embed-metadata = true;
        embed-thumbnail = true;
        embed-subs = true;
        format = "bestaudio+bestvideo[height<=1080]";
        merge-output-format = "mkv";
        sub-langs = "en,eo";
      };
    };

    programs.zellij = {
      enable = true;
      settings = {
        mouse_mode = false;
        simplified_ui = true;
        theme = "catppuccin-mocha";
        themes.custom = with config.home.sessionVariables; {
          fg = "#${foreground}";
          bg = "#${background}";
          black = "#${black}";
          red = "#${red}";
          green = "#${green}";
          yellow = "#${yellow}";
          blue = "#${blue}";
          magenta = "#${magenta}";
          cyan = "#${cyan}";
          white = "#${white}";
          orange = "#${brightRed}";
        };
        ui = {
          pane_frames.hide_session_name = true;
        };
      };
    };
    home.file.".config/zellij/layouts/multimedia.kdl" = {
      text = ''
        layout name="multimedia" {
        	default_tab_template {
        		pane name="tab-bar" size=1 borderless=true {
        	        plugin location="zellij:tab-bar"
        	    }
        		children
        	    pane name="status-bar" size=2 borderless=true {
        	        plugin location="zellij:status-bar"
        	    }
        	}

        	tab name="ncmpcpp" {
        		pane command="ncmpcpp"
        	}
        	tab name="newsboat" {
        		pane command="newsboat"
        	}
        	tab name="audio" split_direction="horizontal" {
        		pane command="pulsemixer"
        		pane command="bluetuith"
        	}
        	tab name="background" {
        		pane {
              command "bash"
              args "-c" "while true; do ~/projects/programming/rssfeed_hackery/run.sh; sleep 1h; done"
            }
        	}
        }
      '';
    };

    xdg = {
      enable = true;
      userDirs = {
        enable = true;
        desktop = "$HOME/";
        documents = "$HOME/documents";
        download = "$HOME/downloads";
        pictures = "$HOME/pictures";
        videos = "$HOME/videos";
      };
    };
  };
}
