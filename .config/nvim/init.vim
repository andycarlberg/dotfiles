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

" navigation

" editing

" syntax

" LSP

" snippets

" version control

" misc

" Initialize plugin system
call plug#end()


"---------------------------------------
" Configure colorscheme
"---------------------------------------
if (has("termguicolors"))
  set termguicolors
endif

syntax enable

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


