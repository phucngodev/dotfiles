if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
  Plug 'ryanoasis/vim-devicons'
  Plug 'preservim/nerdtree'
  Plug 'sainnhe/gruvbox-material'
  Plug 'tpope/vim-commentary'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'girishji/vimcomplete'
  Plug 'yegappan/lsp'
  Plug 'junegunn/vim-easy-align'
  Plug 'charlespascoe/vim-go-syntax'
  Plug 'othree/html5.vim'
  Plug 'pangloss/vim-javascript'
  Plug 'evanleck/vim-svelte', {'branch': 'main'}

call plug#end()


set rtp+=~/.vim/plugged
set history=500
filetype plugin on
filetype indent on
set autoread
set ignorecase
set smartcase
set hlsearch
syntax enable
set encoding=utf8
set ffs=unix,dos,mac
set nobackup
set nowb
set noswapfile
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set number
set ai
set si
set termguicolors
let mapleader = '\\'

let g:go_highlight_parens = 0
let g:go_highlight_fields = 1
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let NERDTreeMinimalUI=1
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['node_modules']

set background=dark
let g:gruvbox_material_background             = 'soft'
let g:gruvbox_material_better_performance     = 1
let g:gruvbox_material_disable_italic_comment = 1
colorscheme gruvbox-material

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-p> :Files<CR>
nnoremap <C-s> :Rg<CR>
nnoremap <Leader>p :Buffers<CR>
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
