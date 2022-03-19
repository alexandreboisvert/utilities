" This is my template ~/.vimrc file.

" Showing the matching braces
set showmatch

" Ignore the case when searching and autocompleting
set ignorecase
set infercase

" Do not wrap long lines
set nowrap

" This is used to get a 'crosshair' on the cursor. However, this is
" annoying on some systems, depending on the terminal in use.
"set cursorline
"set cursorcolumn

" Colorsheme to use
colorscheme koehler

" Enable line numbering
"set number

" Activate the syntax highlighting
syntax on

" Tabs management: use 4 spaces for Python
" To use a real tab: CTRL-V<TAB>
set tabstop=4
set shiftwidth=4
set expandtab

" Automatic indentation for the files
set autoindent

" Informative status line
" (This was taken from a book, but I can't remember the title)
" %F%m%r%h%w               Full filename (path included).
" [FORMAT=%{&ff}]          Text format (Windows/Unix).
" [TYPE=%Y]                File type (TEXT, VIM, HTML, etc.).
" [ASCII=\%03.3b]          ASCII code of the current character under
"                          the cursor.
" [HEX=\%02.2B]            HEX code of the current character under
"                          the cursor.
" [POS=%06l,%02v][%p%%]    Position (line, column, percentage).
" [LEN=%L]                 Total number of lines.
" laststatus=2             A value of 2 will force the display of
"                          the information line at the bottom all
"                          the time.
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%06l,%02v][%p%%]\ [LEN=%L]
set laststatus=2

" Search options
" Incremental search begins searching immediately.
" Higlight the search results.
set incsearch
set hlsearch

" Color the 70th column
"set colorcolumn=71

" Autowrap the text at 70th column
"set textwidth=71

" Using more helpful menus in commands
set wildmenu
set wildmode=longest:full,full

" reload the file automatically upon external edit
set autoread

" faster scrolling with modern terminal emulators
set ttyfast
