{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.clojure;
in
{
  options.myHome.programming.languages.clojure = {
    enable = lib.mkEnableOption "Enable the clojure programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      clojure
    ];
  };
}


