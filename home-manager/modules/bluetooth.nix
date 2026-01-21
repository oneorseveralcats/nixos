{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.bluetooth;
in
{
  options.myHome.bluetooth = {
    enable = lib.mkEnableOption "Enable bluetooth packages and settings.";
  };

  config = mkIf cfg.enable {
    programs.bluetuith = {
      enable = true;
      package = pkgs.unstable.bluetuith;
      settings = {
        no-warning = true;
        keybindings = {
          NavigateDown = "j";
          NavigateUp = "k";
        };
        receive-dir = "${config.home.homeDirectory}/downloads";
      };
    };

  };
}
