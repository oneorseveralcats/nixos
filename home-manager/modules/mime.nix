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
    
    xdg = {
      desktopEntries = {
        atool-list = {
          name = "atool-list";
          exec = "atool -l %f";
          terminal = true;
          noDisplay = true;
          mimeType = [ "application/zip" "application/x-rar" "application/x-7z-compressed" ];
        };
        lf-term = {
          name = "lf-term";
          # TODO: unhard-code terminal value.
          exec = ''foot --title=Files --app-id=floating -- lf %F'';
          icon = "lf";
          noDisplay = true;
          terminal = false;
          mimeType = [ "inode/directory" ];
        };
      };
      mimeApps = {
        enable = true;
        defaultApplications = {
          # reading
          "application/epub+zip" = [ "org.pwmt.zathura.desktop" "calibre-ebook-viewer.desktop" "calibre-gui.desktop" ];
          "application/pdf" = [ "org.pwmt.zathura.desktop" "calibre-ebook-viewer.desktop" "calibre-gui.desktop" ];
          "image/vnd.djvu" = [ "org.pwmt.zathura.desktop" "calibre-ebook-viewer.desktop" "calibre-gui.desktop" ];
          "application/vnd.comicbook+zip" = [ "YACReader.desktop" "org.pwmt.zathura-cb.desktop" ];
          "application/vnd.comicbook-rar" = [ "YACReader.desktop" "org.pwmt.zathura-cb.desktop" ];

          # images
          "image/bmp" = [ "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/gif" = [ "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/jpeg" = [ "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/jpg" = [ "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/png" = [ "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/tiff" = [ "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/x-bmp" = [ "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/x-portable-anymap" = [ "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/x-portable-bitmap" = [ "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/x-portable-graymap" = [ "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/x-tga" = [ "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/x-xpixmap" = [ "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/webp" = [ "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/heic" = [ "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/svg+xml" = [ "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "application/postscript" = [ "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/jp2" = [ "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/jxl" = [ "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/avif" = [ "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];
          "image/heif"= [ "swayimg.desktop" "pqiv.desktop" "gimp.desktop" "firefox.desktop" ];

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
          "text/english" = [ "Helix.desktop" "nvim.desktop" ];
          "text/plain" = [ "Helix.desktop" "nvim.desktop" ];
          "text/x-makefile" = [ "Helix.desktop" "nvim.desktop" ];
          "text/x-c++hdr" = [ "Helix.desktop" "nvim.desktop" ];
          "text/x-c++src" = [ "Helix.desktop" "nvim.desktop" ];
          "text/x-chdr" = [ "Helix.desktop" "nvim.desktop" ];
          "text/x-csrc" = [ "Helix.desktop" "nvim.desktop" ];
          "text/x-haskell" = [ "Helix.desktop" "nvim.desktop" ];
          "text/x-java" = [ "Helix.desktop" "nvim.desktop" ];
          "text/x-moc" = [ "Helix.desktop" "nvim.desktop" ];
          "text/x-pascal" = [ "Helix.desktop" "nvim.desktop" ];
          "text/x-tcl" = [ "Helix.desktop" "nvim.desktop" ];
          "text/x-tex" = [ "Helix.desktop" "nvim.desktop" ];
          "application/x-shellscript" = [ "Helix.desktop" "nvim.desktop" ];
          "text/x-c" = [ "Helix.desktop" "nvim.desktop" ];
          "text/x-c++" = [ "Helix.desktop" "nvim.desktop" ];
          "application/json" = [ "Helix.desktop" "nvim.desktop" ];
          "text/html" = [ "firefox.desktop" "chromium.desktop" ];

          # documents
          "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [ "base.desktop"];
          "application/vnd.oasis.opendocument.text" = [ "base.desktop"];
          "text/rtf" = [ "base.desktop"];

          "application/zip"  = [ "atool-list.desktop" ];
          "application/x-rar"  = [ "atool-list.desktop" ];
          "application/x-7z-compressed" = [ "atool-list.desktop" ];

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
