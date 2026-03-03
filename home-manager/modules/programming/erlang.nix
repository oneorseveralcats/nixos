{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.erlang;
in
{
  options.myHome.programming.languages.erlang = {
    enable = lib.mkEnableOption "Enable the erlang programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      erlang
    ];
  };
}





