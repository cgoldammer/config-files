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

# Treat all numbers as decimal
set nrformats=

colorscheme ron
# Swanson

set wildmode=longest,list

set history=2000
