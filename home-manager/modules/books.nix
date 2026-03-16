{ config, lib, pkgs, ... }:
with lib;
let 
  aspell = pkgs.aspellWithDicts (dicts: with dicts; [ de fr en es ]);
  cfg = config.myHome.books;
in
{
  options.myHome.books = {
    enable = lib.mkEnableOption "Enable ebook/reading related packages.";
    extras.enable = lib.mkEnableOption "Enable packages for creating/modifying ebook formats.";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      myHome.books.extras.enable = lib.mkDefault true;

      home.sessionVariables = {
        CALIBRE_USE_SYSTEM_THEME = 1;
      };

      home.packages = with pkgs; [
        bk
        epr
        yacreader
        calibre
      ];
    })
    (mkIf cfg.extras.enable {
      home.packages = with pkgs; [
        aspell
        img2pdf
        ocrmypdf
        poppler-utils python3Packages.weasyprint
        scantailor-advanced 
        tesseract texlive.combined.scheme-small
      ];
    })
  ];
}
