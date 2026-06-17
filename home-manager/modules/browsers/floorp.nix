{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.browsers.floorp;
in
{
  options.myHome.browsers.floorp = {
    enable = lib.mkEnableOption "Enable and configure floorp.";
  };

  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfreePackages = [
      "video-downloadhelper"
    ];

    programs.floorp = with config.programs; {
      enable = true;
      package = pkgs.floorp.override {
        nativeMessagingHosts = firefox.nativeMessagingHosts;
      };
      profiles = rec {
        "personal" = firefox.profiles.personal // {
          search = {
            force = true;
            default = firefox.profiles.personal.search.default;
          };
        };
        "school" = firefox.profiles.school // {
          search = personal.search;
        };
        "offline" = firefox.profiles.offline // {
          search = personal.search;
        };
      };
    };
  };
}


