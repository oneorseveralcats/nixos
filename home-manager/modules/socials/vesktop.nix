{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.socials.vesktop;
  systemd.targets = [ "tray.target" ];
  systemd.extraArgs = [ "--start-in-tray" ];
in
{
  options.myHome.socials.vesktop = {
    enable = lib.mkEnableOption "Enable the vesktop discord client.";
  };

  config = mkIf cfg.enable {
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
      Unit = {
        Description = "vesktop Desktop client";
        # PartOf = systemd.targets;
        # After = systemd.targets;
      };

      Service = {
        ExecStart = "${lib.getExe package} ${builtins.toString systemd.extraArgs}";
        Restart = "on-failure";
      };

      Install.WantedBy = systemd.targets;
    };
  };
}

