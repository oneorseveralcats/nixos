{ config, lib, ...}:
with lib;
let 
  cfg = config.myHome.desktop;
in
{
  imports = [
    ./browsers
    ./terminals
    ./compositors

    ./base.nix
    ./extras.nix
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

    myHome.desktop.terminals.foot.enable = lib.mkDefault true;

    myHome.desktop.compositors.labwc.enable = lib.mkDefault true;
    myHome.desktop.compositors.sway.enable = lib.mkDefault true;
  };
}
