{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.elm;
in
{
  options.myHome.programming.elm = {
    enable = lib.mkOption {
      description = "Enable the elm programming language and tools.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      elmPackages.elm
      elmPackages.elm-language-server
    ];
  };
}

