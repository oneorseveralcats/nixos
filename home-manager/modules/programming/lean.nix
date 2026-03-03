{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.lean;
in
{
  options.myHome.programming.languages.lean = {
    enable = lib.mkEnableOption "Enable the Lean programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      lean4
    ];
  };
}

