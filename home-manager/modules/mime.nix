{ config, lib, ... }:
with lib;
let 
  cfg = config.myHome.mime;
in
{
  options.myHome.mime = {
    enable = lib.mkEnableOption "Enable mimetype configurations.";
  };

  config = mkIf cfg.enable {
    xdg.mime.enable = true;
    xdg.configFile."mimeapps.list".force = true;
    
    xdg = rec {
      desktopEntries = let
        term = "${config.home.sessionVariables.TERMINAL}";
      in {
        # mvi = {
        #   name = "mvi";
        #   exec = ''mpv --profile=mvi -- %U'';
        #   noDisplay = true;
        # };

        hx-term = {
          name = "hx-term";
          exec = ''${term} -- hx %F'';
          noDisplay = true;
        };
        bk-term = {
          name = "bk-term";
          exec = ''${term} --font=monospace:size=24 --title=Reader --app-id=ws4-focus -- bk %f'';
          noDisplay = true;
        };
        lf-term = {
          name = "lf-term";
          exec = ''${term} --title=Files --app-id=floating -- lf %F'';
          # mimeType = [ "inode/directory" ];
          noDisplay = true;
        };
      };
      mimeApps = {
        enable = true;
        defaultApplications = {
          # reading
          "application/epub+zip" = [ "bk-term.desktop" "org.pwmt.zathura.desktop" "calibre-ebook-viewer.desktop" "calibre-gui.desktop" ];
          "application/pdf" = [ "org.pwmt.zathura.desktop" "calibre-ebook-viewer.desktop" "calibre-gui.desktop" ];
          "image/vnd.djvu" = [ "org.pwmt.zathura.desktop" "calibre-ebook-viewer.desktop" "calibre-gui.desktop" ];
          "application/vnd.comicbook+zip" = [ "mvi.desktop" "YACReader.desktop" "org.pwmt.zathura-cb.desktop" ];
          "application/vnd.comicbook-rar" = [ "mvi.desktop" "YACReader.desktop" "org.pwmt.zathura-cb.desktop" ];
          "application/x-cb7" = [ "mvi.desktop" "YACReader.desktop" "org.pwmt.zathura-cb.desktop" ];

          # images
          "image/bmp" = [ "mvi.desktop" "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/gif" = [ "mvi.desktop" "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/jpeg" = [ "mvi.desktop" "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/jpg" = [ "mvi.desktop" "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/png" = [ "mvi.desktop" "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/tiff" = [ "mvi.desktop" "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/x-bmp" = [ "mvi.desktop" "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/x-portable-anymap" = [ "mvi.desktop" "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/x-portable-bitmap" = [ "mvi.desktop" "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/x-portable-graymap" = [ "mvi.desktop" "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/x-tga" = [ "mvi.desktop" "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/x-xpixmap" = [ "mvi.desktop" "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/webp" = [ "mvi.desktop" "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/heic" = [ "mvi.desktop" "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/svg+xml" = [ "mvi.desktop" "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "application/postscript" = [ "mvi.desktop" "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/jp2" = [ "mvi.desktop" "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/jxl" = [ "mvi.desktop" "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/avif" = [ "mvi.desktop" "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/heif"= [ "mvi.desktop" "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];

          # video
          "application/x-troff-msvideo" = [ "mpv.desktop" ];
          "video/mpeg" = [ "mpv.desktop" ];
          "video/x-mpeg2" = [ "mpv.desktop" ];
          "video/x-mpeg3" = [ "mpv.desktop" ];
          "video/mp4v-es" = [ "mpv.desktop" ];
          "video/x-m4v" = [ "mpv.desktop" ];
          "video/mp4" = [ "mpv.desktop" ];
          "video/divx" = [ "mpv.desktop" ];
          "video/vnd.divx" = [ "mpv.desktop" ];
          "video/msvideo" = [ "mpv.desktop" ];
          "video/x-msvideo" = [ "mpv.desktop" ];
          "video/ogg" = [ "mpv.desktop" ];
          "video/quicktime" = [ "mpv.desktop" ];
          "video/vnd.rn-realvideo" = [ "mpv.desktop" ];
          "video/x-ms-afs" = [ "mpv.desktop" ];
          "video/x-ms-asf" = [ "mpv.desktop" ];
          "video/x-ms-wmv" = [ "mpv.desktop" ];
          "video/x-ms-wmx" = [ "mpv.desktop" ];
          "video/x-ms-wvxvideo" = [ "mpv.desktop" ];
          "video/x-avi" = [ "mpv.desktop" ];
          "video/avi" = [ "mpv.desktop" ];
          "video/x-flic" = [ "mpv.desktop" ];
          "video/fli" = [ "mpv.desktop" ];
          "video/x-flc" = [ "mpv.desktop" ];
          "video/flv" = [ "mpv.desktop" ];
          "video/x-flv" = [ "mpv.desktop" ];
          "video/x-theora" = [ "mpv.desktop" ];
          "video/x-theora+ogg" = [ "mpv.desktop" ];
          "video/x-matroska" = [ "mpv.desktop" ];
          "video/mkv" = [ "mpv.desktop" ];
          "video/webm" = [ "mpv.desktop" ];
          "video/x-ogm" = [ "mpv.desktop" ];
          "video/x-ogm+ogg" = [ "mpv.desktop" ];
          "video/mp2t" = [ "mpv.desktop" ];
          "video/vnd.mpegurl" = [ "mpv.desktop" ];
          "video/3gp" = [ "mpv.desktop" ];
          "video/3gpp" = [ "mpv.desktop" ];
          "video/3gpp2" = [ "mpv.desktop" ];
          "video/dv" = [ "mpv.desktop" ];

          # text
          "text/english" = [ "hx-term.desktop" "nvim.desktop" ];
          "text/markdown" = [ "hx-term.desktop" "nvim.desktop" ];
          "text/plain" = [ "hx-term.desktop" "nvim.desktop" ];
          "text/x-makefile" = [ "hx-term.desktop" "nvim.desktop" ];
          "text/x-c++hdr" = [ "hx-term.desktop" "nvim.desktop" ];
          "text/x-c++src" = [ "hx-term.desktop" "nvim.desktop" ];
          "text/x-chdr" = [ "hx-term.desktop" "nvim.desktop" ];
          "text/x-csrc" = [ "hx-term.desktop" "nvim.desktop" ];
          "text/x-haskell" = [ "hx-term.desktop" "nvim.desktop" ];
          "text/x-java" = [ "hx-term.desktop" "nvim.desktop" ];
          "text/x-moc" = [ "hx-term.desktop" "nvim.desktop" ];
          "text/x-pascal" = [ "hx-term.desktop" "nvim.desktop" ];
          "text/x-tcl" = [ "hx-term.desktop" "nvim.desktop" ];
          "text/x-tex" = [ "hx-term.desktop" "nvim.desktop" ];
          "application/x-shellscript" = [ "hx-term.desktop" "nvim.desktop" ];
          "text/x-c" = [ "hx-term.desktop" "nvim.desktop" ];
          "text/x-c++" = [ "hx-term.desktop" "nvim.desktop" ];
          "application/json" = [ "hx-term.desktop" "nvim.desktop" ];
          "text/html" = [ "firefox.desktop" "chromium.desktop" ];

          # documents
          "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [ "base.desktop"];
          "application/vnd.oasis.opendocument.text" = [ "base.desktop"];
          "text/rtf" = [ "base.desktop"];

          # "application/zip"  = [ "atool-list.desktop" ];
          # "application/x-rar"  = [ "atool-list.desktop" ];
          # "application/x-7z-compressed" = [ "atool-list.desktop" ];

          # web browser
          "x-scheme-handler/http" = [ "firefox.desktop" "librewolf.desktop" "chromium.desktop" ];
          "x-scheme-handler/https" = [ "firefox.desktop" "librewolf.desktop" "chromium.desktop" ];

          # email
          "x-scheme-handler/mailto" = [ "thunderbird.desktop" ];
          "x-scheme-handler/mid" = [ "thunderbird.desktop" ];

          "inode/directory" = [ "lf-term.desktop" "lf.desktop" "nnn.desktop" ];

          "application/x-xopp" = [ "com.github.xournalpp.xournalpp.desktop" ];
        };
      };
    };
  };
}
