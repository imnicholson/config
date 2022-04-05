" hello front end masters
set path+=**

" Nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu

" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*


" auto install vim-plug and plugins:
let plug_install = 0
let autoload_plug_path = stdpath('config') . '/autoload/plug.vim'
if !filereadable(autoload_plug_path)
    execute '!curl -fL --create-dirs -o ' . autoload_plug_path .
        \ ' https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    execute 'source ' . fnameescape(autoload_plug_path)
    let plug_install = 1
endif
unlet autoload_plug_path

" plug install
call plug#begin(stdpath('config') . '/plugged')

  " common configs for language server client https://github.com/neovim/nvim-lspconfig
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer', { 'branch': 'main' }

  " language highlighter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " Themes
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'mhartington/oceanic-next'

call plug#end()
call plug#helptags()

" auto install vim-plug and plugins:
if plug_install
    PlugInstall --sync
endif
unlet plug_install

" set leader key to ,
let g:mapleader=","

" general settings
set hidden
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set ruler
set number
set relativenumber

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
set updatetime=300

" Theme Selection 
set colorcolumn=160
colorscheme PaperColor
" colorscheme OceanicNext

" Move lines up and down with Alt-j and Alt
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

lua <<EOF
require("lsp")
require("treesitter")
EOF
