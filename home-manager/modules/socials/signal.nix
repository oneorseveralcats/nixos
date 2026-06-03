{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.socials.signal;
  package = pkgs.signal-desktop;
  systemd.targets = [ "tray.target" ];
  systemd.extraArgs = [ "--start-in-tray" ];
in
{
  options.myHome.socials.signal = {
    enable = lib.mkEnableOption "Enable the signal messaging client.";
  };

  config = mkIf cfg.enable {
    home.packages = lib.mkIf (package != null) [
      package
    ];

    systemd.user.services.signal-desktop = lib.mkIf true {
      Unit.Description = "Signal Desktop client";

      Service = {
        ExecStart = "${lib.getExe package} ${builtins.toString systemd.extraArgs}";
        Restart = "on-failure";
      };

      Install.WantedBy = systemd.targets;
    };
  };
}

