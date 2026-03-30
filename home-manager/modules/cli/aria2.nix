{ config, lib, pkgs, ... }:
let 
  cfg = config.myHome.cli.aria2;
in
{
  options.myHome.cli.aria2 = {
    enable = lib.mkEnableOption "the aria2 download manager.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.python3Packages.aria2p
    ];

    programs.aria2 = {
      enable = true;
      settings = let
        aria2Dir = "${config.xdg.configHome}/aria2";
      in{
        dir = "${config.xdg.userDirs.download}";
        enable-rpc = true;
        rpc-listen-all = false;
        save-session = "${aria2Dir}/session.txt";
        save-session-interval = 300;
        # process crashes if input file isn't there.
        input-file = "${aria2Dir}/session.txt";
      };
    };

    systemd.user.services.aria2c = {
      Unit = {
        Description = "Aria2c daemon";
        Documentation = "man:aria2(1)";
        # when upstreamed
        # X-Restart-Triggers = lib.mkIf (cfg.settings != { }) [ "${config.xdg.configFile."aria2/aria2.conf".source}" ];
        X-Restart-Triggers = [ "${config.xdg.configFile."aria2/aria2.conf".source}" ];

      };
      Install.WantedBy = [ "default.target" ];
      Service = {
        # upstream option
        # ExecStart = "${lib.getExe cfg.package} --enable-rpc";
        ExecStart = "${lib.getExe config.programs.aria2.package} --enable-rpc";
        Restart = "on-failure";
      };
    };
  };
}
