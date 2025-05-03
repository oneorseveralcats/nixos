{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.math;
in
{
  options.myHome.math = {
    enable = lib.mkEnableOption "Enable math related packages and settings.";
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
