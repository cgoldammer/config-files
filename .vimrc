set number
execute pathogen#infect()
syntax on
filetype plugin indent on
inoremap jk <ESC>
let mapleader = ","
filetype plugin indent on
syntax on
set encoding=utf-8
let g:slime_target = "tmux"
nnoremap <C-c><C-c> :SlimuxREPLSendLine<CR>
vnoremap <C-c><C-c> :SlimuxREPLSendSelection<CR>
nnoremap <C-c><C-v> :SlimuxREPLConfigure<CR>

set nrformats=

colorscheme ron

set wildmode=longest,list

set history=2000

map <F8> : !gcc % && ./a.out <CR>
