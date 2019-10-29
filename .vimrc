" to `filetype on`, and unless we toggle it, our custom filetype detections
" won't be run.
filetype off

set encoding=utf-8

" Setup FZF
set rtp+=~/.fzf

" Vim-Plug
call plug#begin('~/.vim/plugged')
Plug 'bling/vim-airline'
Plug 'Valloric/YouCompleteMe'
Plug 'rdnetto/YCM-Generator', {'branch': 'stable'}
Plug 'vim-scripts/a.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
Plug 'airblade/vim-gitgutter'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'wincent/terminus'
Plug 'majutsushi/tagbar'
Plug 'kien/ctrlp.vim'
Plug 'ivalkeen/vim-ctrlp-tjump'
Plug 'altercation/vim-colors-solarized'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'tpope/vim-commentary'
Plug 'highwaynoise/chuck.vim'
Plug 'vim-latex/vim-latex'
" Plug 'vim-python/python-syntax'
Plug 'sheerun/vim-polyglot'
" Plug 'munshkr/vim-tidal'
" Plug 'junegunn/fzf.vim', {'dir': '~/.fzf', 'do': './install --all'}
call plug#end()

filetype indent plugin on
syntax enable
let g:python_highlight_all = 1

set background=dark
set t_Co=256  " 256 term coloring
"let g:solarized_termtrans = 1
"let g:solarized_termcolors=16
"let g:solarized_visibility='high'
"let g:solarized_contrast = 'high'

colorscheme molokai

" Display.
set ruler           " show cursor position
set showcmd         " show normal mode commands as they are entered
set showmode        " show editing mode in status (-- INSERT --)
set showmatch       " flash matching delimiters

" Scrolling.
"set scrolljump=5    " scroll five lines at a time vertically
set sidescroll=10   " minumum columns to scroll horizontally
set scrolloff=8    " start scrolling 15 from bott

" Indent.
set autoindent      " carry indent over to new lines

" Other.
set noerrorbells      " no bells in terminal

set backspace=indent,eol,start  " backspace over everything

set undolevels=1000   " number of undos stored
set viminfo='50,"50   " '=marks for x files, "=registers for x files

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

" modelines allow you to set variables specific to a file. By default, the first 
" and last five lines are read by vim for variable settings. For example, 
" if you put the following in the last line of a C program, you would get a 
" textwidth of 60 chars when editing that file:
" /* vim: tw=60 ts=2: */
" The modelines variable sets the number of lines (at the beginning and 
" end of each file) vim checks for initializations.
set modelines=0 "modelines are bad for your health

" Prevent the cursor from changing the current column when 
" jumping to other lines within the window
set nosol

" recursively search parent directories until tag file found
set tags=tags;/
" the iskeyword option specifies which characters can appear in a word.
" '@' stands for all alphabetic letters. '48-57' stands for ASCII characters
" 48 through 57, which are the numbers 0 to 9. '192-255' are the printable
" latin characters
set iskeyword=@,45,48-57,58,_,192-255,#

" Set Line numbers on
set number
"Set line numbers relative to current line
set relativenumber

" Move to next displayed line instead of actual line
nnoremap j gj
nnoremap k gk

" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
" enable filetype detection
filetype on
" enable loading the plugin files for specific file types
filetype plugin on
" enable loading the indent file for specific file types
filetype indent on

" When a file has been detected to have been changed outside of Vim and 
" it has not been changed inside of Vim, automatically read it again.
set autoread
" Automatically checktime when cursor has not moved in a while
au CursorHold * checktime 

" Turn off swap files
set noswapfile
set nobackup
set nowb

" Keep undo history across sessions, by storing in file.
" set undofile

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
" global mapleader
let g:mapleader = ","

" cf opens editable command history
map <C-f> q:i

" highlight current line curosr is on
set cursorline

" ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" let copy and paste work with yy, D, P, etc
set clipboard=unnamed
"
nnoremap :b :Bclose<Cr>

""""""""""""""""""""""""""""""
" splits
""""""""""""""""""""""""""""""
map <leader>v :vsp<CR>
map <leader>h :sp<CR>

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Line text past 80 char
set textwidth=120
"set colorcolumn=+1 " relative (to textwidth) columns to highlight "

set colorcolumn=120 " absolute columns to highlight "

" Tabs Settings
set shiftwidth=4    " two spaces per indent
set tabstop=4       " number of spaces per tab in display
set softtabstop=4   " number of spaces per tab when inserting
set expandtab       " substitute spaces for tabs

" In many terminal emulators the mouse works just fine, thus enable it.
" Use mouse normally in all ('a') cases.
if has('mouse')
  set mouse=a
endif

" Don't redraw while executing macros (good performance config)
set lazyredraw 
set ttyfast

" Don't get rid of buffers when changing files, used with minibufexpl.
" With :set hidden, opening a new file when the current buffer has unsaved 
" changes causes files to be hidden instead of closed. The unsaved changes 
" can still be accessed by typing :ls and then :b[N], where [N] is the 
" number of a buffer 
set hidden

" Prompt before closing a buffer if unsaved work
set confirm

" Autocompletion for buffer using tab
set wildmenu
set wildmode=longest:full,full
"set wildignorecase

" Buffer settings, use gb to jump to buffer list
noremap gb :ls<CR>:b<Space>

" buffer settings, next previous delete
map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr> 

" ******************** PLUGINS ********************
"" ========== SYNTASTIC ==========
map sr :SyntasticCheck<CR>
noremap sr :SyntasticCheck<CR>

map se :Errors<CR>
noremap se :Errors<CR>

map sc :lclose<CR>
noremap sc :lclose<CR>

map st :SyntasticToggleMode<CR>
noremap st :SyntasticToggleMode<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" let g:syntastic_debug = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_enable_balloons = 1
let g:syntastic_enable_signs = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
""" python
let g:syntastic_python_python_exec = '/usr/bin/python3'
let g:syntastic_python_pyflakes_exe = 'python3 -m pyflakes'
let g:syntastic_python_flake8_args='--ignore=E501,E228,W391,W291,E226,E127,E128,W605,E401'
let g:syntastic_python_pylint_post_args='--disable=
    \missing-docstring,
    \trailing-whitespace,
    \too-many-arguments,
    \line-too-long,
    \wrong-import-order,
    \invalid-name,
    \too-few-public-methods,
    \bad-continuation'
""" java
let java_highlight_functions = 1
let java_highlight_all = 1
" If you are trying this at runtime, you need to reload the syntax file
set filetype=java

" Some more highlights, in addition to those suggested by cmcginty
highlight link javaScopeDecl Statement
highlight link javaType Type
highlight link javaDocTags PreProc
""================================

" ========== YouCompleteMe ==========
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/.ycm_extra_conf.py'
" let g:loaded_youcompleteme = 1
" ===================================

" ========== NERD Tree ==========
nmap <silent> <F3> :NERDTreeTabsToggle<CR>
" map <C-n> :NERDTreeTabsToggle<CR>
" noremap <leader>n :NERDTreeToggle<CR>
map tt :NERDTreeToggle<CR>
noremap tt :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
" ===============================

" ========== Indent Line ==========
let g:indentLine_color_term = 239
let g:indentLine_char = '┆'
" =================================

" command-t settings for FB
let g:CommandTMaxHeight = 30
let g:CommandTMaxFiles = 500000
let g:CommandTInputDebounce = 200
let g:CommandTFileScanner = 'watchman'
let g:CommandTMaxCachedDirectories = 10
let g:CommandTSmartCase = 1

" ========== VIM - Airline ==========
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Show buffer numbers in airline
let g:airline#extensions#tabline#buffer_nr_show = 1

" Powerline fonts on
let g:airline_powerline_fonts = 1

" Airline theme
let g:airline_theme='dark'
" disable fileencoding, fileformat
let g:airline_section_y=''
" disable syntastic, whitespace
let g:airline_section_warning=''
" disable bufferline/filename
let g:airline_section_c=''
" ==================================

" ========== Jedi-Vim ==========
let g:jedi#use_splits_not_buffers="left"
let g:jedi#popup_select_first=0
" ==============================

" vim - notes directory
" ========== VIM Notes ==========
let g:notes_directories = ['~/notes']
let g:notes_conceal_url = 0
let g:notes_conceal_bold = 0
let g:notes_conceal_italic = 0
let g:notes_smart_quotes = 0
let g:notes_unicode_enabled = 0
let g:notes_conceal_code = 0
" ===============================

" ========== Terminus ==========
" disable insert cursor change 
let g:TerminusCursorShape = 0
" ==============================

" ========= Tag Bar ===========
nmap <leader>g :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_width = 50
let g:tagbar_foldlevel = 1
" =============================

" ========== FZF ===========
"let $FZF_DEFAULT_COMMAND= "ag -g ''"
nmap <leader>t :FZF<CR>
nmap <leader>a :Tags<CR>
nmap <leader>w :w<CR>
" ==========================

" ========== Ctrl-P ==========
nmap <leader>b :CtrlPBuffer<CR>
" this is the command to open the search buffer 
nmap <leader>r :CtrlPMRU<CR>
nmap cpr :CtrlPClearCache<CR>
let g:ctrlp_max_files = 300000
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:25,results:25'
let g:ctrlp_cmd='CtrlP :pwd'
let g:ctrlp_lazy_update = 210

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -l --nocolor -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" ===========================

" ========== Vim Commentary ==========
nmap cm gcc<CR>
map mm gc <CR>
nmap mm gc<CR>
nnoremap mm gc<CR>
nmap cp gcap<CR>
" ====================================
" **************************************************

" Configuration for ~/.vimrc:
" Bind <leader>y to forward last-yanked text to Clipper
nnoremap <leader>y :call system('nc localhost 8377', @0)<CR>

" Returns true if paste mode is enabled
function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  en
  return ''
endfunction

augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" Alex's FB specific stuff
" Treat *.test files as sql to get better syntax highlighting
"au BufReadPost *.test set syntax=sql

" NerdCommenter alternate syntax for .test files - currently not working!
let g:NERDCustomDelimiters = {
    \ 'test': { 'left': '#', 'leftAlt': '#'},
\ }
let NERD_test_alt_style=1

" Require tpope/vim-repeat to enable dot repeat support
" Jump to anywhere with only `s{char}{target}`
" `s<CR>` repeat last find motion.
nmap s <Plug>(easymotion-s2)
let g:EasyMotion_smartcase = 1

" Ctrlp fuzzy find for tags - overrides default tag jump
nnoremap <c-]> :CtrlPtjump<cr>
vnoremap <c-]> :CtrlPtjumpVisual<cr>
" if only one result, jump silently and immediately
let g:ctrlp_tjump_only_silent = 1
" don't show tag name in results as it wastes space
let g:ctrlp_tjump_skip_tag_name = 1

" LaTEX Stuff " 
let g:Tex_MultipleCompileFormats='pdf,bib,bibtex,pdf'
