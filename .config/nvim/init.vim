" Bootstrap Plug
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs 
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

" Specify a directory for plugins
call plug#begin(stdpath('data') . '/plugged')

"---------------------------------------
" Declare the list of plugins
"---------------------------------------
" ui
Plug 'kaicataldo/material.vim', { 'branch': 'main' }

" navigation
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'

" editing
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-commentary'

" syntax
Plug 'sheerun/vim-polyglot'

" LSP

" snippets

" version control
Plug 'tpope/vim-fugitive'

" misc
Plug 'meain/vim-package-info', { 'do': 'npm install' }

" Initialize plugin system
call plug#end()


"---------------------------------------
" Configure colorscheme
"---------------------------------------
if (has("termguicolors"))
  set termguicolors
endif

let g:material_theme_style = 'default'
let g:material_terminal_italics = 1

syntax enable
colorscheme material

"---------------------------------------
" Configure indentation
"---------------------------------------


"---------------------------------------
" Configure key mappings
"---------------------------------------


"---------------------------------------
" Configure misc
"---------------------------------------
" Enable hybrid line numbers
set number
set relativenumber


"---------------------------------------
" Configure python provider
"---------------------------------------
let g:python3_host_prog = $HOME.'/.pyenv/versions/neovim/bin/python'


"---------------------------------------
" Configure fzf
"---------------------------------------
" Use <C-p> to open fuzzy search
nnoremap <C-p> :<C-u>FZF<CR>


"---------------------------------------
" Configure vim-polyglot
"---------------------------------------
" Configure vim-javascript
" enable JSDoc syntax highlighting
let g:javascript_plugin_jsdoc = 1
