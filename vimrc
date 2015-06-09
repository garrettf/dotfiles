set nocompatible
set encoding=utf-8

" ------------------------------------------------
"     Plugins 
" ------------------------------------------------
call plug#begin(expand('~/.vim/bundle/'))

  " ----------------------------------------------
  "     General Enhancements    
  " ----------------------------------------------

  " Lightweight Powerline-like status bar.
  Plug 'bling/vim-airline'

  " Fuzzy search for directories, buffers, and MRU
  Plug 'kien/ctrlp.vim'

  " Smart tab completion with <Tab>
  Plug 'ervandew/supertab'

  " Directory navigation window.
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

  " Use ack from vim with :Ack
  Plug 'mileszs/ack.vim', { 'on': 'Ack' }

  " Use ag from vim with :Ag
  Plug 'rking/ag.vim', { 'on': 'Ag' }

  " Mappings to change surrounding delimiters
  "   https://github.com/tpope/vim-surround
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'

  " Git diff indicators next to line numbers
  Plug 'airblade/vim-gitgutter'

  " Tool for lining up text
  "    https://github.com/godlygeek/tabular
  Plug 'godlygeek/tabular'

  " Auto-insert endifs and other block constructs
  Plug 'tpope/vim-endwise'

  " Asynchronous and/or silent builds via external terminal or tmux
  "   Use :Start[!] or :Dispatch[!] or :Make
  "      https://github.com/tpope/vim-dispatch
  Plug 'tpope/vim-dispatch'

  " Zen mode for distraction-free writing
  Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }

  " Comment toggling
  Plug 'tpope/vim-commentary'

  " Switches between relative and absolute line numbers based on mode
  " (disabled due to speed concerns)
  " Plug 'myusuf3/numbers.vim'

  " Automatic ctags generation and highlighting
  " (disabled due to speed concerns)
  "Plug 'xolox/vim-misc'
  "Plug 'xolox/vim-easytags'

  " Plain ctag highlighting
  Plug 'abudden/taghighlight-automirror'

  "Plug 'majutsushi/tagbar'
  Plug 'terryma/vim-expand-region'

  " ----------------------------------------------
  "     Language-specific Plugins
  " ----------------------------------------------
  
  " Automatic XML tag closing:
  "   http://www.vim.org/scripts/script.php?script_id=13
  Plug 'closetag.vim', { 'for': 'html' }

  " Tim Pope's infamous rails gem
  Plug 'tpope/vim-rails'

  " Syntax highlighting and other tools for rspec
  Plug 'Keithbsmiley/rspec.vim', { 'for': 'ruby' }

  " Syntax highlighting and other tools for Processing
  Plug 'willpragnell/vim-reprocessed'

  " Syntax highlighting for Jade templates
  Plug 'digitaltoad/vim-jade'

  " Coffeescript support
  Plug 'kchmck/vim-coffee-script'

  " Go support
  Plug 'fatih/vim-go'

  " Moonscript support
  Plug 'leafo/moonscript-vim', { 'for': 'moon' }

  " Scala support
  Plug 'derekwyatt/vim-scala'
  

call plug#end()

filetype plugin indent on


" ------------------------------------------------
"     Indentation settings
" ------------------------------------------------

" Default to 2 spaces per tab for indentation.
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Automatically indent based on context
set autoindent


" ------------------------------------------------
"     Autocommands
" ------------------------------------------------

" Detect *.md files as markdown and not mode2
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.hn set filetype=yacc

" Use dispatch.vim to compile *.tex upon saving
augroup TexAutoWrite
    autocmd FileType tex :autocmd! BufWritePost * Start! pdflatex <afile>
augroup END

" Run processing sketches upon save (kept for future macro creation)
"autocmd FileType processing :autocmd! BufWritePost * Start! processing-java --sketch=%:p:h --output=%:p:h/bin --force --run

" Disable 80-char marker in quickfix buffers (for Ack and CtrlP and whatnot)
au BufReadPost quickfix setlocal colorcolumn=0

" Remove whitespace at EOL
fun! <SID>StripTrailingWhitespace()
    " Ignore vimrc or cs164
    if expand('%:p') =~ 'vimrc'
        return
    endif
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType c,cpp,java,php,ruby,python,perl,rb,html,haml autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespace()

" 4 spaces for java
autocmd FileType java
  \ setlocal shiftwidth=4 |
  \ setlocal tabstop=4 |
  \ setlocal softtabstop=4

autocmd FileType go
  \ setlocal shiftwidth=4 |
  \ setlocal tabstop=4 |
  \ setlocal softtabstop=4

" ------------------------------------------------
"     Search and Replace settings
" ------------------------------------------------

" Default to case insensitive text search
nnoremap / /\v
vnoremap / /\v

" Search as you type
set incsearch
set hlsearch

" Ignore case unless you use a capital letter
set ignorecase
set smartcase

" Default to performing replacement on all occurences of a match instead of
" just the first per line.
set gdefault


" ------------------------------------------------
"     Viewport settings
" ------------------------------------------------

" Show absolute line numbers
set number

" Maximum 79 characters per line. Wrap afterward. Highlight the 80th column.
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=80

" Always scroll the viewport 3 lines above and below the current line
set scrolloff=3

" Display characters to the right of the edge of the screen.
set sidescrolloff=5
set display+=lastline

" Give every window a status line
set laststatus=2

" Highlight the current line
" (disabled due to cursor lag in large files)
"set cursorline

" Highlight the cursor line in unfocused windows. Turn off line highlighting
" when focus gained. Useful for locating your cursor when switching windows.
function! ShowCursor()
  if &buftype == ''
    set cursorline
  endif
endfunction

function! HideCursor()
  if &buftype == ''
    set nocursorline
  endif
endfunction
au FocusLost * :call ShowCursor()
au FocusGained * :call HideCursor()
au WinLeave * :call ShowCursor()
au WinEnter * :call HideCursor()


" ------------------------------------------------
"     GUI settings
" ------------------------------------------------

" Hide MacVim toolbar and scrollbars.
set guioptions-=T
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L


" ------------------------------------------------
"     Plugin settings
" ------------------------------------------------

let NERDTreeShowLineNumbers=0

let g:tagbar_ctags_bin='/usr/local/bin/ctags'

" Default to latex keywords for *.tex files
let g:tex_flavor='latex'

" Disable autofolding of latex
let g:Tex_AutoFolding = 0

" Close ack quickfix buffer when you open a file from it
let g:ack_autoclose=1 

let g:ctrlp_use_caching = 0
let g:ctrlp_max_files=20000

if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

" Don't update git line diffs while typing
let g:gitgutter_realtime = 0
let g:gitgutter_escape_grep = 1

" Goyo
let g:goyo_margin_top = 0
let g:goyo_margin_bottom = 0
function! s:goyo_enter()
  set nocursorline
endfunction

function! s:goyo_leave()
endfunction

autocmd! User GoyoEnter
autocmd! User GoyoLeave
autocmd  User GoyoEnter nested call <SID>goyo_enter()
autocmd  User GoyoLeave nested call <SID>goyo_leave()

" Tell numbers.vim to ignore plugin buffers
"let g:numbers_exclude = ['unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m', 'nerdtree']

" Asynchronously update ctags
"let g:easytags_async=1
" Faster but less accurate syntax highlighting of ctags
"let g:easytags_syntax_keyword = 'always'

" ------------------------------------------------
"     Miscellaneous Vim Settings
" ------------------------------------------------

" Assume terminal is fast for smoothness
set ttyfast

" No auditory bells
set visualbell

" Don't check the file we're editing for vim settings
set modelines=0

" Enable syntax-folding
set foldmethod=syntax
" but unfold by default.
set foldlevel=99

" Ctrl-V mode edits blocks regardless of underlying text
set virtualedit=block

" Keep buffers loaded when they are abandoned
" (careful with this one if you tend to open many windows per project)
set hidden

" Tab completion in command mode
set wildmenu
set wildmode=list:longest

" Allow backspacing over autoindents, end of lines, and start of lines
set backspace=indent,eol,start

" Persist undo history for all files in ~/.vim/undo
set undofile
set undodir=$HOME/.vim/undo

" Show matching bracket when a bracket is highlighted
set showmatch

" Blink for 0.2 seconds when highlighting a bracket
set mat=2

" Terminal-specific settings
if !has("gui_running")
  let g:hybrid_use_iTerm_colors = 1
  set t_Co=256
  let g:hybrid_use_Xresources = 0
  syntax enable
  set background=dark
  "set nocursorline        " Don't paint cursor line
  "set nocursorcolumn      " Don't paint cursor column
  "set lazyredraw          " Wait to redraw
  set ttimeout
  set ttimeoutlen=250
  set notimeout
endif

" ------------------------------------------------
"     Keybindings : Essential
" ------------------------------------------------

" Map , to <Leader>
let mapleader = ","
" and \\ to <LocalLeader>
let maplocalleader = "\\"

" Use j and k to navigate wrapped screen-lines, not actual file lines
nnoremap j gj
nnoremap k gk

" Remap VIM 0 to first non-blank character
map 0 ^

" ------------------------------------------------
"     Keybindings : Windows and Tabs
" ------------------------------------------------

" Move between windows with <C-hjkl> and <C-Tab>
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <C-Tab> <C-W>w

" Meta+1-0 jumps to tab 1-10, Shift+Meta+1-0 jumps to tab 11-20:
let s:windowmapnr = 0
let s:wins='1234567890!@#$%^&*()'
while (s:windowmapnr < strlen(s:wins))
    exe 'noremap <silent> <D-' . s:wins[s:windowmapnr] . '> ' . (s:windowmapnr + 1) . 'gt'
    exe 'inoremap <silent> <D-' . s:wins[s:windowmapnr] . '> <C-O>' . (s:windowmapnr + 1) . 'gt'
    exe 'cnoremap <silent> <D-' . s:wins[s:windowmapnr] . '> <C-C>' . (s:windowmapnr + 1) . 'gt'
    exe 'vnoremap <silent> <D-' . s:wins[s:windowmapnr] . '> <C-C>' . (s:windowmapnr + 1) . 'gt'
    let s:windowmapnr += 1
endwhile
unlet s:windowmapnr s:wins

" ------------------------------------------------
"     Keybindings : Toggles
" ------------------------------------------------

" Disable search highlighting with <Leader><Space>
nnoremap <leader><space> :noh<cr>

" NERDtree hotkeys:
"   <Leader>d opens NERDtree temporarily (closes when done)
"   <Leader>D opens NERDtree permanently
nnoremap <Leader>d :let NERDTreeQuitOnOpen = 1<bar>NERDTreeToggle<CR>
nnoremap <Leader>D :let NERDTreeQuitOnOpen = 0<bar>NERDTreeToggle<CR>

" Toggle relative line numbers with <Leader>n
function! NumberToggle()
  if(&relativenumber == 1)
    set number
    set norelativenumber
  else
    set relativenumber
  endif
endfunc
nnoremap <leader>n :call NumberToggle()<cr>

" Toggle spellcheck with <Leader>s
nnoremap <Leader>s :setlocal spell! spelllang=en_us<CR>

" ------------------------------------------------
"     Keybindings : Miscellaneous
" ------------------------------------------------

" Move lines up and down with alt-j and alt-k
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" Begin ctag search with <leader>t
nnoremap <leader>t :tag 

" Map ,, in insert mode to paste from default register.
imap ,, <C-r>0

" Jump between matching delimiters (brackets, comments, etc) with <tab>
nnoremap <tab> %
vnoremap <tab> %

" Map ,v to reselect text that was just pasted.
nnoremap <leader>v V`]

" Use F13 (my real escape key) for word completion
imap <F13> <C-n>

" Delete a buffer without closing the window with <C-q>
nmap <C-q> :bprevious \| bdelete #<cr>

" Command-R in visual mode to search and replace selected text
vnoremap <D-r> "hy:%s/<C-r>h//<left>

" <leader>g toggles Goyo's zen mode
nnoremap <Leader>g :Goyo<CR>

" Save session with ,n
nnoremap <leader>n :mksession ~/.vim/session/

" Set filetype to markdown with ,m
nnoremap <leader>m :set filetype=markdown<CR>

" Toggle tagbar
"nmap <leader>b :TagbarToggle<CR>

" Tabularize when writing tables with |'s
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
 
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" ------------------------------------------------
"     Colorscheme and Fonts
" ------------------------------------------------

" Use Powerline font
set guifont=Menlo\ for\ Powerline:h13
" ...or the regular Menlo
"set guifont=Menlo:h12
" Default to 5px of space in between lines
set linespace=6


" Use Powerline font characters for airline.vim
let g:airline_powerline_fonts=1
" Airline theme
let g:airline_theme='base16'

" Adjust Airline's section hiding
let g:airline#extensions#default#section_truncate_width = {
      \ 'y': 88,
      \ }
" Turn off warnings
let g:airline_section_warning = ''

" Colorschemes

" OCEAN
"colorscheme base16-ocean
"set background=dark
" SOLARIZED LIGHT
"colorscheme solarized
"set background=light
" TOMORROW LIGHT
"colorscheme Tomorrow
"set background=light
" HYBRID
colorscheme hybrid
set background=dark
