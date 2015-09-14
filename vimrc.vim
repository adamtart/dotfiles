" Use Vim mode instead of Vi mode.
set nocompatible

" Don't show intro message when starting Vim
set shortmess=atI

" Standard file types
set fileformats=unix,dos,mac

" Instead of failing a command because of unsaved changes, raise a dialog
" asking if you wish to save changed files.
set confirm

" Keep longer history
set history=1000

" Save undos across sesssions
if has('persistent_undo')
  " Create undodir if it does not exist.
  if !isdirectory(expand('~').'/.vim/undodir')
    silent !mkdir -p ~/.vim/undodir > /dev/null 2>&1
  endif
  " Save undos after file closes
  set undofile
  " Save undo files to central directory
  set undodir=~/.vim/undodir
  " Maximum number of undos to save
  set undolevels=1000
  " Maximum number of lines to save for undo on buffer reload
  set undoreload=10000
endif

" Centralize backups
" Create backupdir if it does not exist
if !isdirectory(expand('~').'/.vim/backups')
  silent !mkdir -p ~/.vim/backups > /dev/null 2>&1
endif
set backupdir=~/.vim/backups

" Centralize swapfiles
" Create backupdir if it does not exist
if !isdirectory(expand('~').'/.vim/swaps')
  silent !mkdir -p ~/.vim/swaps > /dev/null 2>&1
endif
set directory=~/.vim/swaps


"==================================
" Mappings
"==================================
" remap ; to : so commond mode can be entered by typing ;
nore ; :
" Use "," as mapleader (easier to reach than "\")
let mapleader = ","
let g:mapleader = ","

" Set timeout on key combinations to shorter than default of 1s.
set timeoutlen=300

" Toggle paste mode on and off
set pastetoggle=<leader>p

" Extend % key to match brackets, if/else, HTML/XML tags, etc.
runtime macros/matchit.vim

" Toggle highlight of current row/column
:hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" Use Q for formatting the current paragraph (or visual selection)
vmap Q gq
nmap Q gqap

" Cursor keys move by visual lines, i.e., for long lines that wrap, moving up or
" down will go to the next visual line (row in editor) instead of line number.
imap <up> <C-O>gk
imap <down> <C-O>gj
nmap <up> gk
nmap <down> gj
nmap k gk
nmap j gj
vmap <up> gk
vmap <down> gj
vmap k gk
vmap j gj

"==================================
" Formatting
"==================================

" Syntax highlighting
syntax on
" Attempt to recognize filetype for syntax highlighting, setting of options, and
" automatic indentation.
filetype on
filetype plugin indent on

" Recognize .md files as markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown

" Indentation and tabs
set autoindent
set smartindent
set expandtab " Use spaces instead of tabs
set smarttab
set shiftwidth=2 " 1 tab == 2 spaces
set softtabstop=2
set tabstop=2
set shiftround " when at 3 spaces, and I hit > ... go to 4, not 5
set copyindent " use existing indents for new indents
set preserveindent " save as much indent structure as possible

" Wrapping
set wrap " Wrap long lines
set linebreak " Wrap lines at intelligent points.
set textwidth=80 " Break lines at 80 chars.

set formatoptions=tcrql         " t - autowrap to textwidth
                                " c - autowrap comments to textwidth
                                " r - autoinsert comment leader with <Enter>
                                " q - allow formatting of comments with :gq
                                " l - don't format already long lines
" Recognize numbered lists
set formatoptions+=n
" And bullets, too
set formatlistpat=^\\s*\\(\\d\\\|[-*]\\)\\+[\\]:.)}\\t\ ]\\s*

" Catch trailing whitespace, but don't show it by default. Instead, enable
" toggling by pressing ,s
set listchars=tab:»·,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>


"==================================
" Movement
"==================================

" None of these characters are word dividers, helpful when moving by word.
set iskeyword+=_,$,@,%,#
" Try to keep cursor in same column when moving between lines.
set nostartofline
" Allow backspacing over autoindent, line breaks, and start of insert action
set backspace=indent,eol,start
set whichwrap+=<,>,h,l,[,]    " <   <Left>    Normal and Visual
                              " >   <Right>   Normal and Visual
                              " h   "h"       Normal and Visual
                              " l   "l"       Normal and Visual
                              " [   <Left>    Insert and Replace
                              " ]   <Right>   Insert and Replace

" Start scrolling when 5 lines away from margins.
set scrolloff=5


"==================================
" Searching
"==================================

set showmatch " show matching brackets
set noincsearch " NO search as characters are entered
set nohlsearch " NO highlight matches
set ignorecase " ignore case when searching
set infercase " case inferred by default
set smartcase " if there are caps, go case-sensitive


"==================================
" UI
"==================================

" Display line numbers on the left
set number
" Set line numbers to grey color
highlight LineNr ctermfg=240
" Set default number of columns reserved for line numbers to 5. One column is
" used for space between line numbers and text, so this leaves 4 columns for
" line numbers, allowing for up to 9999 lines without resizing.
set numberwidth=5
" Display cursor position on last line of screen or in status line
set ruler
" Height of command bar
set cmdheight=2
" Always display status line
set laststatus=2
" Status line
set statusline=%F%m%r%h%w\ [%{&ff}]%y\ (%p%%\ of\ %L)[l=%l,c=%v]
"              | | | | |   |       |    |         |     |    |
"              | | | | |   |       |    |         |     |    + current column
"              | | | | |   |       |    |         |     +-- current line
"              | | | | |   |       |    |         +-- number of lines
"              | | | | |   |       |    +-- current % into file
"              | | | | |   |       +-- current syntax in square brackets
"              | | | | |   +-- current fileformat
"              | | | | +-- preview flag in square brackets
"              | | | +-- help flag in square brackets
"              | | +-- readonly flag in square brackets
"              | +-- rodified flag in square brackets
"              +-- full path to file in the buffer
set showcmd " show command being typed
set showmode " show current mode

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
