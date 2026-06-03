{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.file-managers.pistol;
in
{
  options.myHome.file-managers.pistol = {
    enable = lib.mkEnableOption "Enable the pistol file preview program for tui file managers.";
  };

  config = mkIf cfg.enable {
    programs.pistol = {
      enable = true;
      associations = [
        # Books
        { mime = "image/vnd.djvu*"; command = "sh: ${pkgs.imagemagickBig}/bin/convert %pistol-filename%[0] JPG:- | ${pkgs.chafa}/bin/chafa -s %pistol-extra0%x%pistol-extra1% --polite on"; }
        { mime = "application/pdf"; command = "sh: ${pkgs.poppler-utils}/bin/pdftoppm -png -singlefile %pistol-filename% | ${pkgs.chafa}/bin/chafa -f sixel -s %pistol-extra0%x%pistol-extra1% --polite on"; }
        { mime = "application/epub\\+zip"; command = "${pkgs.bk}/bin/bk -m %pistol-filename%"; }

        # Documents/Text
        { mime = "text/rtf"; command = "sh: ${pkgs.unrtf}/bin/unrtf --html %pistol-filename% | ${pkgs.w3m}/bin/w3m -T 'text/html' -dump"; }
        { mime = "text/html"; command = "${pkgs.w3m}/bin/w3m -T text/html -dump %pistol-filename%"; }
        { mime = "application/json"; command = "sh: ${pkgs.jq}/bin/jq -C '.' %pistol-filename%"; }
        { mime = "application/x-subrip"; command = "cat %pistol-filename%"; }
        { fpath = ".*\\.opml$"; command = "sh: ${pkgs.yq}/bin/xq -x '.' %pistol-filename% | ${pkgs.bat}/bin/bat --color=always -pp -l xml"; }
      
        # Archives
        { mime = "application/x-7z-compressed"; command = "${pkgs.exiftool}/bin/exiftool -FileName -FileSize %pistol-filename%"; }
        { mime = "application/gzip"; command = "${pkgs.exiftool}/bin/exiftool -FileName -FileSize %pistol-filename%"; }


        { mime = "audio/*"; command = "${pkgs.exiftool}/bin/exiftool -Title -Artist -Album -Comment -Duration -AudioBitrate  %pistol-filename%"; }
        { mime = "image/*"; command = "${pkgs.chafa}/bin/chafa -f sixel -s %pistol-extra0%x%pistol-extra1% --animate off %pistol-filename% --polite on"; }
        { mime = "video/*"; command = "sh: ${pkgs.ffmpegthumbnailer}/bin/ffmpegthumbnailer -i %pistol-filename% -c jpg -s 0 -o - | ${pkgs.chafa}/bin/chafa -f sixel -s %pistol-extra0%x%pistol-extra1% --polite on"; }
      ];
    };
  };
}
