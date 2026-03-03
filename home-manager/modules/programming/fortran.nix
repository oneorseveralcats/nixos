{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.fortran;
in
{
  options.myHome.programming.languages.fortran = {
    enable = lib.mkEnableOption "Enable the FORTRAN programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gfortran
    ];
  };
}



