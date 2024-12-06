{ config, lib, ...}:
with lib;
let 
  cfg = config.myHome.desktop;
in
{
  imports = [
    ./base.nix
    ./extras.nix
    ./firefox.nix
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
    myHome.desktop.base.enable = true;
    myHome.desktop.extras.enable = true;
    myHome.desktop.firefox.enable = true;
    myHome.desktop.labwc.enable = true;
    myHome.desktop.sway.enable = true;
  };
}
