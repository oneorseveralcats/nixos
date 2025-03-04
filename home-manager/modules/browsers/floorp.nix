{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.browsers.floorp;
  nur = import <nur> {};
in
{
  options.myHome.browsers.floorp = {
    enable = lib.mkEnableOption "Enable and configure floorp.";
  };

  config = mkIf cfg.enable {
    programs.floorp = with config.programs; {
      enable = true;
      package = pkgs.floorp.override {
        nativeMessagingHosts = firefox.nativeMessagingHosts;
      };
      profiles = firefox.profiles;
    };
  };
}


