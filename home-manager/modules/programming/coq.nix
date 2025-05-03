{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.coq;
in
{
  options.myHome.programming.languages.coq = {
    enable = lib.mkEnableOption "Enable the coq interactive theorem prover.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      coq
    ];
  };
}



