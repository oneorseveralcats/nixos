{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.testing;
in
{
  options.myConfig.testing = {
    enable = lib.mkEnableOption "Enable packages and modules that i am testing.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
    ];
  };
}

