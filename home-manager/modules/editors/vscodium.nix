{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.editors.vscodium;
in
{
  options.myHome.editors.vscodium = {
    enable = lib.mkEnableOption "Enable the vscodium IDE.";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
    };
  };
}
