set nocompatible
set t_RB=
set t_RF=
set t_u7=

au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif

" Formatting configuration
filetype plugin indent on
set spelllang=en_us
set encoding=utf-8

" Keyboard mapping
let mapleader=" "
set clipboard=unnamedplus

inoremap jk <ESC>
noremap <leader>w ^
noremap <leader>e $
noremap <leader>f <c-w>
noremap <c-n> :tabnew<CR>
noremap <leader><CR>1 :b1<CR>
noremap <leader><CR>2 :b2<CR>
noremap <leader><CR>3 :b3<CR>
noremap <leader><CR>4 :b4<CR>
noremap <leader><CR>5 :b5<CR>
noremap <leader><CR>6 :b6<CR>
noremap <leader><CR>7 :b7<CR>
noremap <leader><CR>8 :b8<CR>
noremap <leader><CR>9 :b9<CR>
noremap <leader>t :ter<CR>
noremap <leader>r :so $MYVIMRC<CR>
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt

map <leader>n :NERDTreeToggle<CR>

" Vim style configuration
syntax on

set scrolloff=12
set showcmd
set showmatch

set number
set numberwidth=4

set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

" Enable Plug plugins
call plug#begin(expand('<sfile>:p:h') . '/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sainnhe/sonokai'
Plug 'tribela/vim-transparent'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons' "RMHEADLESS
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'bling/vim-bufferline'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'meatballs/vim-xonsh'
Plug 'valloric/matchtagalways'
Plug 'godlygeek/tabular'
Plug 'jistr/vim-nerdtree-tabs'

call plug#end()


" Automatically install any Plug plugins
autocmd VimEnter *
    \ if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
        \| PlugInstall --sync
        \| q
        \| qa!
    \| endif


if (has("termguicolors"))
    set termguicolors
endif

autocmd ColorScheme * highlight! link SignColumn LineNr
autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight NonText ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight VertSplit cterm=NONE ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight LineNr ctermbg=NONE guibg=NONE

let g:sonokai_style = 'atlantis'
let g:sonokai_better_performance = 1

colorscheme sonokai

" Airline
set laststatus=2
let g:airline_powerline_fonts=1 "RMHEADLESS
let g:airline_theme='sonokai'

" Git Gutter
let g:gitgutter_set_sign_backgrounds=1
set updatetime=250

" NERDTree
let NERDTreeShowHidden=1
let NERDTreeChDirMode=3

" Open NERDTree with vim
let g:nerdtree_tabs_open_on_console_startup=1
" Open NERDTree in the new tabs
let g:nerdtree_tabs_open_on_new_tab=1
let g:nerdtree_tabs_meaningful_tab_names=1
let g:nerdtree_tabs_toggle=1
let g:nerdtree_tabs_autoclose=1
" Synchronize NERDTree's tabs
let g:nerdtree_tabs_synchronize_view=1
