{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.cli.w3m;
in
{
  options.myHome.cli.w3m = {
    enable = lib.mkOption {
      description = "Enable the w3m terminal web browser.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      libsixel
      w3m
    ];

    home.shellAliases = {
      w3m = "w3m -sixel";
    };

    home.sessionVariables = rec {
      WWW_HOME = "${W3M_DIR}/bookmark.html";
      W3M_DIR = "${config.xdg.configHome}/w3m";
      W3M_IMG2SIXEL = "img2sixel -d atkinson";
    };

    # xdg.configFile."w3m/".text = ''
    # '';
    
  };
}


