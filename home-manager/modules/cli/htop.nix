{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.cli.htop;
in
{
  options.myHome.cli.htop = {
    enable = lib.mkOption {
      description = "Enable the htop task manager.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    programs.htop = {
      enable = true;
      package = pkgs.htop-vim;
      settings = {
        color_scheme = 1;
        show_program_path = false;
        fields = with config.lib.htop.fields; [
          PID
          NICE
          PERCENT_CPU
          PERCENT_MEM
          TIME
          COMM
        ];
        highlight_base_name = 1;
        highlight_megabytes = 1;
        highlight_threads = 1;
        } // (with config.lib.htop; leftMeters [
          (bar "AllCPUs2")
          (bar "MemorySwap")
        ]) // (with config.lib.htop; rightMeters [
          (text "Tasks")
          (text "LoadAverage")
          (text "Uptime")
        ]);
    };
  };
}

