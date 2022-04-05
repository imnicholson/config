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
  " common configs for language server client => https://github.com/neovim/nvim-lspconfig
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer', { 'branch': 'main' }

  " language highlighter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " themes
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'mhartington/oceanic-next'
  Plug 'EdenEast/nightfox.nvim'

  " telescope file traversal => https://github.com/nvim-telescope/telescope.nvim
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'kyazdani42/nvim-web-devicons'

  " editorconfig
  Plug 'editorconfig/editorconfig-vim'

  " ale autoformat => https://github.com/dense-analysis/ale 
  Plug 'dense-analysis/ale'

  "status line => https://github.com/nvim-lualine/lualine.nvim
  Plug 'nvim-lualine/lualine.nvim'
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
colorscheme nightfox
" colorscheme PaperColor
" colorscheme OceanicNext

" Move lines up and down with Alt-j and Alt
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fr <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <Leader>fg <cmd>lua require'telescope.builtin'.git_files{}<cr>
nnoremap <Leader>' <cmd>lua require'telescope.builtin'.marks{}<cr>
nnoremap <Leader>cs <cmd>lua require'telescope.builtin'.colorscheme{}<cr>

" ALE config
let b:ale_fixers = ['prettier', 'eslint']
let g:ale_fix_on_save = 1
" END ALE config

lua <<EOF
require("lsp")
require("treesitter")
EOF

lua <<EOF
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
require('lualine').setup()
EOF

