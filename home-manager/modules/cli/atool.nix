{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.cli.atool;
  extraPackages = with pkgs; [bzip2 cpio gnutar gzip lhasa lzop p7zip unrar-free unzip xz zip];
  package = pkgs.atool;
in
{
  options.myHome.cli.atool = {
    enable = lib.mkEnableOption "the atool archive tool.";
  };

  config = mkIf cfg.enable {
    home.packages = [
      (pkgs.symlinkJoin {
        name = "atool-wrapped";
        paths = [ package ];
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/atool \
          --suffix PATH : ${lib.makeBinPath extraPackages}
        '';
      })
    ];

    home.file.".atoolrc".source = pkgs.writeText ".atoolrc" (lib.generators.toKeyValue { mkKeyValue = lib.generators.mkKeyValueDefault { } " "; } {
      path_unrar = "unrar-free";
    });

  };
}
