{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.fortran;
in
{
  options.myHome.programming.languages.fortran = {
    enable = lib.mkOption {
      description = "Enable the FORTRAN programming language and tools.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gfortran
    ];
  };
}



