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

set showcmd
set showmatch

set number
set numberwidth=4
highlight LineNr term=bold ctermfg=grey " RMHEADLESS

set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

highlight VertSplit ctermbg=NONE ctermfg=NONE term=NONE cterm=NONE gui=NONE "RMHEADLESS


" Enable Plug plugins
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'mhartington/oceanic-next' "RMHEADLESS
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons' "RMHEADLESS
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'bling/vim-bufferline'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'ervandew/supertab'

call plug#end()


" Automatically install any Plug plugins
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \|   qa!
  \| endif


" Plugin configuration

" Theme
if (has("termguicolors"))
    set termguicolors "RMHEADLESS
endif
colorscheme OceanicNext "RMHEADLESS

" Airline
set laststatus=2
let g:airline_powerline_fonts=1 "RMHEADLESS
let g:airline_theme='oceanicnext' "RMHEADLESS

" NERDTree
let NERDTreeShowHidden=1
