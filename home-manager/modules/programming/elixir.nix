{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.elixir;
in
{
  options.myHome.programming.languages.elixir = {
    enable = lib.mkOption {
      description = "Enable the elixir programming language and tools.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      elixir
      elixir-ls
    ];
  };
}




