{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.r;
  rPkg = pkgs.rWrapper.override{ packages = with pkgs.rPackages; [ languageserver ]; };
in
{
  options.myHome.programming.r = {
    enable = lib.mkOption {
      description = "Enable the R programming language and tools.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      rPkg
    ];
  };
}

