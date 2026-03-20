{ config, lib, pkgs, ... }:
let 
  inherit (lib)
    mkIf
    mkOption
    types
    ;

  cfg = config.programs.luakit;
in
{
  options.programs.luakit = {
    enable = lib.mkEnableOption "Enable and configure luakit.";

    package = lib.mkPackageOption pkgs "luakit" { nullable = true; };

    finalPackage = mkOption {
      type = types.package;
      readOnly = true;
      description = ''
        Final luakit package bundled with extraPackages.
      '';
    };

    settings = mkOption {
      type = with types; attrsOf (either str int);
    };

    bindings = mkOption {
      
    };

    userStyles = mkOption {
      
    };

    userScripts = mkOption {
      
    };

    filterLists = mkOption {
      
    };

    extraConfigFirst = mkOption {
      
    };

    extraConfig = mkOption {
      
    };
  };

  config = mkIf cfg.enable {
  };
}
