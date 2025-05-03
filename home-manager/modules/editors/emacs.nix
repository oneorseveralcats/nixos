{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.editors.emacs;
  emacsPkg = pkgs.emacs30-pgtk;
in
{
  options.myHome.editors.emacs = {
    enable = lib.mkEnableOption "Enable the emacs text editor.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      enable = true;
      package = emacsPkg;
      # extraConfig = ''
      #   (setq standard-indent 2)

      #   ; evil
      #   (require 'evil)
      #   (evil-mode 1)
      #   (evil-collection-init)
      # '';
      # extraPackages = epkgs: with epkgs; [
      #   evil evil-collection
      #   magit
      #   which-key
      # ];
    };

    services.emacs = {
      enable = true;
      socketActivation.enable = true;
      package = emacsPkg;
      client = {
        enable = true;
        arguments = [ "-c" ];
      };
    };
  };
}
