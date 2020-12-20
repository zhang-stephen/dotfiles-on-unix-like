""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Basic configurations for vim itself, highlightings, file-editor, display and etc.
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Do not keep compatible with VI
"set nocompatible

" syntax highlight
syntax enable
set background=dark

" show current mode in docker bar
set showmode 

" show command in command mode
set showcmd

" mouse support on
set mouse=a

" file encoding is UTF-8 default and only
set encoding=utf-8
set ambw="double"

" enable 24-bit colour
set termguicolors

" enable filetype check and load related  indent profile
filetype indent on

" auto-indent
set autoindent

" tabsize = 4 space
set tabstop=4
set softtabstop=4

" >> = tab, << = shift tab 
set expandtab

" show line number
set number

" show line number where cursor was in, and show other numbers as relative with cursor line
" set relativenumber

" highlight the cursor line
set cursorline

" width per line 
"set textwidth=80

" auto line wrap, if you want to disable it, use 'set nowtap' 
set wrap

" line wrap with specific symbols, such as space
set linebreak

" width between the right end of the line and right edge of screen 
set wrapmargin=2

" the distance(number of lines) between cursor and the bottom of screen
set scrolloff=15

" statusbar config:
" -> always show status bar
" -> show full path of current file and filetype
" -> show current and all columns
" -> show some flags
" set laststatus=2
" set statusline=%f%m%r%h%w%=\ [%Y]\ 
" set statusline+=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\"+\":\"\").\"]\"}
" set statusline+=\ [%{&ff}]\ [%03.3b/0x%02.2B]\ [%L,\ %l-%v][%p%%]

" show position of cursor(line, column)
" set ruler

" highlight the paired symbols, such as (), [], {}
set showmatch

" highlight the results of searching
set hlsearch

" auto jump to the most matched result in search mode
set incsearch

" enable BackSpace
set bs=2

" popup window color
highlight Pmenu ctermbg=black guibg=black

" ignore the case in search
" set smartcase

" enable spelling check for English
" set spell spelllang=en_us

" flash whole screen if error occured
" set visualbellset paste

" EOF
