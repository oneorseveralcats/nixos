{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.ai;
in
{
  options.myConfig.ai = {
    enable = mkOption {
      description = "Enable local LLM Support";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      oterm
    ];

    services.ollama = {
      enable = true;
    };
  };
}

