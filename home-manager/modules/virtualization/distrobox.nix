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
          image = "quay.io/toolbx/arch-toolbox:latest";
          additional_packages = [
            "vis"
            "yay"
          ];
          pre_init_hooks =
          let
            chaotic-aur = pkgs.writers.writeBashBin "run.sh" ''
                sudo su
                pacman-key --init
                pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
                pacman-key --lsign-key 3056513887B78AEB
                pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'  
                pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'  

                if ! $(grep -v "\[chaotic-aur\]") "/etc/pacman.conf"; then
                  printf '\n\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist\n' >> /etc/pacman.conf 
                fi
              '';
          in [
            "${chaotic-aur}/bin/run.sh"

            "sudo ln -sf /usr/bin/vis /usr/bin/e"
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

