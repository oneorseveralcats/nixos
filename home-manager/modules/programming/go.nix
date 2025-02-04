{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.go;
in
{
  options.myHome.programming.languages.go = {
    enable = lib.mkOption {
      description = "Enable the Go programming language and tools.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      go gopls
    ];
  };
}





