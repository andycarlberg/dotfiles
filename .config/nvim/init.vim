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
" colorscheme
Plug 'chuling/vim-equinusocio-material'

" auto complete
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" statusline
Plug 'itchyny/lightline.vim'

" navigation
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf'

" editing
Plug 'editorconfig/editorconfig-vim'

" syntax
Plug 'sheerun/vim-polyglot'

" snippets
Plug 'mlaursen/vim-react-snippets'

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

let g:equinusocio_material_darker = 1

syntax enable
colorscheme equinusocio_material

let g:lightline = {
    \ 'colorscheme': 'equinusocio_material',
    \}
set noshowmode


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
" Exit Insert mode with 'jk' or 'kj'
inoremap jk <ESC>
inoremap kj <ESC>


"---------------------------------------
" Configure misc
"---------------------------------------
" Enable hybrid line numbers
set number
set relativenumber


"---------------------------------------
" Configure Windows Subsystem for Linux
"---------------------------------------
if !empty($WSL_DISTRO_NAME)
    let g:clipboard = {
          \   'name': 'wslclip',
          \   'copy': {
          \      '+': 'wslclip -i',
          \      '*': 'wslclip -i',
          \    },
          \   'paste': {
          \      '+': 'wslclip -o',
          \      '*': 'wslclip -o',
          \   },
          \   'cache_enabled': 1,
          \ }
endif


"---------------------------------------
" Configure coc.nvim
"---------------------------------------
let g:coc_global_extensions = [
    \ 'coc-snippets',
    \ 'coc-pairs',
    \ 'coc-diagnostic',
    \ 'coc-json',
    \ 'coc-phpls'
    \]

" Load environment config
let g:coc_user_config = {
    \ "intelephense.licenceKey": $INTELEPHENSE_KEY,
    \}

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
    let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
    let g:coc_global_extensions += ['coc-eslint']
endif

" Use <C-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <tab> to trigger completion, completion confirm, snippet expand and jump
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
      let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    let g:coc_snippet_next = '<tab>'

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)



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

