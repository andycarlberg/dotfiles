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
Plug 'joshdick/onedark.vim'

" navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'

" editing

" syntax
Plug 'sheerun/vim-polyglot'

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

syntax on
colorscheme onedark

"---------------------------------------
" Configure indentation
"---------------------------------------


"---------------------------------------
" Configure key mappings
"---------------------------------------
" ctrl-p for FZF
nmap <C-P> :FZF<CR>


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


