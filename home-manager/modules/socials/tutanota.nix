{ config, lib, pkgs, ... }:
with lib;
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

  config = mkIf cfg.enable {
    home.packages = lib.mkIf (package != null) [
      package
    ];

    systemd.user.services.tutanota-desktop = lib.mkIf true {
      Unit = {
        Description = "Tutanota Desktop client";
        PartOf = systemd.targets;
        After = systemd.targets;
      };

      Service = {
        ExecStart = "${lib.getExe package} ${builtins.toString systemd.extraArgs}";
        Restart = "on-failure";
      };

      Install.WantedBy = systemd.targets;
    };
  };
}


