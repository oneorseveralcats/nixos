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
      extraConfig = ''
        (setq standard-indent 2)

        ; evil
        (require 'evil)
        (evil-mode 1)
        (evil-collection-init)
      '';
      extraPackages = epkgs: with epkgs; [
        evil evil-collection
        magit
        which-key
      ];
    };
  };
}
