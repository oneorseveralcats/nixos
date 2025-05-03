{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.scheme;
in
{
  options.myHome.programming.languages.scheme = {
    enable = lib.mkEnableOption "Enable the scheme programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      guile
    ];
  };
}

