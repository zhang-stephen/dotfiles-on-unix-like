"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" vim-plug configurations
" URL: https://github.com/ycm-core/YouCompleteMe
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" not load extra configuration file
let g:ycm_confirm_extra_conf = 0

" GOTO definition
autocmd Filetype python,c,cpp,Java,vim nnoremap <leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_key_invoke_completion = '<c-z>'
let g:ycm_min_num_of_chars_for_completion=2
let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }

set completeopt=menu,menuone

" enable completer in strings and comments
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 0

let g:ycm_add_preview_to_completeopt = 0
let g:ycm_python_binary_path = 'python3'
let g:ycm_register_as_syntastic_checker = 0
let g:ycm_max_num_candidates = 30
let g:ycm_show_diagnostics_ui = 0
let g:ycm_filetype_whitelist = {
			\ "c":1,
			\ "cpp":1,
			" \ "objc":1,
			\ "python": 1,
			\ "Java": 1,
			\ "sh":1,
			\ "zsh":1,
			\ "zimbu":1,
			\ "vim":1,
			\ }
" EOF
