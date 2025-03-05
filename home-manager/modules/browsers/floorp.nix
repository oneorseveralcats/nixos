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
      profiles = rec {
        "personal" = firefox.profiles.personal // {
          search.default = firefox.profiles.personal.search.default;
        };
        "school" = firefox.profiles.school // {
          search.default = personal.search.default;
        };
        "offline" = firefox.profiles.offline // {
          search.default = personal.search.default;
        };
      };
    };
  };
}


