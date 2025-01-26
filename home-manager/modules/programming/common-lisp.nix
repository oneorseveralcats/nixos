{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.common-lisp;
in
{
  options.myHome.programming.languages.common-lisp = {
    enable = lib.mkOption {
      description = "Enable the common-lisp programming language and tools.";
      type = types.bool;
      default = false;
    };
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

