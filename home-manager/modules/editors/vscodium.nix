{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.editors.vscodium;
in
{
  options.myHome.editors.vscodium = {
    enable = lib.mkOption {
      description = "Enable the vscodium IDE.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
    };
  };
}
