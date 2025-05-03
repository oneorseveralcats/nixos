{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.cli.presenterm;
in
{
  options.myHome.cli.presenterm = {
    enable = lib.mkEnableOption "Enable the presenterm presentation software.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      presenterm typst
    ];

    home.file.".config/presenterm/config.yaml".text = ''
      defaults:
        theme: tokyonight-storm

      typst:
        ppi: 300

      options:
        implicit_slide_ends: true
        incremental_lists: true
        strict_front_matter_parsing: false
        end_slide_shorthand: true
    '';
  };
}

