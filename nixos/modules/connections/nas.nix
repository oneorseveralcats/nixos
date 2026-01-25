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
    myConfig.sops.enable = true;
    sops.secrets."cifs/nas/username" = {};
    sops.secrets."cifs/nas/password" = {};

    sops.templates."nas-credentials".content = ''
      username=${config.sops.placeholder."cifs/nas/username"}
      password=${config.sops.placeholder."cifs/nas/password"}
    '';

    fileSystems."/media/nas" = {
      device = "//192.168.1.10/nas";
      fsType = "cifs";
      options = [ "_netdev" "defaults" "credentials=${config.sops.templates."nas-credentials".path}" "uid=1000" ];
    };
  };
}
