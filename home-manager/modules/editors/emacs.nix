{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.editors.emacs;
in
{
  options.myHome.editors.emacs = {
    enable = lib.mkOption {
      description = "Enable the emacs text editor.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      enable = true;
    };
  };
}
