{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.base;
in
{
  options.myConfig.base = {
    enable = lib.mkEnableOption "Enable the foundational packages and settings.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      acpi android-tools
      entr
      git
      helix
      killall
      lm_sensors
      npins
      pciutils
      ncdu
      wget
    ];

    nix = {
      settings = {
        auto-optimise-store = true;
        experimental-features = [ "nix-command" "flakes" ];
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 14d";
      };
    };

    boot.tmp.cleanOnBoot = true;
    boot.loader.systemd-boot.enable = lib.mkDefault true;
    boot.supportedFilesystems = [ "ntfs" ];
    boot.kernelPackages = pkgs.linuxPackages_latest;
    swapDevices = [{device = "/swapfile"; size = 4096; priority= 100;}];
    zramSwap.enable = true;

    time.timeZone = "America/New_York";

    environment = { 
      localBinInPath = true;
      shellAliases = {
        grep = "grep --color=auto";
        ls = "ls -hal --color=auto";
        ncdu = "${pkgs.ncdu}/bin/ncdu --color off";
        q = "exit";
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

    programs.appimage = {
      enable = true;
      binfmt = true;
    };

    boot.binfmt.emulatedSystems = [ "aarch64-linux" "x86_64-windows" ];

    xdg.mime.enable = true;

    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };


    # makes regular shebangs work
    services.envfs.enable = true;

    programs.nix-ld = {
      enable = true;
      # package = pkgs.nix-ld;
      libraries = pkgs.steam-run.args.multiPkgs pkgs;
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
