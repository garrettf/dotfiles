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
  "Plug 'bling/vim-airline'
  "Plug 'itchyny/lightline.vim'

  " Fuzzy search for directories, buffers, and MRU
  "Plug 'kien/ctrlp.vim'
  " 'faster' matching algorithm
  Plug 'JazzCore/ctrlp-cmatcher'
  Plug 'nixprime/cpsm'
  Plug 'kassio/neoterm'

  Plug 'ap/vim-buftabline'
  Plug 'chrismccord/bclose.vim'

  Plug 'idbrii/vim-tagimposter'

  " Smart tab completion with <Tab>
  if !exists('veonim')
    Plug 'ervandew/supertab'
  end

  " Directory navigation window.
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

  " Use ag from vim with :Ag
  Plug 'rking/ag.vim', { 'on': 'Ag' }

  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'

  " Mappings to change surrounding delimiters
  "   https://github.com/tpope/vim-surround
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-eunuch'

  " Git diff indicators next to line numbers
  Plug 'airblade/vim-gitgutter'

  " Auto-insert endifs and other block constructs
  Plug 'tpope/vim-endwise'

  " Asynchronous linting
  Plug 'w0rp/ale'

  " Zen mode for distraction-free writing
  Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }

  "Plug 'majutsushi/tagbar'
  Plug 'terryma/vim-expand-region'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'triglav/vim-visual-increment'
  Plug 'vimwiki/vimwiki'

  Plug 'qpkorr/vim-bufkill'

  "Plug 'AndrewRadev/splitjoin.vim'
  Plug 'FooSoft/vim-argwrap'

  " FUTURE GARRETT: replace with 'garrettf/fzf-tags' fork
  Plug 'zackhsi/fzf-tags'
  Plug 'joshdick/onedark.vim'
  Plug 'drewtempelmeyer/palenight.vim'

  Plug 'kana/vim-submode'

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

  "Plug 'vim-scripts/swap-parameters'

  " ----------------------------------------------
  "     Language-specific Plugins
  " ----------------------------------------------
  Plug 'kchmck/vim-coffee-script'
  Plug 'fatih/vim-go'
  Plug 'derekwyatt/vim-scala'
  Plug 'rodjek/vim-puppet'
  Plug 'elixir-editors/vim-elixir'
  
  " Embedded Coffeescript
  Plug 'AndrewRadev/vim-eco'

  " Syntax highlighting for Apache Thrift
  Plug 'solarnz/thrift.vim'

  "Plug 'kern/vim-es7'
  Plug 'pangloss/vim-javascript'
  let g:javascript_plugin_flow = 1

  "Plug 'othree/yajs.vim'
  Plug 'mxw/vim-jsx'
  let g:jsx_ext_required = 0

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

" When joining lines via J, only add one space after punctuation instead of two
set nojoinspaces

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

" This makes opening Ruby files much faster
let g:ruby_path = []

let g:ale_linters = {
\   'ruby': ['rubocop'],
\   'javascript': ['flow', 'prettier', 'eslint'],
\   'jsx': ['flow', 'prettier', 'eslint'],
\}

let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'jsx': ['prettier'],
\}
" Only lint on open/save
let g:ale_lint_on_text_changed = 'never'
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_ruby_rubocop_executable = 'bundle'

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
autocmd FileType c,cpp,java,php,ruby,eruby,python,perl,rb,html,haml,yaml,sql,js,javascript,javascript.jsx autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespace()

autocmd FileType ruby
  \ setlocal iskeyword+=! |
  \ setlocal iskeyword+=?

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

" Give every window NO status line
set laststatus=0
" ^                 a status line
" set laststatus=2

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

" TODO switch to fzf.vim or ack.vim
let g:ag_prg="rg --vimgrep -g '!openapi'"
let g:ag_autoclose=1
let g:ag_qhandler="belowright copen 15"

let g:ctrlp_use_caching = 1
let g:ctrlp_max_files=20000
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:10'

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'cd %s && ag -l --nocolor --ignore thrift'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif
" ripgrep instead?
let g:ctrlp_user_command = 'cd %s && rg -g "!thrift" --files-with-matches ".*"'

"let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}

" "foo bar" becomes "barfoo" when using ctrlP
let g:cpsm_query_inverting_delimiter = ' '

" Don't update git line diffs while typing
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
let g:gitgutter_escape_grep = 1

" rhubarb config
let g:github_enterprise_urls = ['https://git.corp.stripe.com']

" Goyo
let g:goyo_margin_top = 0
let g:goyo_margin_bottom = 0
let g:goyo_height = 100
function! s:goyo_enter()
  set nocursorline
  set showtabline=0
endfunction

function! s:goyo_leave()
  set showtabline=2
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
if has('nvim')
  " Window navigation function
  " Make ctrl-h/j/k/l move between windows and auto-insert in terminals
  func! s:mapMoveToWindowInDirection(direction)
      func! s:maybeInsertMode(direction)
          stopinsert
          execute "wincmd" a:direction

          if &buftype == 'terminal'
              startinsert!
          endif
      endfunc

      execute "tnoremap" "<silent>" "<C-" . a:direction . ">"
                  \ "<C-\\><C-n>"
                  \ ":call <SID>maybeInsertMode(\"" . a:direction . "\")<CR>"
      execute "nnoremap" "<silent>" "<C-" . a:direction . ">"
                  \ ":call <SID>maybeInsertMode(\"" . a:direction . "\")<CR>"
  endfunc
  for dir in ["h", "j", "l", "k"]
      call s:mapMoveToWindowInDirection(dir)
  endfor
else
  map <C-j> <C-W>j
  map <C-k> <C-W>k
  map <C-h> <C-W>h
  map <C-l> <C-W>l
  map <C-Tab> <C-W>w

  " window nav from terminal via ctrl keys (probably a bad idea)
  tnoremap <C-h> <C-w>h
  tnoremap <C-j> <C-w>j
  tnoremap <C-k> <C-w>k
  tnoremap <C-l> <C-w>l
end

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
" nnoremap <D-]> <C-w>]<C-w>T

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
nnoremap <leader>t :Tag 

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

" Save (keep) session with ,k
nnoremap <leader>k :mksession ~/.vim/session/

function! Notemode()
  colorscheme solarized8_light
  set filetype=markdown
endfunc
nnoremap <leader>m :call Notemode()<cr>

" Do my hacky markdown mail dance with ,a
nnoremap <leader>a :set filetype=markdown<CR>:set cc=73<CR>:set tw=72<CR>

" <leader>c to copy current filename to clipboard
nnoremap <leader>c :let @+ = expand("%")<CR>
" include line number in visual mode
vnoremap <leader>c :<BS><BS><BS><BS><BS>let @+ = expand("%") . " -l " . line(".")<CR>


" Wrap/unwrap arguments onto multiple lines
nnoremap <silent> <leader>w :ArgWrap<CR>
let g:argwrap_tail_comma = 1

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

" I never mean to use :E
cabbrev E e

" repeat last : command with <Alt-.>
nnoremap ≥ :@:<CR>

" Use Shift-k (Command-k to create a new tab) to Ag for the current word
nnoremap K :Ag! "<cword>"<CR>
vnoremap K "py:Ag! "<C-R>p"<CR>
" nnoremap <D-k> eb"pye:tabnew<CR>:Ag! "<C-R>p"<CR>
" vnoremap <D-k> "py:tabnew<CR>:Ag! "<C-R>p"<CR>

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

" ------------------------------------------------
"     Colorscheme and Fonts
" ------------------------------------------------
if has("gui_vimr")
  set termguicolors
endif

" Use Powerline font
"set guifont=Menlo\ for\ Powerline:h13
" ...or the regular Menlo
"set guifont=Menlo:h12
if has("gui_running")
  set guifont=Fira\ Mono:h15
  " set guifont=Fira\ Mono\ for\ Powerline:h13
  "set guifont=Fira\ Code:h13
  "set linespace=2
  "set guifont=Menlo:h13
  set linespace=3
endif

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif


let g:splitjoin_split_mapping = ''
nmap gK :SplitjoinSplit<cr>
let g:splitjoin_trailing_comma = 1

"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#buffer_nr_show = 1
"
"func! Buflisted()
"  return filter(range(1, bufnr('$')), 'buflisted(v:val)')
"endfunc
"
"set hidden
"nnoremap <leader>bk :BW<CR>
"
"func! Key_leader_bufnum(num)
"    let l:buffers = Buflisted()
"    let l:input = a:num . ""
"
"    while 1
"
"        let l:cnt = 0
"        let l:i=0
"        " count matches
"        while l:i<len(l:buffers)
"            let l:bn = l:buffers[l:i] . ""
"            if l:input==l:bn[0:len(l:input)-1]
"                let l:cnt+=1
"            endif
"            let l:i+=1
"        endwhile
"
"        " no matches
"        if l:cnt==0 && len(l:input)>0
"            echo "no buffer [" . l:input . "]"
"            return ''
"        elseif l:cnt==1
"            return ":b " . l:input . "\<CR>"
"        endif
"
"        echo ":b " . l:input
"
"        let l:n = getchar()
"
"        if l:n==char2nr("\<BS>") ||  l:n==char2nr("\<C-h>")
"            " delete one word
"            if len(l:input)>=2
"                let l:input = l:input[0:len(l:input)-2]
"            else
"                let l:input = ""
"            endif
"        elseif l:n==char2nr("\<CR>") || (l:n<char2nr('0') || l:n>char2nr('9'))
"            return ":b " . l:input . "\<CR>"
"        else
"            let l:input = l:input . nr2char(l:n)
"        endif
"
"        let g:n = l:n
"
"    endwhile
"endfunc
"nnoremap <expr> <Leader>1 Key_leader_bufnum(1)
"nnoremap <expr> <Leader>2 Key_leader_bufnum(2)
"nnoremap <expr> <Leader>3 Key_leader_bufnum(3)
"nnoremap <expr> <Leader>4 Key_leader_bufnum(4)
"nnoremap <expr> <Leader>5 Key_leader_bufnum(5)
"nnoremap <expr> <Leader>6 Key_leader_bufnum(6)
"nnoremap <expr> <Leader>7 Key_leader_bufnum(7)
"nnoremap <expr> <Leader>8 Key_leader_bufnum(8)
"nnoremap <expr> <Leader>9 Key_leader_bufnum(9)



" Colorschemes
let g:enable_bold_font = 0

" OCEAN
"colorscheme base16-ocean
"set background=dark

" SOLARIZED LIGHT
"colorscheme solarized8_light_low
"let g:solarized_term_italics = 1

" TOMORROW LIGHT
"colorscheme Tomorrow
"set background=light
" HYBRID
"colorscheme hybrid_material
"colorscheme material-theme

" MATERIAL
" set background=dark
"colorscheme onedark
if has('gui_running')
  "colorscheme material_edit
  "colorscheme onedark
  "let g:palenight_terminal_italics=1
  "colorscheme palenight
elseif exists('veonim')
  "colorscheme material_edit
else
  "colorscheme onedark
end

let g:palenight_terminal_italics=1
colorscheme palenight
let colors = palenight#GetColors()
call g:palenight#set_highlight("BufTabLineCurrent", {"fg": colors.black, "bg": colors.blue})
call g:palenight#set_highlight("BufTabLineActive", {"fg": colors.white})
call g:palenight#set_highlight("BufTabLineHidden", {"fg": colors.comment_grey})
call g:palenight#set_highlight("BufTabLineFill", {})

" Terminal-specific settings
if !has("gui_running") && !has("gui_vimr") && !exists("g:gui_oni")
  "colorscheme hybrid_material
  let g:hybrid_use_iTerm_colors = 1
  set t_Co=256
  let g:hybrid_use_Xresources = 0
  syntax enable
  set background=dark
  "set nocursorline        " Don't paint cursor line
  "set nocursorcolumn      " Don't paint cursor column
  "set lazyredraw          " Wait to redraw
  set ttimeout
  " disable escape delay
  set ttimeoutlen=0
  set notimeout
  " no visual bell
  set noerrorbells visualbell t_vb=
endif

function! ResizeFontAndWindow(dy)
  let l:fontsize = matchstr(&guifont, '\d\+$')

  let l:curheight = l:fontsize * &lines
  let l:curwidth = l:fontsize * (6.0/5.0) * &columns

  let l:newfontheight = l:fontsize+a:dy
  let l:newfontwidth = l:newfontheight * (6.0/5.0)

  let &guifont = substitute(&guifont, '\d\+$', l:newfontheight, '')

  let l:approxlines = curheight * 1.0 / newfontheight
  let l:approxcolumns = curwidth / newfontwidth

  if a:dy > 0
    let l:approxlines = ceil(l:approxlines)
    let l:approxcolumns = ceil(l:approxcolumns)
  else
    let l:approxlines = floor(l:approxlines)
    let l:approxcolumns = floor(l:approxcolumns)
  endif

  let &lines = float2nr(l:approxlines)
  let &columns = float2nr(l:approxcolumns)
endfunction

function! IncrementFont()
  call ResizeFontAndWindow(1)
endfunction

function! DecrementFont()
  call ResizeFontAndWindow(-1)
endfunction

map <D-=> :call IncrementFont()<cr>
map <D--> :call DecrementFont()<cr>

if has('nvim')
  tnoremap <esc> <C-\><C-N>
else
  " terminal clipboard paste via ctrl-V
  tnoremap <C-v> <C-w>"+

  " terminal normal mode via ctrl-N
  tnoremap <C-n> <C-w>N
  " terminal normal mode via esc
  tnoremap <esc> <C-w>N
  " terminal normal mode via cmd-w
  tnoremap <D-w> <C-w>N

  " window nav from terminal via command keys
  tnoremap <D-h> <C-w>h
  tnoremap <D-j> <C-w>j
  tnoremap <D-k> <C-w>k
  tnoremap <D-l> <C-w>l
endif

inoremap P:: Private::
inoremap PM:: Private::Model::
inoremap OPF:: Opus::PaymentFlows::
inoremap PMI:: Private::Model::PaymentIntent
inoremap PIS:: Private::Model::PaymentIntentSnapshot

let g:bclose_multiple = 0
nnoremap <silent> <D-d> :Bclose<cr>
if has('nvim')
  tnoremap <D-d> <C-\><C-N>:b#\|bd! #<cr>
else
  tnoremap <D-d> <c-w>:b#\|bd! #<cr>
endif

nnoremap <D-[> :bp!<cr>
nnoremap <D-]> :bn!<cr>
nnoremap <C-tab> :bn!<cr>
nnoremap <C-S-Tab> :bp!<cr>

if has('nvim')
  tnoremap <D-[> <c-\><c-N>:bp<cr>
  tnoremap <D-]> <c-\><c-N>:bn<cr>
else 
  tnoremap <D-[> <c-w>:bp!<cr>
  tnoremap <D-]> <c-w>:bn!<cr>
  tnoremap <C-tab> :bn!<cr>
  tnoremap <C-S-Tab> :bp!<cr>
endif

nnoremap <D-up> <c-w>+
nnoremap <D-down> <c-w>-
nnoremap <D-left> <c-w><
nnoremap <D-right> <c-w>>

if has('nvim')
  tnoremap <D-up> <c-\><c-N><c-w>+i
  tnoremap <D-down> <c-\><c-N><c-w>-i
  tnoremap <D-left> <c-\><c-N><c-w><i
  tnoremap <D-right> <c-\><c-N><c-w>>i
else
  tnoremap <D-up> <c-w>+
  tnoremap <D-down> <c-w>-
  tnoremap <D-left> <c-w><
  tnoremap <D-right> <c-w>>
endif

let g:buftabline_numbers=2
nmap <D-1> <Plug>BufTabLine.Go(1)
nmap <D-2> <Plug>BufTabLine.Go(2)
nmap <D-3> <Plug>BufTabLine.Go(3)
nmap <D-4> <Plug>BufTabLine.Go(4)
nmap <D-5> <Plug>BufTabLine.Go(5)
nmap <D-6> <Plug>BufTabLine.Go(6)
nmap <D-7> <Plug>BufTabLine.Go(7)
nmap <D-8> <Plug>BufTabLine.Go(8)
nmap <D-9> <Plug>BufTabLine.Go(9)
nmap <D-0> <Plug>BufTabLine.Go(10)

tmap <D-1> <c-w>:bn! \| execute "normal \<Plug>BufTabLine.Go(1)"<cr>
tmap <D-2> <c-w>:bn! \| execute "normal \<Plug>BufTabLine.Go(2)"<cr>
tmap <D-3> <c-w>:bn! \| execute "normal \<Plug>BufTabLine.Go(3)"<cr>
tmap <D-4> <c-w>:bn! \| execute "normal \<Plug>BufTabLine.Go(4)"<cr>
tmap <D-5> <c-w>:bn! \| execute "normal \<Plug>BufTabLine.Go(5)"<cr>
tmap <D-6> <c-w>:bn! \| execute "normal \<Plug>BufTabLine.Go(6)"<cr>
tmap <D-7> <c-w>:bn! \| execute "normal \<Plug>BufTabLine.Go(7)"<cr>
tmap <D-8> <c-w>:bn! \| execute "normal \<Plug>BufTabLine.Go(8)"<cr>
tmap <D-9> <c-w>:bn! \| execute "normal \<Plug>BufTabLine.Go(9)"<cr>
tmap <D-0> <c-w>:bn! \| execute "normal \<Plug>BufTabLine.Go(10)"<cr>

"if has('nvim')
  nnoremap <D-e> :Topen<cr>
  vnoremap <leader>r :<c-U>execute ":T pt" expand('%') "-l" line(".")<cr>
  nnoremap <leader>r :execute ":T pt" expand('%')<cr>
  vnoremap <D-r> :<c-U>execute ":T pt" expand('%') "-l" line(".")<cr>
  nnoremap <D-r> :execute ":T pt" expand('%')<cr>
"else
  " include line number in visual mode
"  nnoremap <leader>r :T pt % .<cr>
  "nnoremap <leader>r :call term_sendkeys("zsh", "pt " . expand("%") . "\<lt>cr>")<cr><esc>
"end

" set nohidden
" when set to "delete", this makes buffers disappear by default
" when set to "hide", this makes them stay open in the background (and on the
" tab bar) -- use <D-d> if you want to navigate away AND delete the buffer
"set bufhidden=hide
set nohidden

if has('gui_macvim') || exists('veonim')
  unmenu File.New\ Tab
  nmap <silent> <D-t> :setlocal bufhidden=hide<cr>:enew<cr>
  tmap <silent> <D-t> <c-w>:enew<cr>
  " comment this if you want to keep all windows
  autocmd BufReadPost * set bufhidden=delete
  " always keep a buffer when we write to it
  autocmd BufWritePost * setlocal bufhidden=hide

  nmap <silent> <D-k> :setlocal bufhidden=hide<cr>

  au BufWinEnter * if &buftype == 'terminal' | setlocal bufhidden=hide | endif
  if has('nvim') 
    au TermOpen * setlocal nonumber | setlocal bufhidden=hide
  else
    au TerminalOpen * setlocal nonumber | setlocal bufhidden=hide
  end

  " see ~/.gvimrc
  " ported from menu.vim
  nnoremap <D-v> "+gP
  cnoremap <D-v> <C-R>+
  exe 'vnoremap <script> <D-v> ' . paste#paste_cmd['v']
  exe 'inoremap <script> <D-v> ' . paste#paste_cmd['i']
  tmap <D-v> <c-w>"+

  unmenu Tools.List\ Errors
  nmap <silent> <D-l> :setlocal bufhidden="delete"<cr>

  unmenu File.Print
  nnoremap <silent> <D-p> :Buffer<cr>

  " command-K to clear
  tmap <D-k> <C-c>clear<cr> 

  " ,p to search for paths
  " TODO: figure out how to escape this
  "nmap <leader>p :?[A-Za-z_./]\+\.[A-Za-z]\+<cr>
  "tmap <leader>p <C-w><esc>:?[A-Za-z_./]\+\.[A-Za-z]\+<cr>

  autocmd VimResized * redraw!
  autocmd FocusLost * redraw!
endif

" for fugitive.vim :Gstatus and :Gcommit
set previewheight=20

" fzf.vim
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column -g "!thrift" --line-number --no-heading --color=never '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

function! s:goto_tag_sink(line)
  let parts = split(a:line, '\t')
  let filename = parts[1]
  echom filename
  let excmd = parts[2]
  echom excmd
  call tagimposter#pushtag(expand("<cword>"))
  execute 'silent e ' . filename . ' | ' . excmd
endfunction

function! s:extract_name(line)
  let parts = split(a:line, '\t')
  let class_parts = split(parts[0], ' ')
  let name_with_period = class_parts[1]
  let name = name_with_period[:-2]
  return name
endfunction


function! s:extract_symbol(line)
  let parts = split(a:line, '\t')
  let name_with_period = parts[0]
  let name = name_with_period[:-2]
  return name
endfunction

function! s:insert_tag_sink(line)
  execute ':normal! a' . s:extract_name(a:line)
endfunction

function! s:insert_symbol_sink(line)
  execute ':normal! a' . s:extract_symbol(a:line)
endfunction

function! s:insert_terminal_tag_sink(line)
  call term_sendkeys('', s:extract_name(a:line))
endfunction

let symbols_file = 'symbols'

command! -bar Symbols call fzf#run({
      \ 'source': "awk -F'\\t' 'NR > 2 { if($2 !~ \"/?test/\") { gsub(\"class:\", \"\", $5); gsub(\"\\\\.\", \"::\", $5); if ($4 == \"f\") { delim = \"#\" } else if ($4 == \"F\") { delim = \".\" } else { delim = \"::\" } print \"\\033[0;33m\" $5 delim $1 \".\\t\\033[0;35m\" $2 \"\\t\" $3 } }' " . symbols_file,
      \ 'sink':    function('s:goto_tag_sink'),
      \ 'options': '--ansi --delimiter="\t" --nth=1',
      \ 'down': '40%'
\ })

command! -bar InsertSymbol call fzf#run({
      \ 'source': "awk -F'\\t' 'NR > 2 { if($2 !~ \"/?test/\") { gsub(\"class:\", \"\", $5); gsub(\"\\\\.\", \"::\", $5); if ($4 == \"f\") { delim = \"#\" } else if ($4 == \"F\") { delim = \".\" } else { delim = \"::\" } print \"\\033[0;33m\" $5 delim $1 \".\\t\\033[0;35m\" $2 \"\\t\" $3 } }' " . symbols_file,
      \ 'sink':    function('s:insert_symbol_sink'),
      \ 'options': '--ansi --delimiter="\t" --nth=1',
      \ 'down': '40%'
\ })

command! -bar Tags call fzf#run({
      \ 'source': "awk -F'\\t' '{if((($4 == \"c\") || ($4 == \"m\")) && ($2 !~ \"/?test/\")) { if($4 == \"m\") { gsub(\"class\", \"\\\e[0;32mmodule\", $5); } gsub(\":\", \" \", $5); gsub(\"\\\\.\", \"::\", $5); print \"\\\e[0;33m\" $5  \"::\" $1 \".\\t\e[0;35m\" $2 \"\\t\" $3 }}' " . join(tagfiles()),
      \ 'sink':    function('s:goto_tag_sink'),
      \ 'options': '--ansi --delimiter="\t" --nth=1',
      \ 'down': '40%'
\ })

command! -bar InsertTag call fzf#run({
      \ 'source': "awk -F'\\t' '{if((($4 == \"c\") || ($4 == \"m\")) && ($2 !~ \"/?test/\")) { if($4 == \"m\") { gsub(\"class\", \"\\\e[0;32mmodule\", $5); } gsub(\":\", \" \", $5); gsub(\"\\\\.\", \"::\", $5); print \"\\\e[0;33m\" $5  \"::\" $1 \".\\t\e[0;35m\" $2 \"\\t\" $3 }}' " . join(tagfiles()),
      \ 'sink':    function('s:insert_tag_sink'),
      \ 'options': '--ansi --delimiter="\t" --nth=1',
      \ 'down': '40%'
\ })


command! -bar InsertTagWithTest call fzf#run({
      \ 'source': "awk -F'\\t' '{if(($4 == \"c\") || ($4 == \"m\")) { if($4 == \"m\") { gsub(\"class\", \"\\\e[0;32mmodule\", $5); } gsub(\":\", \" \", $5); gsub(\"\\\\.\", \"::\", $5); print \"\\\e[0;33m\" $5  \"::\" $1 \".\\t\e[0;35m\" $2 \"\\t\" $3 }}' " . join(tagfiles()),
      \ 'sink':    function('s:insert_tag_sink'),
      \ 'options': '--ansi --delimiter="\t" --nth=1',
      \ 'down': '40%'
\ })

command! -bar InsertTerminalTag call fzf#run({
      \ 'source': "awk -F'\\t' '{if((($4 == \"c\") || ($4 == \"m\")) && ($2 !~ \"/?test/\")) { if($4 == \"m\") { gsub(\"class\", \"\\\e[0;32mmodule\", $5); } gsub(\":\", \" \", $5); gsub(\"\\\\.\", \"::\", $5); print \"\\\e[0;33m\" $5  \"::\" $1 \".\\t\e[0;35m\" $2 \"\\t\" $3 }}' " . join(tagfiles()),
      \ 'sink':    function('s:insert_terminal_tag_sink'),
      \ 'options': '--ansi --delimiter="\t" --nth=1',
      \ 'down': '40%'
\ })

command! -nargs=1 -complete=tag Tag call fzf_tags#Find(<q-args>)

" experiment: use fzf instead of ctrlp
nnoremap <c-p> :Files<cr>
nnoremap <d-P> :Tags<cr>
nnoremap <S-D-p> :Tags<cr>
nnoremap <d-e> :Symbols<cr>

"nnoremap <d-i> :InsertTag<cr>
nnoremap <d-i> <esc>:InsertSymbol<cr>
nnoremap <d-I> :InsertTagWithTest<cr>
"inoremap <d-i> <esc>:InsertTag<cr>
inoremap <d-i> <esc>:InsertSymbol<cr>
inoremap <d-I> <esc>:InsertTagWithTest<cr>
tnoremap <d-i> <c-w>:InsertTerminalTag<cr>

nnoremap <leader>fdm :set fdm=

" EXPERIMENT
" set scrolloff=99

nmap <C-]> <Plug>(fzf_tags)

call submode#enter_with('windowresizing', 'n', '', 'F')
call submode#leave_with('windowresizing', 'n', '', '<Esc>')
call submode#map('windowresizing', 'n', '', 'h', '<c-w><')
call submode#map('windowresizing', 'n', '', 'j', '<c-w>-')
call submode#map('windowresizing', 'n', '', 'k', '<c-w>+')
call submode#map('windowresizing', 'n', '', 'l', '<c-w>>')

call submode#map('windowresizing', 'n', '', 'H', '<c-w>11<')
call submode#map('windowresizing', 'n', '', 'J', '<c-w>5-')
call submode#map('windowresizing', 'n', '', 'K', '<c-w>5+')
call submode#map('windowresizing', 'n', '', 'L', '<c-w>10>')

" A-] to open tag in vsplit
nmap ‘ :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
