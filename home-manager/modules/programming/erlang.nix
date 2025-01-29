{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.erlang;
in
{
  options.myHome.programming.languages.erlang = {
    enable = lib.mkOption {
      description = "Enable the erlang programming language and tools.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      erlang
      erlang-ls
    ];
  };
}





