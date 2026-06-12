{ config, lib, pkgs, ... }:
let 
  cfg = config.myHome.socials.vesktop;
  systemd.targets = [ "tray.target" ];
  systemd.extraArgs = [ "-m" ];
in
{
  options.myHome.socials.vesktop = {
    enable = lib.mkEnableOption "Enable the vesktop discord client.";
  };

  config = lib.mkIf cfg.enable {
    programs.vesktop = {
      enable = true;
      vencord = {
        # useSystem = true;
        themes = {
          disblock = "https://raw.codeberg.page/AllPurposeMat/Disblock-Origin/DisblockOrigin.theme.css";
        };
      };
    };
    
    systemd.user.services.vesktop-desktop = lib.mkIf true {
      Unit.Description = "vesktop Desktop client";

      Service = {
        ExecStart = "${lib.getExe config.programs.vesktop.package} ${toString systemd.extraArgs}";
        Restart = "on-failure";
      };

      Install.WantedBy = systemd.targets;
    };
  };
}

