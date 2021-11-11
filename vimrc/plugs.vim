"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" vim-plug configurations
" URL: https://github.com/junegunn/vim-plug
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin(vim_home.'/.vim/plugged')

" @plugin   NERDTree
" @config   ./plugins/nerdtree.vim
Plug 'scrooloose/nerdtree'
IncScript plugins/nerdtree.vim

" @plugins 	Nerd Commenter
" @config   ./plugins/nerdcomment.vim
Plug 'scrooloose/nerdcommenter'
IncScript plugins/nerdcomment.vim

" @plugin	ctags and its assistantive tools
" @config 	./plugins/ctags.vim
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
Plug 'universal-ctags/ctags' " { 'frozen': v:true }
IncScript plugins/ctags.vim

" @plugin   Async Run powered by https://github.com/skywind3000
" @config   ./plugins/asyncrun.vim
Plug 'skywind3000/asyncrun.vim'
IncScript plugins/asyncrun.vim

" @plugin   surround.vim
" @config   None
Plug 'tpope/vim-surround'

" @plugin 	fugitive -- git wrapper
" @config 	None
Plug 'tpope/vim-fugitive'

" @plugin   airline
" @config   airline.vim
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
IncScript plugins/airline.vim

" @plugin 	c/cpp highlight based on semantic analyzer
" @config 	None
Plug 'jackguo380/vim-lsp-cxx-highlight'

" @plugin   auto-pairs
" @config   autopairs.vim
Plug 'jiangmiao/auto-pairs'

" @plugin   altercation/vim-colors-solarized
" @config   None
Plug 'altercation/vim-colors-solarized'
IncScript plugins/schemes.vim

" @plugin 	tmux-plugins/vim-tmux-focus-events to restore focus-event in tmux
" @config 	None
Plug 'tmux-plugins/vim-tmux-focus-events'

" @plugin 	rainbow parentheses
" @config 	rainbowps.vim
Plug 'kien/rainbow_parentheses.vim'
IncScript plugins/rainbowps.vim

" @plugin 	coc.nvim
" @config 	cocv.vim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
IncScript plugins/cocv.vim

" @plugin   fzf and its wrapper
" @config   None for now
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" @plugin   python-syntax
" @config   pyntax.vim
Plug 'vim-python/python-syntax'
IncScript plugins/pyntax.vim

" @plugin   vim-startify
" @config   None
Plug 'mhinz/vim-startify'
IncScript plugins/startify.vim

" @plugin   vim-terminal-help
" @config   terminal.vim
Plug 'skywind3000/vim-terminal-help'
IncScript plugins/terminal.vim

" @plugin   indentline
Plug 'yggdroot/indentline'

" @plugin   rainbow_csv
Plug 'mechatroner/rainbow_csv'

" Plug 'mattesgroeger/vim-bookmarks'
" Plug 'itchyny/lightline.vim'

call plug#end()

" EOF
