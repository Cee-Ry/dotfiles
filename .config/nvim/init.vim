set number
" set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set mouse=a
set clipboard=unnamedplus
syntax on

call plug#begin()

" File explorer
Plug 'preservim/nerdtree'

" Fuzzy finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Status line
Plug 'vim-airline/vim-airline'

" Themes
Plug 'morhetz/gruvbox'

" Auto completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntax highlighting
Plug 'sheerun/vim-polyglot'

call plug#end()

colorscheme gruvbox

" Keybindings
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-p> :Files<CR>

" Compile and run current C/C++ file
nnoremap <F9> :w<CR>:!g++ % -o %:r && ./%:r<CR>

" Use Tab and Shift-Tab to navigate completion menu
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Use Enter to confirm completion
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>"

