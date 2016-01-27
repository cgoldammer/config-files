" Adds a double quote (and python spacing) to all elements of a list
" Selects everything inside square brackets, then replaces it 
" by running HandleList over it
function! HandleList(ls)
    let ls_nobracket = substitute(a:ls, "[\\[\\]]", "", "g") 
    let list_nobracket = split(ls_nobracket, ',')
    let list_nobracket_cleaned = Mapped(function("Strip"), list_nobracket)
    let ls_bracket = map(copy(list_nobracket_cleaned), '"\"" . v:val . "\""')
    return '[' . join(ls_bracket, ", ") . ']'
endfunction

" Mapping HandleList to <leader>l ('l' for 'list', in normal mode) and 
" <c-l> (in insert mode), typed after entering the list
nnoremap <leader>l $F[vf]ygvd"=HandleList("<c-r>"")<C-M>p
imap <c-l> <esc><leader>l<esc>a

"a sleep function which allows vim to wait for the other processes to finish
com! -complete=command -nargs=+ Sleep call s:Sleep(<q-args>)
fun! s:Sleep(millisec)
  let ct = localtime()
  let dt = 0
  while dt < (a:millisec/1000)
    let dt = localtime() - ct
  endwhile
endfun

nnoremap <leader>j i']<esc>F.xi['<esc>a
imap <c-}> <esc><leader>j<esc>a
