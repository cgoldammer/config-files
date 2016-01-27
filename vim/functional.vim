function! Sorted(l)
    let new_list = deepcopy(a:l)
    call sort(new_list)
    return new_list
endfunction

function! Reversed(l)
    let new_list = deepcopy(a:l)
    call reverse(new_list)
    return new_list
endfunction

function! Append(l, val)
    let new_list = deepcopy(a:l)
    call add(new_list, a:val)
    return new_list
endfunction

function! Modify(l, i, val)
    let new_list = deepcopy(a:l)
    let new_list[a:i] = a:val
    return new_list
endfunction

function! Pop(l, i)
    let new_list = deepcopy(a:l)
    call remove(new_list, a:i)
    return new_list
endfunction

function! Mapped(fn, l)
    let new_list = deepcopy(a:l)
    call map(new_list, string(a:fn) . '(v:val)')
    return new_list
endfunction

function! Filtered(fn, l)
    let new_list = deepcopy(a:l)
    call filter(new_list, string(a:fn) . '(v:val)')
    return new_list
endfunction

function! Removed(fn, l)
    let new_list = deepcopy(a:l)
    call filter(new_list, '!' . string(a:fn) . '(v:val)')
    return new_list
endfunction

function! Strip(input_string)
    return substitute(a:input_string, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

" Adds a double quote (and python spacing) to all elements of a list
" Selects everything inside square brackets, then replaces it 
" by running HandleList over it
nnoremap <leader>w $F[vf]ygvd"=HandleList("<c-r>"")<C-M>p

function! HandleList(ls)
    let ls_nobracket = substitute(a:ls, "[\\[\\]]", "", "g") 
    let list_nobracket = split(ls_nobracket, ',')
    let list_nobracket_cleaned = Mapped(function("Strip"), list_nobracket)
    let ls_bracket = map(copy(list_nobracket_cleaned), '"\"" . v:val . "\""')
    return '[' . join(ls_bracket, ", ") . ']'
endfunction


