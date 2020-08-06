syntax enable
set number
set showmatch
set mouse=a
set clipboard=unnamed
set showcmd
set ruler
set encoding=utf8
set sw=2
set relativenumber
set laststatus=2
set t_Co=256
call plug#begin('~/.vim/plugged')

"Temas
Plug 'morhetz/gruvbox'
Plug 'ternjs/tern_for_vim', { 'do' : 'npm install' }
"IDE
Plug 'easymotion/vim-easymotion'
"NerdTree
Plug 'scrooloose/nerdtree'
"Saltar
Plug 'christoomey/vim-tmux-navigator'
"Brackets
Plug 'jiangmiao/auto-pairs'
"Javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Colorized
Plug 'luochen1990/rainbow'

call plug#end()

colorscheme gruvbox

let g:gruvbox_contrast_dark="hard"
let NERDTreeQuitOnOpen=1
let g:jsx_pragma_required = 1
let g:rainbow_active = 1



let mapleader=" "
nmap <Leader>s <Plug>(easymotion-s2)
nmap <Leader>nt :NERDTreeFind<CR>
filetype plugin on
set omnifunc=syntaxcomplete#complete

