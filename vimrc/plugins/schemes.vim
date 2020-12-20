""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" schemes configuration entry
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" @brief    load themes
" @params   theme: string
" @retval   None
" @note     None
function! ThemeLoad(theme)
    if filereadable(g:vim_plug_home.a:theme)
        colorscheme a:theme 
    endif
endfunction

let g:airline_theme = 'solarized'
call ThemeLoad('solarized')

"EOF

