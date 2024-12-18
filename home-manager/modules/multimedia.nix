{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.multimedia;
in
{
  options.myHome.multimedia = {
    enable = lib.mkOption {
      description = "Enable multimedia packages.";
      type = types.bool;
      default = true;
    };
    extras.enable = lib.mkOption {
      description = "Enable packages for creating/modifying multimedia files.";
      type = types.bool;
      default = true;
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      home.packages = with pkgs; [
      ];

      services.playerctld.enable = true;
      services.mpd-mpris.enable = true;
      services.mpd = {
        enable = true;
        musicDirectory = "~/audio/music";
        extraConfig = ''
          audio_output {
            type            "pulse"
            name            "pulse"
          }
          # mpd volume changes when other inputs change it
          # see: https://github.com/MusicPlayerDaemon/MPD/issues/1588
          # audio_output {
          #   type            "pipewire"
          #   name            "PipeWire Sound Server"
          # }
        '';
      };
      programs.ncmpcpp = {
        enable = true;
        bindings = [
          { key = "j"; command = "scroll_down"; }
          { key = "k"; command = "scroll_up"; }
          { key = "J"; command = [ "select_item" "scroll_down" ]; }
          { key = "K"; command = [ "select_item" "scroll_up" ]; }
          { key = "ctrl-j"; command = [ "page_down" ]; }
          { key = "ctrl-k"; command = [ "page_up" ]; }
          { key = "alt-j"; command = [ "move_sort_order_down" ]; }
          { key = "alt-j"; command = [ "move_selected_items_down" ]; }
          { key = "alt-k"; command = [ "move_sort_order_up" ]; }
          { key = "alt-k"; command = [ "move_selected_items_up" ]; }
          { key = "h"; command = [ "previous_column" ]; }
          { key = "h"; command = [ "master_screen" ]; }
          { key = "h"; command = [ "jump_to_parent_directory" ]; }
          { key = "l"; command = [ "next_column" ]; }
          { key = "l"; command = [ "slave_screen" ]; }
          { key = "l"; command = [ "enter_directory" ]; }
          { key = "l"; command = [ "toggle_output" ]; }
          { key = "l"; command = [ "run_action" ]; }
          { key = "L"; command = [ "play_item" ]; }
          { key = "ctrl-l"; command = [ "seek_forward" ]; }
          { key = "ctrl-h"; command = [ "seek_backward" ]; }
          { key = "d"; command = [ "delete_playlist_items" ]; }
          { key = "d"; command = [ "delete_browser_items" ]; }
          { key = "d"; command = [ "delete_stored_playlist" ]; }
          { key = "g"; command = [ "move_home" ]; }
          { key = "G"; command = [ "move_end" ]; }
          { key = "n"; command = [ "next_found_item" ]; }
          { key = "N"; command = [ "previous_found_item" ]; }
          { key = "1"; command = [ "show_media_library" ]; }
          { key = "1"; command = [ "toggle_media_library_columns_mode" ]; }
          { key = "2"; command = [ "show_playlist" ]; }
          { key = "3"; command = [ "show_browser" ]; }
          { key = "3"; command = [ "change_browse_mode" ]; }
          { key = "4"; command = [ "show_search_engine" ]; }
          { key = "4"; command = [ "reset_search_engine" ]; }
          { key = "5"; command = [ "show_playlist_editor" ]; }
          { key = "6"; command = [ "show_tag_editor" ]; }
          { key = "7"; command = [ "show_outputs" ]; }
          { key = "9"; command = [ "volume_down" ]; }
          { key = "0"; command = [ "volume_up" ]; }
        ];
        settings = {
          current_item_prefix = "$5$r";
          current_item_suffix = "$/r$9";
          selected_item_prefix = "$5";
          selected_item_suffix = "$9";
          song_columns_list_format = "(30)[white]{a} (40)[white]{t|f:Title} (20)[white]{b} (7f)[white]{l}";
          playlist_display_mode = "columns";
          browser_display_mode = "classic";
          search_engine_display_mode = "columns";
          playlist_editor_display_mode = "columns";
          media_library_albums_split_by_date = "no";
          startup_screen = "media_library";
          ignore_diacritics = "yes";
          mouse_support = "no";
          external_editor = "nvim";
          use_console_editor = "yes";
          colors_enabled = "yes";
          empty_tag_color = "white";
          header_window_color = "white";
          volume_color = "white";
          state_line_color = "white";
          state_flags_color = "white:b";
          main_window_color = "white";
          color1 = "white";
          color2 = "white";
          progressbar_color = "black:b";
          progressbar_elapsed_color = "blue:b";
          statusbar_color = "default";
          statusbar_time_color = "default:b";
          player_state_color = "default:b";
          window_border_color = "white";
          active_window_border = "blue";
          alternative_ui_separator_color = "black:b";
        };
      };

      programs.newsboat = {
        enable = true;
        autoReload = true;
        browser = ''"mpvc -q -a"'';
        extraConfig = ''
          bind-key j next
          bind-key k prev
          bind-key J next-feed
          bind-key K prev-feed

          macro y set browser "echo -n %u | wl-copy" ; open-in-browser ; set browser ${config.programs.newsboat.browser}

          #     #element           #fg    #bg    #attr
          color listfocus          black  white
          color listfocus_unread   black  white  bold
          color info               black  white  bold
          color end-of-text-marker black  black  invis
        '';
        queries = {
          #foo = ''author =~ "BadEmpanada"'';
        };
        urls = [
          { tags = [ "~Youtube" ]; url = "file:///home/user/sync/default/youtube.rss"; }
          # { tags = [ "~Podcasts" ]; url = "file:///media/storage/projects/programming/rssfeed_hackery/podcasts.rss"; }
          { tags = [ "~StandardEbooks Releases" ]; url = "https://standardebooks.org/rss/new-releases"; }
        ];
      };
    })

    (mkIf cfg.extras.enable {
      home.packages = with pkgs; [
        audacity
        easytag
        libjpeg libwebp
        mediainfo
        nicotine-plus 
        vorbis-tools
      ];
    })
  ];
}
