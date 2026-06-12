{ config, lib, pkgs, ... }:
let 
  inherit (lib)
    mkIf
    optionalAttrs
    ;
  cfg = config.myHome.desktop.autostart;
in
{
  options.myHome.desktop.autostart = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = cfg.wlr.enable;
      description = "and configure applications that should be autostarted on all graphical environments.";
    };
    wlr.enable = lib.mkEnableOption "and configure applications that should be autostarted on wlr compositors.";
  };

  config = let
    wantedBy = "tray.target";
    mkService = {
      command,
    }:{
      Install.WantedBy = [ wantedBy ];
      Service = {
        # ExecStartPre = "${pkgs.toybox}/bin/sleep 2s";
        ExecStart = "${command}";
      };
      Unit = {
        # After = [ "waybar.service" ];
        Description = "Autostart: ${builtins.baseNameOf command}";
        # prevents home-manager from restarting these services
        # X-SwitchMethod = "keep-old";
      };
    };
  in lib.mkMerge [
    (mkIf cfg.enable {
      services.blueman-applet.enable = true;
      services.pasystray.enable = true;

      systemd.user.services = {
        keepassxc = mkService { command = "${pkgs.keepassxc}/bin/keepassxc --minimized"; };
        zellij-default = mkService {
          command = "${pkgs.zellij}/bin/zellij --layout startup attach -b --create zellij-default";
        };
      }
        // optionalAttrs config.myHome.vpn.mullvad.enable
          { mullvad-vpn = mkService { command = "${pkgs.mullvad-vpn}/bin/mullvad-vpn"; }; }
        // optionalAttrs config.myHome.socials.thunderbird.enable
          { thunderbird = mkService { command = "${pkgs.thunderbird}/bin/thunderbird"; }; }
        // optionalAttrs config.myHome.socials.telegram.enable
          { telegram-desktop = mkService { command = "${pkgs.telegram-desktop}/bin/Telegram -startintray"; }; }
       ;
    })
    (mkIf cfg.wlr.enable {
      services.lxqt-policykit-agent.enable = true;

      systemd.user.services = {
        gammastep = mkService { command = "${pkgs.gammastep}/bin/gammastep -P -O 4000"; };
      }
        // optionalAttrs config.myHome.desktop.others.swayidle.enable
          { sway-audio-idle-inhibit = mkService { command = "${pkgs.sway-audio-idle-inhibit}/bin/sway-audio-idle-inhibit"; }; }
        ;
    }) 
  ];
}
