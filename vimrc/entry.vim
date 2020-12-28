"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" the True entry of my vimrc
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Some Global Vars for Plugin installing
let g:vim_home = $HOME
let g:vim_plug_home = vim_home.'/.vim/plugged'

" add some path to runtimepath
exec 'set rtp+='.fnamemodify(resolve(expand('<sfile>:p')), ':h')
exec 'set rtp+=~/.vim'

IncScript basic.vim
IncScript keymap.vim

" Introduce the plugins if vim-plug installed
if filereadable(vim_plug_home.'/../autoload/plug.vim')
    IncScript plugs.vim
endif

" EOF
