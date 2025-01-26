{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.c;
in
{
  options.myHome.programming.c = {
    enable = lib.mkOption {
      description = "Enable the C/C++ programming language and tools.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gcc clang-tools
    ];
  };
}


