""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" the useful vim commands, no relative with plugins
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" @func     to delete trailing spaces
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ShowSpaces(...)
    let @/ = '\v(\s+$)|( +\ze\t )'
    let oldhlsearch = &hlsearch
    if !a:0
        let &hlsearch = !&hlsearch
    else
        let &hlsearch = a:1
    endif

    return oldhlsearch
endfunction

function! TrimSpaces() range
    let oldhlsearch = ShowSpaces(1)


