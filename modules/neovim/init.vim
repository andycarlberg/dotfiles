" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Declare the list of plugins
Plug 'mhartington/oceanic-next'

" Initialize plugin system
call plug#end()

" Configure colorscheme
if (has("termguicolors"))
  set termguicolors
endif

syntax enable
colorscheme OceanicNext

" Configure key mappings
" Exit Insert mode with 'jk' or 'kj'
inoremap jk <ESC>
inoremap kj <ESC>

