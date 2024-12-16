{ config, lib, ...}:
with lib;
let 
  cfg = config.myHome.desktop;
in
{
  imports = [
    ./browsers

    ./base.nix
    ./extras.nix
    ./labwc.nix
    ./river.nix
    ./sway.nix
    ./wlr-extras.nix
  ];

  options.myHome.desktop = {
    enable = lib.mkOption {
      description = "Enable graphical user sessions.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    myHome.desktop.base.enable = lib.mkDefault true;
    myHome.desktop.extras.enable = lib.mkDefault true;

    myHome.desktop.browsers.firefox.enable = lib.mkDefault true;

    myHome.desktop.labwc.enable = lib.mkDefault true;
    myHome.desktop.sway.enable = lib.mkDefault true;
  };
}
