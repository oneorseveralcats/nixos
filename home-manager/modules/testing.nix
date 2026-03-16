{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.testing;
in
{
  imports = [
  ];

  options.myHome.testing = {
    enable = lib.mkEnableOption "Enable packages and settings that are currently being tested.";
  };

  config = let
    w3mDir = "${config.xdg.configHome}/w3m";
  in mkIf cfg.enable {
    home.packages = with pkgs; [
      ansible
      hugo
      rippkgs

      unstable.chawan
    ];

    myHome.browsers.w3m = {
      enable = true;
      package = pkgs.w3m.overrideAttrs {
        version = "git";
        src = pkgs.fetchFromSourcehut {
          owner = "~rkta";
          repo = "w3m";
          rev = "f66fade88b777511b093bc2690883175a7b0d47e";
          sha256 = "sha256-K9uWdt2pWkqHG9CyIzS8WnHHPqn/vy5BW0Ci/Qr/mzc=";
        };
      };
      w3mImg2Sixel = "img2sixel -d atkinson";
      homePage = "${w3mDir}/bookmark.html";
      bindings = {
        "h" = "LEFT";
        "k" = "DOWN";
        "j" = "UP";
        "l" = "RIGHT";
        "LEFT" = "LEFT";
        "DOWN" = "UP";
        "UP" = "DOWN";
        "RIGHT" = "RIGHT";

        "M-h" = "MOVE_LEFT";
        "M-j" = "MOVE_DOWN";
        "M-k" = "MOVE_UP";
        "M-l" = "MOVE_RIGHT";
        "M-LEFT" = "MOVE_LEFT";
        "M-DOWN" = "MOVE_DOWN";
        "M-UP" = "MOVE_UP";
        "M-RIGHT" = "MOVE_RIGHT";
        
        "C-u" = "PREV_PAGE";
        "C-d" = "NEXT_PAGE";

        "gh" = "LINE_BEGIN";
        "gl" = "LINE_END";
        "\\^" = "LINE_BEGIN";
        "0" = "LINE_BEGIN";
        "$" = "LINE_END";
        "C-a" = "LINE_BEGIN";
        "C-e" = "LINE_END";

        "w" = "NEXT_WORD";
        "W" = "PREV_WORD";
      
        "SPC" = "NEXT_PAGE";
        "M-SPC" = "PREV_PAGE";
        "TAB" = "NEXT_LINK";
        "M-TAB" = "PREV_LINK";

        "zt" = "CURSOR_TOP";
        "zm" = "CURSOR_MIDDLE";
        "zb" = "CURSOR_BOTTOM";
        # "zt" = "LINE_TOP";
        # "zm" = "LINE_MIDDLE";
        # "zb" = "LINE_BOTTOM";

        "gm" = "MAIN";
        "gg" = "BEGIN";
        "ge" = "END";
        "G" = "END";

        "r" = "RELOAD";
        "R" = "RELOAD";

        "gT" = "PREV_TAB";
        "gt" = "NEXT_TAB";
        "J" = "PREV_TAB";
        "K" = "NEXT_TAB";
        "m" = "MOVE_LIST_MENU";
        "c-H" = "SELECT_MENU";
        "b" = "TAB_MENU";
        "C-t" = "NEW_TAB";
        "d" = "CLOSE_TAB";
        "C-w" = "CLOSE_TAB";
        "M-b" = "BOOKMARK";

        "H" = "BACK";

        "/" = "ISEARCH";
        "?" = "ISEARCH_BACK";
        "n" = "SEARCH_NEXT";
        "N" = "SEARCH_PREV";
        "f" = "LIST_MENU";
        "F" = ''COMMAND "NEW_TAB; LIST_MENU"'';

        # "f" = ''COMMAND "RESHAPE ; LINK_BEGIN ; GOTO_LINK"'';
        # "F" = ''COMMAND "RESHAPE ; LINK_BEGIN ; TAB_LINK"'';

        # "C-s" = "SAVE_LINK";
        "C-s" = "SAVE";
        "C-l" = "REDRAW";
        "C-i" = "INFO";
        "q" = ''COMMAND "READ_SHELL 'rm ${w3mDir}/session 2>/dev/null'; BACK; STORE; EXIT"'';
        "Q" = "EXIT";

        "\";\"d" = "DOWNLOAD_LIST";
        "\";\"h" = "HISTORY";
        "\";\"m" = "MENU";

        "M-x" = "COMMAND";
        ":" = "COMMAND";
        
        "@" = "READ_SHELL";
        "!" = "SHELL";
        "|" = "PIPE_BUF";
        "#" = "PIPE_SHELL";
        
        "o" = ''COMMAND "SET_OPTION dictprompt='open '; SET_OPTION dictcommand=file:/cgi-bin/handler; DICT_WORD"'';
        "t" = ''COMMAND "SET_OPTION dictprompt='tabopen '; SET_OPTION dictcommand=file:/cgi-bin/handler; NEW_TAB; DICT_WORD"'';
        "O" = "GOTO";
        "T" = "TAB_GOTO";
        "M-o" = "GOTO_LINK";
        "M-t" = "TAB_LINK";

        "M-r" = ''GOTO reader:'';

        "X"  = "EXTERN";
        "yy" = ''COMMAND "EXTERN ${pkgs.wl-clipboard}/bin/wl-copy; MESSAGE 'link copied!'"'';
        "yh" = ''COMMAND "EXTERN_LINK ${pkgs.wl-clipboard}/bin/wl-copy; MESSAGE 'link copied!'"'';
        "xm" = ''COMMAND "EXTERN_LINK '${pkgs.mpv}/bin/mpv --terminal=yes %s &'; MESSAGE 'video opened!'"'';

        # "C-@" = "MARK";
        # "\\\"" = "REG_MARK";
        # ":" = "MARK_URL";
        # "\";\"" = "MARK_WORD";
        # "M-:" = "MARK_MID";
        # "M-n" = "NEXT_MARK";
        # "M-p" = "PREV_MARK";
        
        # "C-g" = "LINE_INFO";
        # "C-k" = "COOKIE";
        # "C-w" = "WRAP_TOGGLE";
        # "C-z" = "SUSPEND";

        # "(" = "UNDO";
        # ")" = "REDO";
        # "E" = "EDIT";
        # "F" = "FRAME";
        # "H" = "HELP";
        # "I" = "VIEW_IMAGE";
        # "L" = "LIST";
        # "M" = "EXTERN";
        # "S" = "SAVE_SCREEN";
        # "U" = "GOTO";
        # "V" = "LOAD";
        # "Z" = "CENTER_H";
        # "c" = "PEEK";
        # "i" = "PEEK_IMG";
        # "u" = "PEEK_LINK";
        # "v" = "VIEW";
        # "z" = "CENTER_V";

      #   "M-I" = "SAVE_IMAGE";
      #   "M-M" = "EXTERN_LINK";
      #   "M-W" = "DICT_WORD_AT";
      #   "M-e" = "EDIT_SCREEN";
      #   "M-g" = "GOTO_LINE";
      #   "M-k" = "DEFINE_KEY";
      #   "M-o" = "SET_OPTION";
      #   "M-u" = "GOTO_RELATIVE";
      #   "M-w" = "DICT_WORD";
      };

      settings = {
        cgi_bin = "${w3mDir}/w3m/cgi-bin";
        mailcap = "${w3mDir}/w3m/mailcap";
        urimethodmap = "${w3mDir}/w3m/urimethodmap";
        passwd_file = "${w3mDir}/w3m/passwd";
        pre_form_file = "${w3mDir}/w3m/pre_form";
        siteconf_file = "${w3mDir}/w3m/siteconf";

        dl_dir = "${config.xdg.userDirs.download}/downloads";
        tmp_dir = "${config.xdg.cacheHome}/w3m";

        editor = "$EDITOR";

        bgextviewer = 1;
        extbrowser = "xdg-open %s";
        extbrowser2 = "url=%s && ${pkgs.mpv}/bin/mpv $url &";

        dirlist_cmd = "file:/cgi-bin/lf";

        tabstop = 4;
        pixel_per_char = 13;
        pixel_per_line = 27;
        display_link = 0;
        display_link_number = 0;
        decode_url = 1;
        display_lineinfo = 1;
        display_column_number = 1;
        graphic_char = 1;
        fold_textarea = 1;
        fold_pre = 1;
        display_ins_del = 2;
        inline_img_protocol = 2;
        # imgdisplay = "chafa";
        fold_line = 1;
        label_topline = 1;
        nextpage_topline = 1;
        high-intensity = 1;
        active_style = 1;
        visited_anchor = 1;
        vi_prec_num = 1;
        mark_all_pages = 1;
        wrap_search = 1;
        use_lessopen = 0;
        user_agent = "lynx";
        meta_refresh = 1;
        use_cookie = 1;
      };
      
      siteconf = [
        { url =  "https://duckduckgo.com/l/?uddg="; preferences = [ "url_charset utf-8" ''substitute_url ""'' ]; }
      ];
      urimethodmap = {
        gemini = "file:/cgi-bin/gemini?%s";
        reader = "file:/cgi-bin/reader?%s";
      };
      bookmarks = {
        title = "Bookmarks";
        marks = {
          gemini = [
            { name = "kennedy"; url = "https://portal.mozz.us/gemini/kennedy.gemi.dev/search"; }
            { name = "gemplex"; url = "https://portal.mozz.us/gemini/gemplex.space/search"; }
            { name = "TLGS"; url = "https://portal.mozz.us/gemini/tlgs.one/search"; }

            { name = "antenna"; url = "https://portal.mozz.us/gemini/warmedal.se/~antenna/"; }
            { name = "BBS"; url = "https://portal.mozz.us/gemini/bbs.geminispace.org/"; }
            { name = "cosmos"; url = "https://portal.mozz.us/gemini/skyjake.fi/~Cosmos/"; }
            { name = "station"; url = "https://portal.mozz.us/gemini/station.martinrue.com/"; }

            { name = "skyjake"; url = "https://portal.mozz.us/gemini/skyjake.fi/"; }
          ];
          gopher = [
            { name = "gopherpedia"; url = "gopher://gopherpedia.com/7/lookup"; }
            { name = "bitreich"; url = "gopher://bitreich.org/1/lawn"; }
            { name = "hackernews"; url = "gopher://hngopher.com/"; }
            { name = "parazy"; url = "gopher://bay.parazy.de:666"; }
          ];
        };
      };
      cgiBin = {
        handler.source = let
          engines = with config.myHome.browsers.settings; search-engines // {
            w = search-engines.gopherpedia;
            yt = search-engines.idiotbox;
          };
          generateSearchEngines = set: lib.concatMapAttrsStringSep "\n"
            (k: v: ''${k}) echo "W3m-control: GOTO ${lib.replaceStrings [ "%s" ] [ "$QUERY" ] v}";;'') set;
        in pkgs.writeShellScript "handler" ''
          clean_url () {
            echo "$1" | sed 's_%3A_:_g;
                             s_%2F_/_g;
                             s_+_ _g' | xargs
          }

          is_valid_url () {
            # regex='(https?|ftp|file|gopher|gemini)://[-[:alnum:]\+&@#/%?=~_|!:,.;]*[-[:alnum:]\+&@#/%=~_|]'
            regex='^((https?|ftp|file|gopher|gemini)://)?[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]\.[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]$'

            [[ "$1" =~ $regex ]] && return 0
          }

          CLEANED_QUERY=$(clean_url "$QUERY_STRING")

          PREFIX=$(echo "$CLEANED_QUERY" | cut -d' ' -f1)
          QUERY=$(echo "$CLEANED_QUERY" | cut -d' ' -f2-)

          echo "QUERY_STRING: \"$QUERY_STRING\""
          echo "CLEANED_QUERY: \"$CLEANED_QUERY\""
          echo "SCHEME: \"$PREFIX\""
          echo "ADDRESS: \"$QUERY\""
          is_valid_url "$CLEANED_QUERY" && echo "URL VALID" || echo "URL NOT VALID" 

          if is_valid_url "$CLEANED_QUERY"; then
            echo "W3m-control: GOTO $CLEANED_QUERY"
          else
            case $PREFIX in
          ${generateSearchEngines engines}
              *) echo "W3m-control: GOTO https://lite.duckduckgo.com/lite/?q=$CLEANED_QUERY";;
            esac
          fi

          echo "W3m-control: DELETE_PREVBUF"
        '';

        reader.source = pkgs.writeShellScript "rdrview" ''
          echo "W3m-control: BACK"
          echo "W3m-control: READ_SHELL rdrview -H $W3M_URL 2>/dev/null"
          echo "W3m-control: VIEW"
          echo "W3m-control: DELETE_PREVBUF"

          # stdin="$(cat)"
          # echo "<!DOCTYPE html>"
          # echo "<html>"
          # echo "<h1>test</h1>"
          # echo "$stdin" | ${pkgs.rdrview}/bin/rdrview -H -T title,sitename,body
          # echo "</html>"
        '';

        gemini.source = pkgs.writeShellScript "gemini" ''
          QUERY_STRING=$(echo "$QUERY_STRING" | cut -d '/' -f3-)

          echo "W3m-control: GOTO https://portal.mozz.us/gemini/$QUERY_STRING"
        '';

        lf.source = pkgs.writeShellScript "lflist" ''
          read stdin
          echo "W3m-control: GOTO $(${pkgs.lf}/bin/lf -print-selection $stdin)"
          echo "W3m-control: DELETE_PREVBUF"
        '';
      };

      extraPackages = with pkgs; [
        chafa
        libsixel
        rdrview
      ];
    };

    home.file.".local/bin/w3m" = {
      source = pkgs.writeShellScript "w3m-session-restore" ''
        if [ -e "${w3mDir}/session" ]; then
            ~/.nix-profile/bin/w3m -R "$@"
        else
            ~/.nix-profile/bin/w3m "$@"
        fi
      '';
      executable = true;
    };
  };
}
