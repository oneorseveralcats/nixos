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
      hugo
    ];

    # myHome.editors.neovim.enable = true;

    myHome.shells.nushell.enable = true;
    myHome.browsers.chromium.enable = true;
    myHome.browsers.librewolf.enable = true;
  };
}
