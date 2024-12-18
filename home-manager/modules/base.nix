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
      q = "exit";
      weather = "${pkgs.curl}/bin/curl wttr.in/Cincinnati?2QFu";
    };

    home.packages = with pkgs; [
      amfora asciinema
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

    programs.fzf = {
      enable = true;
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
        hwdec = "auto-safe";
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
        ytdl-format = ''bv[height<=720][vcodec!~='vp0?9']+ba/bv+ba/best'';
        ytdl-raw-options = "format-sort=[lang,res,size,fps,quality,br]";
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

    programs.pandoc = {
      enable = true;
      defaults = {
        pdf-engine = "typst";
      };
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
