{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.clojure;
in
{
  options.myHome.programming.languages.clojure = {
    enable = lib.mkOption {
      description = "Enable the clojure programming language and tools.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      clojure
      clojure-lsp
    ];
  };
}


