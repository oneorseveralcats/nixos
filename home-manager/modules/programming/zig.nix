{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.zig;
in
{
  options.myHome.programming.languages.zig = {
    enable = lib.mkEnableOption "Enable the zig programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      zig
    ];
  };
}



