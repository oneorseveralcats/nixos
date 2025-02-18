{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.cli.irssi;
in
{
  options.myHome.cli.irssi = {
    enable = lib.mkOption {
      description = "Enable the irssi irc client.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      irssi
    ];
    programs.irssi = {
      enable = true;
      extraConfig = ''
        settings = {
          core = {
            real_name = "Unknown";
            user_name = "oneorseveralcats";
            nick = "oneorseveralcats";
          };
        };
      '';
    };

    home.file.".irssi/scripts/vim_mode.pl".source = builtins.fetchurl "https://github.com/shabble/irssi-scripts/raw/master/vim-mode/vim_mode.pl";
  };
}
