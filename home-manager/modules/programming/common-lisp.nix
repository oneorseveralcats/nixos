{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.common-lisp;
in
{
  options.myHome.programming.languages.common-lisp = {
    enable = lib.mkEnableOption "Enable the common-lisp programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.shellAliases = {
      sbcl = "${pkgs.rlwrap}/bin/rlwrap ${pkgs.sbcl}/bin/sbcl";
    };

    home.packages = with pkgs; [
      sbcl
    ];
  };
}

