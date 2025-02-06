{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.coq;
in
{
  options.myHome.programming.languages.coq = {
    enable = lib.mkOption {
      description = "Enable the coq interactive theorem prover.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      coq
    ];
  };
}



