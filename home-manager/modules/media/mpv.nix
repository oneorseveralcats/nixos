{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.media.mpv;
in
{
  options.myHome.media.mpv = {
    enable = lib.mkEnableOption "Enable the mpv media player.";
  };

  config = mkIf cfg.enable {
    services.playerctld.enable = true;

    home.packages = [
      pkgs.mpvc
    ];

    programs.mpv = {
      enable = true;
      bindings = {
        "ctrl+p" = "show_text \${playlist}";
        "ctrl+w"  = "ignore";
        "WHEEL_UP" = "ignore";
        "WHEEL_DOWN" = "ignore";
        # "b" = "cycle-values vf \"sub,lavfi=negate\" \"\"";

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
        ytdl-format = ''bv[height<=720][vcodec!~='vp0?9']+ba/bv+ba/best'';
        ytdl-raw-options = "format-sort=[lang,res,size,fps,quality,br]";
      };
      scripts = with pkgs.mpvScripts; [
        mpris
        mpv-playlistmanager
        quality-menu
        reload
        sponsorblock-minimal # sponsorblock
        visualizer
        # manga-reader
        # mpv-image-viewer.status-line
        # mpv-image-viewer.ruler
        # mpv-image-viewer.minimap
        # mpv-image-viewer.image-positioning
        # mpv-image-viewer.freeze-window
        # mpv-image-viewer.equalizer
        # mpv-image-viewer.detect-image
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

  };
}
