" Use Vim mode instead of Vi mode.
set nocompatible

" Standard file types
set fileformats=unix,dos,mac

" Instead of failing a command because of unsaved changes, raise a dialog
" asking if you wish to save changed files.
set confirm

" remap ; to : so commond mode can be entered by typing ;
nore ; :


"==================================
" Formatting
"==================================

" Syntax highlighting
syntax on
" Attempt to recognize filetype for syntax highlighting, setting of options, and
" automatic indentation.
filetype on
filetype plugin indent on


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
