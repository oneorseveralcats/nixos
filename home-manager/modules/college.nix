{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.college;
in
{
  options.myHome.college = {
    enable = lib.mkOption {
      description = "Enable packages and settings that are needed by college courses.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      algol68g marst # algol 68
      gnucobol       # cobol
      sbcl           # common-lisp
      gfortran       # fortran


      # TODO: find a PL/1 compiler?
    ];
  };
}
