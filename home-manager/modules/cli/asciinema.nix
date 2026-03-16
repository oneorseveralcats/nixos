{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.cli.asciinema;
in
{
  options.myHome.cli.asciinema = {
    enable = lib.mkEnableOption "ascii-cinema a terminal session recorder.";
  };

  config = mkIf cfg.enable {
    programs.asciinema = {
      enable = true;
    };
  };
}
