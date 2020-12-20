""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" asyncrun configuration
" URL: https://github.com/skywind3000/asyncrun.vim
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" open quickfix window automatically，hight = 6
let g:asyncrun_open = 6

" disable bell while task cplt
let g:asyncrun_bell = 0

" F10 to toggle quickfix windows
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

" EOF
