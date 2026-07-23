{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.distrobox;
in
{
  options.myHome.distrobox = {
    enable = lib.mkEnableOption "Enable distrobox and configure containers.";
  };

  config = mkIf cfg.enable {
    myHome.podman.enable = true;

    home.packages = [
      # pkgs.lilipod
    ];

    programs.distrobox = {
      enable = true;
      containers = {
        arch = {
          image = "ghcr.io/ublue-os/arch-toolbox:latest";
          additional_packages = [
            "vis"
          ];
          pre_init_hooks = [
            "ln -sf /usr/bin/vis /usr/bin/e"
          ];
        };
        debian = {
          image = "quay.io/toolbx-images/debian-toolbox:12";
          additional_packages = [
            "foot-terminfo"
            "fzf"
            "grc"
          ];
        };
      };
    };
  };
}

