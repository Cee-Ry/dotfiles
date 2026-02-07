set number
set relativenumber
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
