{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.html-css;
in
{
  options.myHome.programming.languages.html-css = {
    enable = lib.mkEnableOption "Enable language support for html and css.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      tidy
    ];
  };
}




