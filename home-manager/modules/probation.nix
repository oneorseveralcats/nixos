{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.probation;
in
{
  options.myHome.probation = {
    enable = lib.mkOption {
      description = "Enable applications that I intend to remove.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      plugins = with pkgs.vimPlugins; [
        polyglot
        {
          plugin = nvim-colorizer-lua;
          config = ''
            set termguicolors
            lua << END
              require 'colorizer'.setup()
            END
          '';
        }
        {
          plugin = lualine-nvim;
          config = ''
            set noshowmode
            lua << EOF
              local lualine = require('lualine')
              lualine.theme = 'gruvbox'
              lualine.setup()
            EOF
          '';
        }
        {
          plugin = modus-themes-nvim;
          config = ''
            lua << EOF
              vim.cmd([[colorscheme modus]])
            EOF
          '';
        }
        {
          plugin = fzf-vim;
          config = ''
          '';
        }
      ];
      extraConfig = ''
        nmap '<C-l>' '<cmd>noh<CR>'
      
        set shiftwidth=2
        set tabstop=2
        set expandtab

        set linebreak
      
        set ignorecase
        set smartcase
      
        syntax enable

        augroup onFileType
          autocmd!
          au Filetype haskell :bel 10sp | terminal ghci "<afile>"
        augroup END

        let mapleader = " "

        map <leader>.  :Lexplore<CR>

        map <leader>fF :Files 
        map <leader>ff :Files<CR>
        map <leader>fs :w<CR>
        map <leader>ft :bel 10sp \| te<CR>

        map <leader>wf :Windows<CR>
        map <leader>wx :q<CR>
        map <leader>wX :q!<CR>
        map <leader>wh <C-w>h
        map <leader>wt <C-w>j
        map <leader>wn <C-w>k
        map <leader>ws <C-w>l

        map <leader>bf :Buffers<CR>
        map <leader>bh :bp<CR>
        map <leader>bs :bn<CR>

        map <A-x> :

        tnoremap <A-ESC> <C-\><C-N>

        tnoremap <A-h> <C-\><C-N><C-w>h
        tnoremap <A-t> <C-\><C-N><C-w>j
        tnoremap <A-n> <C-\><C-N><C-w>k
        tnoremap <A-s> <C-\><C-N><C-w>l
        inoremap <A-h> <C-\><C-N><C-w>h
        inoremap <A-t> <C-\><C-N><C-w>j
        inoremap <A-n> <C-\><C-N><C-w>k
        inoremap <A-s> <C-\><C-N><C-w>l
        nnoremap <A-h> <C-w>h
        nnoremap <A-t> <C-w>j
        nnoremap <A-n> <C-w>k
        nnoremap <A-s> <C-w>l

        let g:netrw_keepdir = 0
        let g:netrw_winsize = 25
        let g:netrw_banner = 0
        let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
        let g:netrw_localcopydircmd = 'cp -r'
        let g:netrw_liststyle = 3

        augroup netrw_mapping
          autocmd!
          autocmd filetype netrw call NetrwMapping()
        augroup END

        function! NetrwMapping()
          nmap <buffer> H u
          nmap <buffer> h -^
          nmap <buffer> l <CR>
      
          nmap <buffer> . gh
          nmap <buffer> P <C-w>z
      
          nmap <buffer> L <CR>:Lexplore<CR>
          nmap <buffer> <Leader>dd :Lexplore<CR>
        endfunction
      '';
      extraPackages = with pkgs; [
        bat
      ];
    };

    programs.tmux = {
      enable = true;
      tmuxp.enable = true;
      baseIndex = 1;
      clock24 = true;
      keyMode = "vi";
      extraConfig = ''
        bind '|' splitw -h
        bind '_' splitw -v
        unbind '"'
        unbind '%'
        bind C-f resize-pane -Z
        bind 'h' select-pane -L
        bind 't' select-pane -U
        bind 'n' select-pane -D
        bind 's' select-pane -R
        bind 'Tab' choose-tree -Zs
        set  -g status-style bg=black,fg=white
        setw -g window-status-current-style fg=black,bg=white
      '';
    };
    home.file.".config/tmuxp/default.yml" = {
      text = ''
        session_name: default
        windows:
          - panes:
            - shell: "${pkgs.ncmpcpp}/bin/ncmpcpp"
          - panes:
            - newsboat
          - window_name: pulsemixer
            panes:
            - shell: "${pkgs.pulsemixer}/bin/pulsemixer"
          - window_index: 9
            panes:
            - shell_command: 
              - cd ~/projects/programming/rssfeed_hackery
              - while true; do ./run.sh; sleep 1h; done
      '';
    };
  };
}
