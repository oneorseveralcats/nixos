{ config, lib, pkgs, ... }:
with lib;
let 
  aspell = with pkgs; aspellWithDicts (dicts: with dicts; [ de fr en es ]);
  cfg = config.myHome.books;
  unstable = import <nixos-unstable> {};
in
{
  options.myHome.books = {
    enable = lib.mkOption {
      description = "Enable ebook/reading related packages.";
      type = types.bool;
      default = true;
    };
    extras.enable = lib.mkOption {
      description = "Enable packages for creating/modifying ebook formats.";
      type = types.bool;
      default = false;
    };
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
        unoconv

        unstable.calibre
      ];
    })
    (mkIf cfg.extras.enable {
      home.packages = with pkgs; [
        aspell
        img2pdf
        ocrmypdf
        poppler_utils python3Packages.weasyprint
        scantailor-advanced 
        tesseract texlive.combined.scheme-small
      ];
    })
  ];
}
