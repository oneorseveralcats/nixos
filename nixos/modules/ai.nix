{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.ai;
in
{
  options.myConfig.ai = {
    enable = lib.mkEnableOption "Enable local LLM Support";
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

