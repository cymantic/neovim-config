" Plugins
let firstrun=0
if !filereadable(expand("~/.config/nvim/autoload/plug.vim"))
  let firstrun=1
  silent !mkdir -p ~/.config/nvim/{autoload,undo,backups}
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.config/nvim/plugged')
" sensible defaults
Plug 'tpope/vim-sensible'

" determine indentation
Plug 'tpope/vim-sleuth'

" surround with...
Plug 'tpope/vim-surround'

" Repeat for plugins
Plug 'tpope/vim-repeat'

" nicer colours
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-vividchalk'

" file navigation
Plug 'ctrlpvim/ctrlp.vim'

" git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" nicer status bar
Plug 'vim-airline/vim-airline'

" syntax highlighting
Plug 'scrooloose/syntastic'

" markdown
Plug 'tpope/vim-markdown'
Plug 'vim-scripts/SyntaxRange'

" Clojure stuff
Plug 'tpope/vim-salve'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fireplace'
Plug 'vim-scripts/paredit.vim'
Plug 'luochen1990/rainbow'
Plug 'venantius/vim-cljfmt'
Plug 'venantius/vim-eastwood'

" Rust stuff
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'cespare/vim-toml'

call plug#end()
if 1 == firstrun
  :PlugInstall
endif

" configure vim like, assume vim-sensible
set nocompatible
syntax on
filetype plugin indent on
set modelines=0

" my prefered Colour schemes
set background=dark
silent! colorscheme solarized
silent! colorscheme vividchalk

" my prefered tab settings (overridden by vim-sleuth)
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

"set swp file storate to local ~/tmp
set dir=~/tmp

" easy to hit commands by mapping ; to :
nnoremap ; :

" default leader is \
let mapleader = ","

" make search case insensitive, toggle highlighting Ctrl-L from vim-sensible
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

" some simpler editing commands for insert mode
inoremap jk <ESC>
inoremap aa @
inoremap '' "
inoremap jj ->
inoremap kk =>
inoremap hh &
inoremap uu _
inoremap ;; :=

" on lose focus, write all changed buffers
au FocusLost * silent! wa

" Remove Trailing Whitespace
nnoremap <leader>rtw :%s/\s\+$//e<CR>

" Syntastic, toggle location window :lcl :lop
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Clojure stuff http://blog.venanti.us/clojure-vim/
" Working with CtrlP
let g:ctrlp_root_markers = ['project.clj']
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" Ignore file defined in .gitignore from Ctrl-P docs
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" hot reloading
au Filetype clojure nmap <c-c><c-k> :Require<cr>
" Rainbow Parans (Toggle with :RainbowToggle)
let g:rainbow_active = 0
" Format file with :Cljfmt

" Allow code fencing in markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'clj=clojure', 'sql', 'js=javascript']

" Rust code completion
set hidden
let g:racer_cmd = "~/.cargo/bin/racer"
