set relativenumber
execute pathogen#infect()
syntax on
set hlsearch
filetype plugin indent on
inoremap jk <ESC>
let mapleader = ","
let maplocalleader = "\\"

filetype plugin indent on
syntax on
set encoding=utf-8
let g:slime_target = "tmux"
nnoremap <C-c><C-c> :SlimuxREPLSendLine<CR>
vnoremap <C-c><C-c> :SlimuxREPLSendSelection<CR>
nnoremap <C-c><C-v> :SlimuxREPLConfigure<CR>
nmap <leader>d <C-c><C-c>j

" Open up the vimrc in split window
noremap <leader>ev :vsplit $MYVIMRC<cr>
" Reload the vimrc file
noremap <leader>sv :source $MYVIMRC<cr>

" Convert word to uppercase in insert mode
inoremap <c-u> <esc>vawgUea

set nrformats=

colorscheme ron

set wildmode=longest,list

set history=2000

map <F8> : !gcc % && ./a.out <CR>

set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Chiel92/vim-autoformat'
Bundle 'christoomey/vim-tmux-navigator'
call vundle#end()            " required
filetype plugin indent on    " required

" Setting taken from Douglas Bernhardt's video
" Open files with <leader>f
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
" Open files, limited to the directory of the current file, with <leader>gf
" This requires the %% mapping found below.
map <leader>gf :CommandTFlush<cr>\|:CommandT %%<cr>

" Edit or view files in the same directory as current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

" Make the current window big, but leave other context
set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=5
set winminheight=5
set winheight=999

" Switch between the last two files
nnoremap <leader><leader> <C-^>

" Disable arrow keys in normal and insert mode
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

autocmd fileType python nnoremap <buffer> <localleader>c 0I# <esc>

augroup filetype_python
	autocmd!
	autocmd FileType python :iabbrev <buffer> fff def():<esc>F(i
	autocmd FileType python :iabbrev <buffer> def USEAUTOUSEAUTO
augroup END

" Fix the autopep8 syntax
let g:formatdef_autopep8 = '"autopep8 - "' 
nnoremap <leader>af :Autoformat<cr>

augroup filetype_markdown
	autocmd!
	onoremap ih :<c-u>execute "normal! ?^\(==\|--\)\\+$\r:nohlsearch\rkvg_"<cr>
augroup END

" Vimscript file settings -- {{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
	noremap <localleader>f za
augroup END
" }}}
