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
  " 'faster' matching algorithm
  Plug 'JazzCore/ctrlp-cmatcher'

  " Smart tab completion with <Tab>
  Plug 'ervandew/supertab'

  " Directory navigation window.
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

  " Use ag from vim with :Ag
  Plug 'rking/ag.vim', { 'on': 'Ag' }

  " Mappings to change surrounding delimiters
  "   https://github.com/tpope/vim-surround
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'

  " Git diff indicators next to line numbers
  Plug 'airblade/vim-gitgutter'

  " Auto-insert endifs and other block constructs
  Plug 'tpope/vim-endwise'

  " Zen mode for distraction-free writing
  Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }

  "Plug 'majutsushi/tagbar'
  Plug 'terryma/vim-expand-region'
  Plug 'tpope/vim-fugitive'
  Plug 'triglav/vim-visual-increment'
  Plug 'vimwiki/vimwiki'

  " Tool for lining up text
  "    https://github.com/godlygeek/tabular
  "Plug 'godlygeek/tabular'

  " Asynchronous and/or silent builds via external terminal or tmux
  "   Use :Start[!] or :Dispatch[!] or :Make
  "      https://github.com/tpope/vim-dispatch
  "Plug 'tpope/vim-dispatch'


  " Comment toggling
  "Plug 'tpope/vim-commentary'

  " Switches between relative and absolute line numbers based on mode
  " (disabled due to speed concerns)
  " Plug 'myusuf3/numbers.vim'

  " Automatic ctags generation and highlighting
  " (disabled due to speed concerns)
  "Plug 'xolox/vim-misc'
  "Plug 'xolox/vim-easytags'

  " Plain ctag highlighting
  "Plug 'abudden/taghighlight-automirror'

  Plug 'vim-scripts/swap-parameters'

  " ----------------------------------------------
  "     Language-specific Plugins
  " ----------------------------------------------
  Plug 'kchmck/vim-coffee-script'
  Plug 'fatih/vim-go'
  Plug 'derekwyatt/vim-scala'
  Plug 'rodjek/vim-puppet'

  " Embedded Coffeescript
  Plug 'AndrewRadev/vim-eco'

  " Automatic XML tag closing:
  "   http://www.vim.org/scripts/script.php?script_id=13
  "Plug 'closetag.vim', { 'for': 'html' }

  " Syntax highlighting and other tools for Processing
  "Plug 'willpragnell/vim-reprocessed'

  " Syntax highlighting for Jade templates
  "Plug 'digitaltoad/vim-jade'

  " For debugging syntax highlighting
  "Plug 'gerw/vim-HiLinkTrace'

  "Plug 'tpope/vim-rails'
  "Plug 'ngmy/vim-rubocop'
  "Plug 'Keithbsmiley/rspec.vim', { 'for': 'ruby' }
  "Plug 'leafo/moonscript-vim', { 'for': 'moon' }

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
autocmd FileType c,cpp,java,php,ruby,python,perl,rb,html,haml,yaml,sql autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespace()

" 4 spaces for java
autocmd FileType java
  \ setlocal shiftwidth=4 |
  \ setlocal tabstop=4 |
  \ setlocal softtabstop=4

autocmd FileType go
  \ setlocal shiftwidth=4 |
  \ setlocal tabstop=4 |
  \ setlocal softtabstop=4

autocmd FileType mail
  \ setlocal textwidth=72 |
  \ setlocal colorcolumn=72 |
  \ setlocal formatoptions=want

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

" Use console dialogs for prompts
set guioptions+=c

" ------------------------------------------------
"     Plugin settings
" ------------------------------------------------

let NERDTreeShowLineNumbers = 0
let NERDTreeIgnore = ['\.pyc$', '\.o$']

let g:tagbar_ctags_bin='/usr/local/bin/ctags'

" Default to latex keywords for *.tex files
let g:tex_flavor='latex'

" Disable autofolding of latex
let g:Tex_AutoFolding = 0

let g:ag_autoclose=1
let g:ag_qhandler="botright copen 15"

let g:ctrlp_use_caching = 1
let g:ctrlp_max_files=20000
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:10'

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }

" Don't update git line diffs while typing
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
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

" Tagbar settings for Golang
let g:tagbar_type_go = {
  \ 'ctagstype' : 'go',
  \ 'kinds'     : [
      \ 'p:package',
      \ 'i:imports:1',
      \ 'c:constants',
      \ 'v:variables',
      \ 't:types',
      \ 'n:interfaces',
      \ 'w:fields',
      \ 'e:embedded',
      \ 'm:methods',
      \ 'r:constructor',
      \ 'f:functions'
  \ ],
  \ 'sro' : '.',
  \ 'kind2scope' : {
      \ 't' : 'ctype',
      \ 'n' : 'ntype'
  \ },
  \ 'scope2kind' : {
      \ 'ctype' : 't',
      \ 'ntype' : 'n'
  \ },
  \ 'ctagsbin'  : 'gotags',
  \ 'ctagsargs' : '-sort -silent'
\ }

let wiki = {}
let wiki.path = '~/vimwiki/'
let wiki.nested_syntaxes = {'ruby': 'ruby', 'js': 'javascript', 'coffee': 'coffee'}
let g:vimwiki_list = [wiki]

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
"set foldmethod=syntax
"" but unfold by default.
"set foldlevel=99

" Ctrl-V mode edits blocks regardless of underlying text
set virtualedit=block

" Close buffers when they're abandoned
set nohidden

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

" Don't scan all included files for tab completion
set complete-=i

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

" Remap 0 to first non-blank character
map 0 ^

" Remap $ to stop before newlines in visual mode
vnoremap $ g_

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

" <D-]> to open tag under cursor in new tab
nnoremap <D-]> <C-w>]<C-w>T

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

" ,bd to insert binding.pry above
nnoremap <leader>bd Obinding.pry<Esc>

" <leader>c to copy current filename to clipboard
nnoremap <leader>c :let @+ = expand("%")<CR>
" include line number in visual mode
vnoremap <leader>c :<BS><BS><BS><BS><BS>let @+ = expand("%") . ":" . line(".")<CR>

" Open tag under cursor in new tab
nnoremap <leader>w <C-w><C-]><C-w>T

" Change filetype
nnoremap <leader>ft :set ft=

" Move splits left/right
"  - disabled because it conflicts with default navigation bindings
"nnoremap [ <C-w>3<
"nnoremap ] <C-w>3>

" Toggle tagbar
nmap <leader>b :TagbarToggle<CR>

" Open latest commit in GitHub
nmap <leader>gb :Gbrowse -<CR>
vmap <leader>gb :Gbrowse -<CR>

" Tabularize when writing tables with |'s
"function! s:align()
"  let p = '^\s*|\s.*\s|\s*$'
"  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
"    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
"    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
"    Tabularize/|/l1
"    normal! 0
"    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
"  endif
"endfunction
"inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

" Echo current syntax groups
"map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
"\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
"\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Never auto-jump to first result with :Ag
cabbrev Ag Ag!

" Use Shift-k (Command-k to create a new tab) to Ag for the current word
nnoremap K :Ag! "<cword>"<CR>
nnoremap <D-k> eb"pyw:tabnew<CR>:Ag! "<C-R>p"<CR>
vnoremap K "py:Ag! "<C-R>p"<CR>
vnoremap <D-k> "py:tabnew<CR>:Ag! "<C-R>p"<CR>

" Hide status bar with <C-y>
let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction
nnoremap <C-y> :call ToggleHiddenAll()<CR>

" insert date with ctrl-D, time with ctrl-T
inoremap <Plug>NoVimwikiDecreaseLvlSingleItem <Plug>VimwikiDecreaseLvlSingleItem
inoremap <Plug>NoVimwikiIncreaseLvlSingleItem <Plug>VimwikiIncreaseLvlSingleItem
inoremap <C-d> <esc>"=strftime("[%F]")<CR>pa
inoremap <C-t> <esc>"=strftime("[%F %T%z]")<CR>pa

let s:matchparen_enabled = 1
function! ToggleMatchParen()
  if s:matchparen_enabled == 1
    execute 'NoMatchParen'
    let s:matchparen_enabled = 0
  else
    execute 'DoMatchParen'
    let s:matchparen_enabled = 1
  endif
endfunction

" Toggle matching parenthesis syntax highlighting
nnoremap <leader>p :call ToggleMatchParen()<CR>

" ------------------------------------------------
"     Colorscheme and Fonts
" ------------------------------------------------

" Use Powerline font
"set guifont=Menlo\ for\ Powerline:h13
" ...or the regular Menlo
"set guifont=Menlo:h12
set guifont=Fira\ Mono\ for\ Powerline:h13

" Default to 4px of space in between lines
set linespace=4

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
let g:enable_bold_font = 0

" OCEAN
"colorscheme base16-ocean
"set background=dark
" SOLARIZED LIGHT
" colorscheme solarized
" set background=light
" TOMORROW LIGHT
"colorscheme Tomorrow
"set background=light
" HYBRID
set background=dark
"colorscheme hybrid_material
"colorscheme material-theme
colorscheme material_edit

" Terminal-specific settings
if !has("gui_running")
  colorscheme hybrid_material
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
