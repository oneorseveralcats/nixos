{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.connections.nas;
in
{
  options.myConfig.connections.nas = {
    enable = lib.mkEnableOption "Enable network attached storage.";
  };

  config = mkIf cfg.enable {
    fileSystems."/media/nas" = {
      device = "//192.168.1.10/nas";
      fsType = "cifs";
      options = [ "_netdev" "defaults" "credentials=/etc/secrets/share_nas" "uid=1000" ];
    };
  };
}
