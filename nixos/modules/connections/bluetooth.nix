{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.connections.bluetooth;
in
{
  options.myConfig.connections.bluetooth = {
    enable = lib.mkOption {
      description = "Enable bluetooth";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bluetuith
    ];

    hardware.bluetooth.enable = true;
    services.blueman.enable = true;

    environment.etc = {
      "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
        bluez_monitor.properties = {
          ["bluez5.enable-sbc-xq"] = true,
          ["bluez5.enable-msbc"] = true,
          ["bluez5.enable-hw-volume"] = true,
          ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
        }
      '';
    };
  };
}

