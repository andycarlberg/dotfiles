" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

"---------------------------------------
" Declare the list of plugins
"---------------------------------------
" colorscheme
Plug 'mhartington/oceanic-next'

" auto complete
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" navigation
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" editing
Plug 'editorconfig/editorconfig-vim'

" version control
Plug 'tpope/vim-fugitive'

" Initialize plugin system
call plug#end()


"---------------------------------------
" Configure colorscheme
"---------------------------------------
if (has("termguicolors"))
  set termguicolors
endif

syntax enable
colorscheme OceanicNext



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
" Configure coc.nvim
"---------------------------------------
let g:coc_global_extensions = [
    \ 'coc-snippets',
    \ 'coc-pairs',
    \ 'coc-diagnostic',
    \ 'coc-prettier',
    \ 'coc-json',
    \]

" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Use <C-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <Tab> and <S-Tab> to navigation completion list.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

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
" Open NERDTree by default
autocmd vimenter * NERDTree
autocmd vimenter * wincmd p
