{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.sops;
in
{
  imports = [
    <sops-nix/modules/sops>
  ];

  options.myConfig.sops = {
    enable = lib.mkEnableOption "Enable sops-nix password management.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      age 
      sops ssh-to-age      
    ];

    systemd.tmpfiles.settings = {
      "sops-nix" = {
        "/var/lib/sops-nix" = {
          d = {
            group = "root";
            mode = "0700";
            user = "root";
          }; 
        };
      };
    };

    sops.defaultSopsFile = ./secrets/secrets.yaml;
    sops.age.keyFile = "/var/lib/sops-nix/keys.txt";

    # disable sops pulling in openssh hostkeys.
    sops.age.sshKeyPaths = [];
    sops.gnupg.sshKeyPaths = [];
  };
}

