" Various general setup commands {{{
set number
syntax on
set hlsearch incsearch
let mapleader = ","
let maplocalleader = "\\"
filetype plugin indent on " Activate filetype plugins. See :help filetype and :help ftplugin
set history=2000
colorscheme ron
" nrformats sets how <c-a> and <c-x> work. We exclude all options,
" thus not accepting octals and letters.
set nrformats= 
set wildmenu
set wildmode=longest,list

" Stop automatic text wrapping
set tw=0

" Open up the vimrc in split window
noremap <leader>ev :vsplit $MYVIMRC<cr>
" Reload the vimrc file
noremap <leader>sv :source $MYVIMRC<cr>

" Convert word to uppercase in insert mode
inoremap <c-u> <esc>vawgUea

" Automatically running all packages in ~/.vim/bundle
execute pathogen#infect() 

" Run grep with <leader>g
:nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>
" }}}

" Set a timeout of 100ms on commands
set ttimeout
set ttimeoutlen=100

" Number of lines visible above and below the cursor
set scrolloff=2
set sidescrolloff=5

set formatoptions+=j " Delete comment character when joining commented lines

if &history < 1000
    set history=1000
endif
if &tabpagemax < 50
    set tabpagemax=50
endif



" Slimux setup {{{
let g:slime_target = "tmux"
nnoremap <C-c><C-c> :SlimuxREPLSendLine<CR>
vnoremap <C-c><C-c> :SlimuxREPLSendSelection<CR>
nnoremap <C-c><C-v> :SlimuxREPLConfigure<CR>
"Run selection then move to next line
nmap <leader>d <C-c><C-c>j
vmap <leader>d <C-c><C-c><esc>
" }}}

" Installing vundle packages {{{
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Chiel92/vim-autoformat'
Bundle 'christoomey/vim-tmux-navigator'
call vundle#end()            " required
filetype plugin indent on    " required
filetype on
" }}}

" Opening and managing files {{{
" Taken from Douglas Bernhardt's video
" Open files with <leader>f
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
" Open files, limited to the directory of the current file, with <leader>gf
" This requires the %% mapping found below.
map <leader>gf :CommandTFlush<cr>\|:CommandT %%<cr>
" Using the 'find' file scanner instead of Ruby because it's faster
let g:CommandTFileScanner="find"
" Edit or view files in the same directory as current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%
" Switch between the last two files
nnoremap <leader><leader> <C-^>
" }}}

" Automatic resizing of windows {{{
" Make the current window big, but leave other context
set winwidth=130
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=10
set winminheight=10
set winheight=999
" }}}
" Disable arrow keys in normal and insert mode {{{
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
" }}}

nnoremap <leader>af :Autoformat<cr>

" Commands for markdown {{{
augroup filetype_markdown
    autocmd!
    " Operator for preceeding header
    onoremap ih :<c-u>execute "normal! ?^\(==\|--\)\\+$\r:nohlsearch\rkvg_"<cr>
augroup END
" }}}

" Vimscript file settings -- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    noremap <localleader>f za
augroup END
" }}}

set statusline=%20F\ -\ 
set statusline+=FileType:%y\ -\  
set statusline+=Last\ changed:\ %{strftime('%c',getftime(expand('%')))}
set statusline+=%=Line:\ %4l/%L

" Syntastic setup (disabled for now) {{{
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" 
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0
" let g:syntastic_python_checkers = ['flake8']
" 
" let g:syntastic_mode_map = {
"             \ "mode": "passive",
"             \ "active_filetypes": [],
"             \ "passive_filetypes": [] }
" " }}}

" Commands for python {{{
augroup filetype_python
    autocmd!
    autocmd FileType python :iabbrev <buffer> fff def():<esc>F(i
    autocmd FileType python :iabbrev <buffer> def USEAUTOUSEAUTO
    " Fix the autopep8 syntax
    autocmd FileType python let g:formatdef_autopep8 = '"autopep8 - "' 

    " Comment with <localleader>c
    autocmd fileType python nnoremap <buffer> <localleader>c 0I# <esc>

    autocmd FileType python set expandtab           " enter spaces when tab is pressed
    autocmd FileType python set tabstop=4           " use 4 spaces to represent tab
    autocmd FileType python set softtabstop=4
    autocmd FileType python set shiftwidth=4        " number of spaces to use for auto indent
    autocmd FileType python set autoindent          " copy indent from current line when starting a new line

    " Mark lines in red if they exceed the maximum line length
    autocmd FileType python let g:formatdef_custom_python = '"max-line-length 120"'
    autocmd FileType python let g:formatters_python = ['custom_python']
    autocmd FileType python highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    autocmd FileType python match OverLength /\%121v.\+/
augroup END
" }}}


" Commands for yaml {{{

" Vim doesn't auto-detect the yaml format. Thus, setting it manually for 
" any file with a .yml extension
au BufNewFile,BufRead *.yml setlocal ft=yaml
augroup filetype_yaml
    autocmd!
    autocmd FileType yaml set expandtab           " enter spaces when tab is pressed
    autocmd FileType yaml set tabstop=2           " use 2 spaces to represent tab
    autocmd FileType yaml set softtabstop=2
    autocmd FileType yaml set shiftwidth=2        " number of spaces to use for auto indent
    autocmd FileType yaml set autoindent          " copy indent from current line when starting a new line
augroup END
" }}}

" Commands for haskell {{{
augroup filetype_haskell
    autocmd!
    autocmd FileType haskell set expandtab           " enter spaces when tab is pressed
    autocmd FileType haskell set tabstop=4           " use 4 spaces to represent tab
    autocmd FileType haskell set softtabstop=4
    autocmd FileType haskell set shiftwidth=4        " number of spaces to use for auto indent
    autocmd FileType haskell set autoindent          " copy indent from current line when starting a new line
augroup END
" }}}

" Commands for javascript {{{
augroup filetype_javascript
    autocmd!
    autocmd FileType haskell set expandtab           " enter spaces when tab is pressed
    autocmd FileType haskell set tabstop=4           " use 4 spaces to represent tab
    autocmd FileType haskell set softtabstop=4
    autocmd FileType haskell set shiftwidth=4        " number of spaces to use for auto indent
    autocmd FileType haskell set autoindent          " copy indent from current line when starting a new line
augroup END
" }}}

" Open up the vimrc in split window
noremap <leader>ev :vsplit $MYVIMRC<cr>
" Reload the vimrc file
noremap <leader>sv :source $MYVIMRC<cr>

" Loading helper functions

" I keep the vimrc in a git repo. The ~/.vimrc is just a symbolic link to the
" .vimrc in the folder of the git repo. We extract this folder since it
" contains the helper files I am loading later.
let vimrc_folder = substitute(system('dirname $(readlink -f ~/.vimrc)'), "\n", "", "")
let helper_files = ['functional', 'helpers']
for file in helper_files
	:execute "source " . vimrc_folder . '/vim/' . file . '.vim'
endfor

