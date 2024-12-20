{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.base;
  # nix-alien-pkgs = import (builtins.fetchTarball "https://github.com/thiagokokada/nix-alien/tarball/master") {};
in
{
  options.myConfig.base = {
    enable = lib.mkOption {
      description = "Enable the foundational packages and settings.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      acpi
      doas-sudo-shim
      entr
      ffmpeg
      git
      helix
      killall
      lm_sensors
      pciutils
      ncdu
      wget

      # nix-alien-pkgs.nix-alien
    ];

    nixpkgs.config.allowUnfree = true;

    environment.pathsToLink = [
      # shell completions
      "/share/bash-completion"
      "/share/fish"
      "/share/zsh"

      # xdg portals
      "/share/xdg-desktop-portal" "/share/applications"
    ];

    boot.supportedFilesystems = [ "ntfs" ];
    boot.kernelPackages = pkgs.linuxPackages_latest;
    swapDevices = [{device = "/swapfile"; size = 4096;}];

    time.timeZone = "America/New_York";

    environment = { 
      localBinInPath = true;
        shellAliases = {
        grep = "grep --color=auto";
        ls = "ls -hal --color=auto";
        ncdu = "${pkgs.ncdu}/bin/ncdu --color off";
        nnn = "${pkgs.nnn}/bin/nnn -C";
        n = "nnn";
        q = "exit";
      };
      variables = {
        EDITOR="${pkgs.helix}/bin/hx";
      };
    };

    programs.bash.promptInit = ''
      RED="\[$(tput setaf 1)\]"
      GREEN="\[$(tput setaf 2)\]"
      BLUE="\[$(tput setaf 4)\]"
      RESET="\[$(tput sgr0)\]"

      if [ -n "$IN_NIX_SHELL" ]; then
        PS1="''${GREEN}\w''${RESET}> "
      else 
        case "$(whoami)" in
             root) PS1="''${RED}\w''${RESET}> ";;
             *) PS1="''${BLUE}\w''${RESET}> ";;
        esac
      fi

      set -o vi
    '';

    # Added in order to suppress "ignoreShellProgramCheck" warnings.
    # ZSH is configured in home-manager and having any of these options
    # on slows it down dramatically. 
    # See: https://github.com/nix-community/home-manager/issues/910
    programs.zsh = {
      enable = true;
      enableCompletion = false;
      enableGlobalCompInit = false;
      enableLsColors = false;
    };

    programs.adb.enable = true;

    programs.appimage = {
      enable = true;
      binfmt = true;
    };

    xdg.mime.enable = true;

    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };

    programs.nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
      libraries = with pkgs; [
        curl
        expat 
        fuse3
        icu
        libgcc
        nss
        openssl
        stdenv.cc.cc
        zlib
      ];
    };
  
    fonts = {
      packages = with pkgs; [
        corefonts
        fira-code-nerdfont
        mno16
        noto-fonts
        noto-fonts-cjk-sans
        spleen
        twemoji-color-font
      ];
      fontDir.enable = true;
      enableDefaultPackages = true;
      fontconfig = {
        defaultFonts = {
          serif = [ "Noto Serif Light" "Noto Serif" ];
          sansSerif = [ "Noto Sans Light" "Noto Sans" ];
          monospace = [ "Fira Code Nerd Font Light" "Fira Code Light" "Noto Sans Mono" ];
          emoji = [ "Twitter Color Emoji" ];
        };
      };
    };

    i18n.defaultLocale = "en_US.UTF-8";
    services.xserver.xkb.layout = "us,us";
    services.xserver.xkb.options = "altwin:prtsc_rwin,caps:swapescape,lv3:ralt_switch_multikey,esperanto:dvorak,grp:shifts_toggle";
    services.xserver.xkb.variant = "dvorak,";
    console = {
      font = "Lat2-Terminus16";
      useXkbConfig = true;
    };

    users = {
      defaultUserShell = pkgs.zsh;
      users.user = {
        isNormalUser = true;
        extraGroups = [ "wheel" "kvm" "libvirtd" "lp" "networkmanager" "plugdev" "scanner" "video" "adbusers" ];
      };
    };

    security = {
      sudo.enable = false;
      doas = {
        enable = true;
        extraRules = [
          { groups = [ "wheel" ]; persist = true; keepEnv = true; }
        ];
      };
    };

    networking = {
      networkmanager.enable = true;
      nameservers = [
        "194.242.2.4" # Mullvad Base
        "194.242.2.3" # Mullvad Adblocking
      ];
      wireless = {
        secretsFile = "/etc/secrets/wifi";
        networks = {
          NETGEAR21.pskRaw = "ext:PSK_HOME";
        };
      };
    };

    fileSystems."/media/removable" = {
      device = "//192.168.1.10/removable";
      fsType = "cifs";
      options = [ "_netdev" "defaults" "credentials=/etc/secrets/share_removable" "uid=1000" ];
    };

    networking.firewall.enable = true;

    nix = {
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 2w";
      };
      settings.auto-optimise-store = true;
    };

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      wireplumber.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    services.fwupd.enable = true;

    # minidisc player and maybe other things?
    services.udev.extraRules = ''
      SUBSYSTEM=="usb", ATTR{idVendor}=="054c", ATTR{idProduct}=="00ca", MODE:="0666"

      KERNEL=="uinput", MODE="0666"
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="05c4", MODE="0666"
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", KERNELS=="0005:054C:05C4.*", MODE="0666"
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="09cc", MODE="0666"
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", KERNELS=="0005:054C:09CC.*", MODE="0666"
    '';
  };
}
