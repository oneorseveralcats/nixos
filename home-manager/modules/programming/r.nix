{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.r;
  rPkg = pkgs.rWrapper.override{ packages = with pkgs.rPackages; [ languageserver ]; };
in
{
  options.myHome.programming.languages.r = {
    enable = lib.mkEnableOption "Enable the R programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      rPkg
    ];
  };
}

