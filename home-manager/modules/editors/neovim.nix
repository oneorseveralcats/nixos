{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.editors.neovim;
  nixvim = import <nixvim>;
in
{
  imports = [
    nixvim.homeManagerModules.nixvim
  ];

  options.myHome.editors.neovim = {
    enable = lib.mkEnableOption "Enable the neovim text editor (nvim).";
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      plugins = {
        lsp = {
          enable = true;
          servers = {
            bashls.enable = true;
            nixd.enable = true;
            hls = {
              enable = true;
              installGhc = false;
            };
          };
        };
        mini = {
          enable = true;
          mockDevIcons = true;
          modules = {
            ai = {};
            align = {};
            completion = {};
            icons = {};
            operators = {};
            pairs = {};
            # snippets = {};
            surround = {};

            pick = {};
          };
        };

        lualine.enable = true;
        nvim-colorizer.enable = true;
        # telescope.enable = true;
      };

      extraPlugins = with pkgs.vimPlugins; [
        # mini-base16 # stylix
      ];
    };

    programs.neovim = {
      enable = false;
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
    };
  };
}
