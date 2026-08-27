{
  description = "NixOS and Home-Manager config";

  inputs = {
    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix-master = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager?ref=release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin?ref=nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "https://github.com/gmodena/nix-flatpak/archive/refs/tags/latest.tar.gz";

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };

    nixos-hardware = {
      url = "github:nixos/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nixpkgs.url = "github:nixos/nixpkgs?ref=26.05";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix?ref=release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    overlay-unstable = final: prev: {
      unstable = import inputs.nixpkgs-unstable {
         inherit (final) config;
         inherit (final.stdenv.hostPlatform) system;
      };
    };

    nixPkgs = { system ? "x86_64-linux"}: import nixpkgs {
      inherit system;
      config.allowUnfreePackages = [
        "brscan5" "brscan5-etc-files"
        "corefonts"
        "libretro-genesis-plus-gx"
        "steam" "steam-unwrapped"
        "terraria-server"
        "video-downloadhelper"
      ];
      overlays = [
        overlay-unstable
      ];
    };
  in {
    nixosConfigurations = let
      mkNixOSConfig = {modules ? [], system ? "x86_64-linux"} : nixpkgs.lib.nixosSystem {
        modules = modules ++ [ inputs.nur.modules.nixos.default ];
        pkgs = nixPkgs { system = system; };
        specialArgs = { inherit inputs; };
      };
    in {
      air = mkNixOSConfig { modules = [ ./nixos/devices/air.nix ]; };
      desktop = mkNixOSConfig { modules = [ ./nixos/devices/desktop.nix ]; };
      primary = mkNixOSConfig { modules = [ ./nixos/devices/primary.nix ]; };
      rock64 = mkNixOSConfig { modules = [ ./nixos/devices/rock64.nix ]; };
      server = mkNixOSConfig { modules = [ ./nixos/devices/server.nix ]; };
      wsl = mkNixOSConfig { modules = [ ./nixos/devices/wsl.nix ]; };
    };

    homeConfigurations = let
      mkHome = { modules ? [], system ? "x86_64-linux" } : home-manager.lib.homeManagerConfiguration {
        modules = modules ++ [ inputs.nur.modules.homeManager.default ];
        pkgs = nixPkgs { system = system; };
        extraSpecialArgs = { inherit inputs; };
      };
    in {
      "user@air" = mkHome { modules = [ ./home-manager/devices/air.nix ]; };
      "user@desktop" = mkHome { modules = [ ./home-manager/devices/desktop.nix ]; };
      "user@primary" = mkHome { modules = [ ./home-manager/devices/primary.nix ]; };
      "user@rock64" = mkHome { system = "aarch64-linux"; modules = [ ./home-manager/devices/rock64.nix ]; };
      "user@server" = mkHome { modules = [ ./home-manager/devices/server.nix ]; };
      "user@wsl" = mkHome { modules = [ ./home-manager/devices/wsl.nix ]; };
    };

    nixOnDroidConfigurations.default = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
      modules = [ ./nixpkgs/nix-on-droid.nix ];
      pkgs = nixPkgs { system = "aarch64-linux"; };
      extraSpecialArgs = { inherit inputs; };
    };
  };
}
