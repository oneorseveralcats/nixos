{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.media.rmpc;
in
{
  options.myHome.media.rmpc = {
    enable = lib.mkEnableOption "Enable and configure the rmpc mpd client.";
  };

  config = mkIf cfg.enable {
    programs.rmpc = {
      enable = true;
      config = /* ron */ ''
        #![enable(implicit_some)]
        #![enable(unwrap_newtypes)]
        #![enable(unwrap_variant_newtypes)]
        (
          theme: "home-manager",
          keybinds: (
            global: {
              "1": SwitchToTab("artist"),
              "2": SwitchToTab("queue"),
              "3": SwitchToTab("dir"),
              "4": SwitchToTab("search"),
              "5": SwitchToTab("playlist"),

              "9": VolumeDown,
              "0": VolumeUp,

                // Default values that aren't overrided
              ":":       CommandMode,
              ",":       VolumeDown,
              "s":       Stop,
              ".":       VolumeUp,
              "<Tab>":   NextTab,
              "<S-Tab>": PreviousTab,
              "q":       Quit,
              ">":       NextTrack,
              "p":       TogglePause,
              "<":       PreviousTrack,
              "f":       SeekForward,
              "z":       ToggleRepeat,
              "x":       ToggleRandom,
              "c":       ToggleConsume,
              "v":       ToggleSingle,
              "b":       SeekBack,
              "~":       ShowHelp,
              "u":       Update,
              "U":       Rescan,
              "I":       ShowCurrentSongInfo,
              "O":       ShowOutputs,
              "P":       ShowDecoders,
              "R":       AddRandom,
            },
            navigation: {
              // Default values
              "k":         Up,
              "j":         Down,
              "h":         Left,
              "l":         Right,
              "<Up>":      Up,
              "<Down>":    Down,
              "<Left>":    Left,
              "<Right>":   Right,
              "<C-k>":     PaneUp,
              "<C-j>":     PaneDown,
              "<C-h>":     PaneLeft,
              "<C-l>":     PaneRight,
              "<C-u>":     UpHalf,
              "N":         PreviousResult,
              "a":         Add,
              "A":         AddAll,
              "r":         Rename,
              "n":         NextResult,
              "g":         Top,
              "<Space>":   Select,
              "<C-Space>": InvertSelection,
              "G":         Bottom,
              "<CR>":      Confirm,
              "i":         FocusInput,
              "J":         MoveDown,
              "<C-d>":     DownHalf,
              "/":         EnterSearch,
              "<C-c>":     Close,
              "<Esc>":     Close,
              "K":         MoveUp,
              "D":         Delete,
              "B":         ShowInfo,
              "<C-z>":     ContextMenu(),
              "<C-s>":     Save(kind: Modal(all: false, duplicates_strategy: Ask)),
            },
            queue: {
              // default values
              "D":       DeleteAll,
              "<CR>":    Play,
              "a":       AddToPlaylist,
              "d":       Delete,
              "C":       JumpToCurrent,
              "X":       Shuffle,
            },
          ),
          tabs: [
            (
                name: "artist",
                pane: Pane(AlbumArtists),
            ),
            (
                name: "queue",
                pane: Pane(Queue)
            ),
            (
                name: "dir",
                pane: Pane(Directories),
            ),
            (
                name: "search",
                pane: Pane(Search),
            ),
            (
                name: "playlist",
                pane: Pane(Playlists),
            ),
          ],
        )
      '';
    };

    xdg.configFile."rmpc/themes/home-manager.ron".enable = false;
    xdg.configFile."rmpc/themes/home-manager.ron".text = /* ron */ ''
    '';
  };
}

