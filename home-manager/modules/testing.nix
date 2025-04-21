{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.testing;
in
{
  options.myHome.testing = {
    enable = lib.mkOption {
      description = "Enable packages and settings that are currently being tested.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
    ];

    myHome.editors.neovim.enable = true;

    myHome.programming.languages.prolog.enable = true;
  };
}
