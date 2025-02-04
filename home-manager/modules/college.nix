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
    ];

    myHome.programming.languages = {
      algol.enable = true;
      cobol.enable = true;
      dotnet.enable = true;
      fortran.enable = true;
    };
  };
}
