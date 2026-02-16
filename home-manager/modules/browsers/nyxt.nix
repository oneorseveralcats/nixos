{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.browsers.nyxt;
in
{
  options.myHome.browsers.nyxt = {
    enable = lib.mkEnableOption "Enable and configure nyxt.";
  };

  config = mkIf cfg.enable {
    programs.nyxt = {
      enable = true;
      config = /* common-lisp */ ''
        (define-configuration buffer
          ((default-modes
            (pushnew 'nyxt/mode/vi:vi-normal-mode %slot-value%))))
      '';
    };
  };
}

