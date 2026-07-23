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

        "i" = "script-binding stats/display-stats-toggle";

        "alt+f" = "script-binding file_browser/browse-files";
        "alt+p" = "script-binding playlistmanager/showplaylist";
        "alt+q" = "script-binding quality_menu/video_formats_toggle";

        # mvi
        "i {mvi}" = "script-message status-line-toggle";
        # "SPACE {mvi}" = "nonrepeatable playlist-next";
        # "Shift+SPACE {mvi}" = "nonrepeatable playlist-prev";
      };
      config = {
        osc = "no";
        osd-font-size = "20";
        osd-level = "3";
        osd-msg3 = "\${time-pos}/\${duration} (\${playtime-remaining})";
        hwdec = "auto";
        gpu-context-pre = "wayland"; # TODO: check if this is necessary for fullscreen playback of AV1 video after v0.41.0
        sub-scale = "0.75";
        volume = "70";
        alang = "eng,epo";
        slang = "eng,epo";
        sub-auto = "fuzzy";
        screenshot-directory = "~/pictures/mpv/";
        autocreate-playlist = "same";
        image-display-duration = "inf";
        directory-mode = "ignore";
        auto-window-resize = "no";
        ytdl-format = ''bv[height<=720][vcodec!~='vp0?9']+ba/bv+ba/best'';
        ytdl-raw-options = "format-sort=[lang,res,size,fps,quality,br]";
      };

      profiles = rec {
        mvi = {
          profile-cond= ''p["current-tracks/video/image"]'';
          image-display-duration = "inf";
          keepaspect-window = "no";
          loop-playlist = "inf";
          osd-level = "0";
          wayland-app-id = "mvi";
        };
        "extension.gif" = {
          loop-file = "inf";
          profile = "mvi";
        };
      };

      scripts = with pkgs.mpvScripts; [
        mpris
        mpv-playlistmanager
        reload
        sponsorblock-minimal # sponsorblock
        # manga-reader
        mpv-image-viewer.status-line
        mpv-image-viewer.ruler
        mpv-image-viewer.minimap
        mpv-image-viewer.image-positioning
        # mpv-image-viewer.freeze-window
        mpv-image-viewer.equalizer
        mpv-image-viewer.detect-image
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

          playlist_display_timeout = "15";
        };

        file_browser = {}; # TODO? https://github.com/CogentRedTester/mpv-file-browser/blob/master/docs/file_browser.conf

        # mvi
        detect_image = {
          command_on_first_image_loaded = "apply-profile mvi; enable-section mvi";
          command_on_non_image_loaded = "disable-section mvi";
        };

        status_line = {
          enabled = "no";
          size = "24";
          text_bottom_left = "\${filename}";
          text_bottom_right = "[\${playlist-pos-1}/\${playlist-count}]";
        };
      };
    };

  };
}
