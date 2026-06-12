{ config, lib, pkgs, ... }:
let 
  cfg = config.myHome.socials.tutanota;
  package = pkgs.unstable.tutanota-desktop;
  systemd.targets = [ "tray.target" ];
  systemd.extraArgs = [ "-a" "--password-store=basic" ];
in
{
  options.myHome.socials.tutanota = {
    enable = lib.mkEnableOption "the tutanota email client.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.mkIf (package != null) [
      package
    ];

    systemd.user.services.tutanota-desktop = lib.mkIf true {
      Unit.Description = "Tutanota Desktop client";

      Service = {
        ExecStart = "${lib.getExe package} ${toString systemd.extraArgs}";
        Restart = "on-failure";
      };

      Install.WantedBy = systemd.targets;
    };
  };
}


