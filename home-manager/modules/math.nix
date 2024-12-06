{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.math;
in
{
  options.myHome.math = {
    enable = lib.mkOption {
      description = "Enable math related packages and settings.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      giac-with-xcas gnuplot
    ];

    home.file.".wcalcrc".text = ''
      color=true
      engineering=never
      save_errors=true
      use_radians=true
    '';
  };
}
