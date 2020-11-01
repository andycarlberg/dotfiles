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
Plug 'chuling/vim-equinusocio-material'
Plug 'vim-airline/vim-airline'

" navigation
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" editing
Plug 'editorconfig/editorconfig-vim'

" syntax
Plug 'sheerun/vim-polyglot'

" LSP
" Plug 'neovim/nvim-lspconfig'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" snippets

" version control

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

let g:equinusocio_material_darker = 1

syntax enable
colorscheme equinusocio_material


"---------------------------------------
" Configure indentation
"---------------------------------------
set tabstop=4       " number of visual spaces per <Tab>
set shiftwidth=0    " inherit number of spaces for autoindent from tabstop
set expandtab       " tabs are spaces
set autoindent


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
" Configure coc.nvim
"---------------------------------------
let g:coc_global_extensions = [
  \ 'coc-phpls',
  \ 'coc-tsserver'
  \]

" Load eslint if in an appropriate project
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
    let g:coc_global_extensions += ['coc-eslint']
endif

" Load environment config
let g:coc_user_config = {
   \ "intelephense.licenceKey": $INTELEPHENSE_KEY,
   \}


"---------------------------------------
" Configure fzf
"---------------------------------------
" Use <C-p> to open fuzzy search
nnoremap <C-p> :<C-u>FZF<CR>


"---------------------------------------
" Configure NERDTree
"---------------------------------------
" Show hidden files
let NERDTreeShowHidden=1

"---------------------------------------
" Configure vim-polyglot
"---------------------------------------
" Configure vim-javascript
" enable JSDoc syntax highlighting
let g:javascript_plugin_jsdoc = 1
