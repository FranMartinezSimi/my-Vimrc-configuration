" ====================================
" VIM CONFIGURATION - ARTISAN DEVELOPMENT
" Configuración completa para desarrollo artesanal multi-lenguaje
" ====================================

" ====================================
" BASIC VIM SETTINGS
" ====================================
set nocompatible              " Disable vi compatibility
filetype off                  " Required for plugin manager

" Basic editor settings
set number                    " Show line numbers
set relativenumber           " Show relative line numbers
set cursorline              " Highlight current line
set showmatch               " Show matching parentheses
set incsearch               " Incremental search
set hlsearch                " Highlight search results
set ignorecase              " Case insensitive search
set smartcase               " Case sensitive when uppercase present
set autoindent              " Auto indentation
set smartindent             " Smart indentation
set expandtab               " Use spaces instead of tabs
set tabstop=4               " Tab width
set shiftwidth=4            " Shift width
set softtabstop=4           " Soft tab stop
set wrap                    " Wrap lines
set encoding=utf-8          " UTF-8 encoding
set backspace=indent,eol,start " Better backspace behavior

" Visual settings
syntax enable               " Enable syntax highlighting
set background=dark         " Dark background
set termguicolors          " True color support
set laststatus=2           " Always show status line
set showcmd                " Show command in status line
set ruler                  " Show cursor position
set wildmenu               " Better command completion
set scrolloff=8            " Keep 8 lines above/below cursor

" File and backup settings
set nobackup               " No backup files
set noswapfile             " No swap files
set noundofile             " No undo files
set autoread               " Auto reload changed files
set hidden                 " Allow hidden buffers

" Split settings
set splitbelow             " Horizontal splits below
set splitright             " Vertical splits right

" Mouse and clipboard
set mouse=a                " Enable mouse
set clipboard=unnamedplus  " Use system clipboard

" ====================================
" PLUGIN MANAGER (vim-plug)
" ====================================
call plug#begin('~/.vim/plugged')

" File and project management
Plug 'preservim/nerdtree'                   " File explorer
Plug 'ctrlpvim/ctrlp.vim'                   " Fuzzy file finder
Plug 'airblade/vim-gitgutter'               " Git diff in gutter
Plug 'tpope/vim-fugitive'                   " Git integration

" Editing enhancements
Plug 'tpope/vim-commentary'                 " Comment/uncomment (gc)
Plug 'jiangmiao/auto-pairs'                 " Auto-pair brackets
Plug 'tpope/vim-surround'                   " Surround text objects
Plug 'dense-analysis/ale'                   " Async linting engine

" Language support
Plug 'vim-scripts/c.vim'                    " C utilities
Plug 'octol/vim-cpp-enhanced-highlight'     " Enhanced C/C++ highlighting
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'vim-python/python-syntax', { 'for': 'python' }

" AUTOCOMPLETE VIM"
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Visual enhancements
Plug 'vim-airline/vim-airline'              " Status line
Plug 'vim-airline/vim-airline-themes'       " Airline themes
Plug 'tomasr/molokai'                       " Monokai colorscheme
Plug 'morhetz/gruvbox'                      " Alternative gruvbox

call plug#end()

" ====================================
" COLORSCHEME
" ====================================
try
   colorscheme molokai
catch
   colorscheme default
endtry

" ====================================
" PLUGIN CONFIGURATIONS
" ====================================

" ALE Configuration
let g:ale_linters = {
\   'c': ['gcc', 'cppcheck', 'clangd'],
\   'cpp': ['g++', 'cppcheck', 'clangd'],
\   'python': ['flake8', 'pylint'],
\   'go': ['go build', 'gofmt', 'golint'],
\   'javascript': ['eslint'],
\   'rust': ['cargo'],
\}

let g:ale_fixers = {
\   'c': ['clang-format'],
\   'cpp': ['clang-format'],
\   'python': ['autopep8'],
\   'go': ['gofmt'],
\   'javascript': ['prettier'],
\   'rust': ['rustfmt'],
\}

let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = 'ℹ'
let g:ale_fix_on_save = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_lint_delay = 1000

" ALE C/C++ specific options
let g:ale_c_gcc_options = '-Wall -Wextra -std=c99'
let g:ale_cpp_gcc_options = '-Wall -Wextra -std=c++17'
let g:ale_c_cppcheck_options = '--enable=warning,style'
let g:ale_cpp_cppcheck_options = '--enable=warning,style'

" Show errors in location list (only when requested)
let g:ale_open_list = 0
let g:ale_keep_list_window_open = 0
let g:ale_list_window_size = 5

" NERDTree Configuration
let g:NERDTreeWinSize = 30
let g:NERDTreeShowHidden = 1
let g:NERDTreeIgnore = ['\.pyc$', '\.o$', '\.so$', '\.a$']

" vim-go Configuration
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_auto_type_info = 1
let g:go_fmt_command = "goimports"

" Auto-pairs Configuration
let g:AutoPairsShortcutToggle = '<C-P>'

" Airline Configuration
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1

" CoC Configuration
" Use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[d` and `]d` to navigate CoC diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" ====================================
" LANGUAGE-SPECIFIC SETTINGS
" ====================================

" C/C++
autocmd FileType c,cpp setlocal tabstop=4
autocmd FileType c,cpp setlocal shiftwidth=4
autocmd FileType c,cpp setlocal expandtab
autocmd FileType c,cpp setlocal cindent
autocmd FileType c,cpp setlocal cinoptions=:0,p0,t0
autocmd FileType c,cpp setlocal cinwords=if,else,while,do,for,switch,case

" Go
autocmd FileType go setlocal tabstop=4
autocmd FileType go setlocal shiftwidth=4
autocmd FileType go setlocal noexpandtab

" Python
autocmd FileType python setlocal tabstop=4
autocmd FileType python setlocal shiftwidth=4
autocmd FileType python setlocal expandtab

" Rust
autocmd FileType rust setlocal tabstop=4
autocmd FileType rust setlocal shiftwidth=4
autocmd FileType rust setlocal expandtab

" JavaScript
autocmd FileType javascript setlocal tabstop=2
autocmd FileType javascript setlocal shiftwidth=2
autocmd FileType javascript setlocal expandtab

" ====================================
" KEY MAPPINGS - FUNCTION KEYS
" ====================================

" F5: Compile and run based on file type
autocmd FileType c nnoremap <buffer> <F5> :w<CR>:!clear && gcc -Wall -Wextra -g % -o %< && ./%< <CR>
autocmd FileType cpp nnoremap <buffer> <F5> :w<CR>:!clear && g++ -Wall -Wextra -g % -o %< && ./%< <CR>
autocmd FileType python nnoremap <buffer> <F5> :w<CR>:!clear && python3 % <CR>
autocmd FileType go nnoremap <buffer> <F5> :w<CR>:!clear && go run % <CR>
autocmd FileType javascript nnoremap <buffer> <F5> :w<CR>:!clear && node % <CR>
autocmd FileType rust nnoremap <buffer> <F5> :w<CR>:!clear && cargo run <CR>

" F6: Make
nnoremap <F6> :w<CR>:!clear && make <CR>

" F7: Debug
autocmd FileType c nnoremap <buffer> <F7> :!clear && gdb ./%< <CR>
autocmd FileType cpp nnoremap <buffer> <F7> :!clear && gdb ./%< <CR>
autocmd FileType go nnoremap <buffer> <F7> :GoDebug<CR>
autocmd FileType rust nnoremap <buffer> <F7> :!clear && rust-gdb target/debug/%< <CR>

" F8: Analysis tools
autocmd FileType c nnoremap <buffer> <F8> :!clear && valgrind --leak-check=full ./%< <CR>
autocmd FileType cpp nnoremap <buffer> <F8> :!clear && valgrind --leak-check=full ./%< <CR>
autocmd FileType python nnoremap <buffer> <F8> :!clear && python3 -m py_compile % <CR>
autocmd FileType go nnoremap <buffer> <F8> :GoVet<CR>
autocmd FileType rust nnoremap <buffer> <F8> :!clear && cargo clippy <CR>

" F9: Format code
autocmd FileType c nnoremap <buffer> <F9> :ALEFix<CR>
autocmd FileType cpp nnoremap <buffer> <F9> :ALEFix<CR>
autocmd FileType python nnoremap <buffer> <F9> :ALEFix<CR>
autocmd FileType go nnoremap <buffer> <F9> :GoFmt<CR>
autocmd FileType rust nnoremap <buffer> <F9> :RustFmt<CR>

" F10: Toggle ALE
nnoremap <F10> :ALEToggle<CR>

" Toggle NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

" F12: Show ALE info
nnoremap <F12> :ALEInfo<CR>

" F11: Show error details
nnoremap <F11> :ALEDetail<CR>

" Leader shortcuts for errors
nnoremap <leader>e :lopen<CR>
nnoremap <leader>E :lclose<CR>

" ====================================
" KEY MAPPINGS - LEADER SHORTCUTS
" ====================================

" Set leader key
let mapleader = " "

" NEERDTHREE FILES"

" File operations
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>

" Quick access to important files
nnoremap <leader>m :e Makefile<CR>
nnoremap <leader>r :e README.md<CR>
nnoremap <leader>g :e .gitignore<CR>

" Search and replace
nnoremap <leader>/ :nohlsearch<CR>
nnoremap <leader>s :%s//g<Left><Left>

" Buffer operations
nnoremap <leader>b :buffers<CR>
nnoremap <leader>n :bnext<CR>
nnoremap <leader>p :bprev<CR>

" Toggle features
nnoremap <leader>n :set number!<CR>
nnoremap <leader>h :set hlsearch!<CR>
nnoremap <leader>pp :set paste!<CR>

" Reload vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>

" ====================================
" KEY MAPPINGS - SPLIT NAVIGATION
" ====================================

" Navigate splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Resize splits
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

" ====================================
" KEY MAPPINGS - ALE NAVIGATION
" ====================================

" Navigate ALE errors
nmap <silent> [g <Plug>(ale_previous_wrap)
nmap <silent> ]g <Plug>(ale_next_wrap)

" ====================================
" CUSTOM COMMANDS
" ====================================

" Build commands
command! Compile !make
command! Clean !make clean
command! Build :!clear && make
command! Test :!clear && make test

" C-specific commands
command! Ccompile !gcc -Wall -Wextra -g % -o %
command! Crun !./%
command! Cdebug !gdb ./%
command! Cvalgrind !valgrind --leak-check=full ./%

" Git commands
command! Gstatus Git
command! Gdiff Gdiff
command! Glog Glog

" Error analysis commands
command! ErrorsOn :let g:ale_open_list=1 | let g:ale_c_cppcheck_options='--enable=all' | let g:ale_cpp_cppcheck_options='--enable=all' | ALELint
command! ErrorsOff :let g:ale_open_list=0 | let g:ale_c_cppcheck_options='--enable=warning,style' | let g:ale_cpp_cppcheck_options='--enable=warning,style' | lclose

" ====================================
" AUTO-COMMANDS
" ====================================

" Auto-save when focus is lost
autocmd FocusLost * silent! wa

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Remember cursor position
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Auto-reload vimrc
autocmd BufWritePost .vimrc source %

" Set filetype for common files
autocmd BufNewFile,BufRead *.h set filetype=c
autocmd BufNewFile,BufRead Makefile,makefile set filetype=make

" ====================================
" TEMPLATES FOR NEW FILES
" ====================================

" C template
autocmd BufNewFile *.c 0r ~/.vim/templates/template.c
autocmd BufNewFile *.h 0r ~/.vim/templates/template.h
autocmd BufNewFile Makefile 0r ~/.vim/templates/template.makefile

" ====================================
" STATUS LINE CUSTOMIZATION
" ====================================

" Custom status line per file type
autocmd FileType c setlocal statusline=%f\ [C]\ %m%r%h%w\ [%l/%L,\ %v]\ [%p%%]
autocmd FileType cpp setlocal statusline=%f\ [C++]\ %m%r%h%w\ [%l/%L,\ %v]\ [%p%%]
autocmd FileType go setlocal statusline=%f\ [Go]\ %m%r%h%w\ [%l/%L,\ %v]\ [%p%%]
autocmd FileType python setlocal statusline=%f\ [Python]\ %m%r%h%w\ [%l/%L,\ %v]\ [%p%%]
autocmd FileType rust setlocal statusline=%f\ [Rust]\ %m%r%h%w\ [%l/%L,\ %v]\ [%p%%]

" ====================================
" MISC SETTINGS
" ====================================

" Enable filetype detection and plugins
filetype plugin indent on

" Better completion
set completeopt=menuone,noselect

" Timeout settings
set timeoutlen=1000
set ttimeoutlen=50

" ====================================
" QUICK REFERENCE
" ====================================
" F5:  Compile/run current file
" F6:  Make
" F7:  Debug
" F8:  Analysis (valgrind, vet, etc.)
" F9:  Format code
" F10: Toggle ALE
" F11: Show error details
" F12: ALE info
"
" Leader shortcuts (Space):
" <leader>w: Save
" <leader>q: Quit
" <leader>m: Open Makefile
" <leader>/: Clear search highlight
" <leader>sv: Reload vimrc
" <leader>e: Open error list
" <leader>E: Close error list
"
" Error Commands:
" :ErrorsOn  - Enable full error analysis (slower)
" :ErrorsOff - Disable full analysis (faster)
"
" ALE navigation:
" [g: Previous ALE error
" ]g: Next ALE error
"
" CoC navigation:
" [d: Previous CoC diagnostic
" ]d: Next CoC diagnostic
"
" Split navigation:
" Ctrl+h/j/k/l: Navigate splits
