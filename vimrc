"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Necessary for cool features of vim
set nocompatible

" Enable syntax highlighting
syntax enable

" Mouse support only in normal mode
set mouse=n

" https://github.com/numirias/security
set nomodeline
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Vim-plug
" Automatic installaion of vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif
call plug#begin('~/.vim/plugged')

" Motions, objects, operators
Plug 'wellle/targets.vim'                                                       " Quotes, Separator, brace objects
Plug 'vim-scripts/visualrepeat'                                                 " Visual mode repeat
Plug 'tpope/vim-repeat'                                                         " Repeat random actions
Plug 'tpope/vim-commentary'                                                     " Toggle comments
Plug 'tpope/vim-surround'                                                       " Change surround
Plug 'tpope/vim-unimpaired'                                                     " [/] mappings for vim
" Plug 'justinmk/vim-sneak'                                                       " Sneak 's' motion and object
Plug 'vim-scripts/matchit.zip'                                                  " % works for more languages

Plug 'preservim/nerdtree'

" Buffers, Tags, QuickFix
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --key-bindings --completion' }
Plug 'junegunn/fzf.vim'                                                         " fuzzy searching
Plug 'vim-scripts/taglist.vim', { 'on': 'TlistToggle' }                         " Tag browser

" VCS Related
Plug 'tpope/vim-fugitive'                                                       " Best Git integration
Plug 'airblade/vim-gitgutter'                                                   " Gutter for vim

" Completions and compilations
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'tpope/vim-dispatch'                                                       " Async command exec in vim
Plug 'w0rp/ale'
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}


" Support for different filetypes
Plug 'sheerun/vim-polyglot'                                                     " Syntax highlighthing
Plug 'tpope/vim-apathy'                                                         " figure out import statements

" UI
Plug 'itchyny/lightline.vim'

" Experimental
" Plug 'Raimondi/delimitMate'                                                     " Close matching parens and ilk
Plug 'romainl/vim-cool'                                                         " Close hlsearch after complete

call plug#end()
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ => Plugins Specific
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ALE
"""""""""""""
nmap <silent> [w <Plug>(ale_previous_wrap)
nmap <silent> ]w <Plug>(ale_next_wrap)

let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'vue': ['eslint'],
\}

" Go
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <Leader>i <Plug>(go-info)

autocmd FileType go nmap <leader>c  :<C-u>GoDecls<C-r>
autocmd FileType go nmap <leader>c  :<C-u>GoDeclsDir<C-r>
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

let g:go_def_mode = 'godef'
let g:go_auto_sameids = 1
let g:go_decls_includes = "func,type"
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_deadline = "5s"

" Nerdtree
"""""""""""""
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-b> :NERDTreeFind<CR>

" FZF
"""""""""""""
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
let g:fzf_buffers_jump = 1
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)

command! -bang -nargs=? History
    \ call fzf#vim#history({'options': ['--layout=reverse', '--info=inline', '--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>)

nnoremap <silent> <C-p> :<C-u>Files<CR>
nnoremap <silent> <leader>\ :<C-u>History<CR>
nnoremap <silent> <Enter><Enter> :<C-u>History<CR>
nnoremap <silent> <leader>b :<C-u>Buffers<CR>
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 256 colors in vim
set t_Co=256

" Set the title of the terminal
set title

" Always show current position
set ruler

" This is the most awesome configurationa ever, is shows both
" the absolute and relative numbering together to make jumps
" easier
set number
" set relativenumber

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Mark the current line
set cursorline

" For the vimdow
set winwidth=84
set winheight=5
set winminheight=5
set winheight=999
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ => Search Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When searching try to be smart about cases
set smartcase
set ignorecase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Show matching brackets when text indicator is over them
set showmatch

" Taken from www.vi-improved.org/recommendations
if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ => Fold
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding is enabled by default
set foldenable

" Only very nested blocks will be folded
set foldlevelstart=2 " 99 means everything will open up

" The maximum nesting level
set foldnestmax=10

" Don't open folds on search
set fdo-=search
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ => Key bindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file

" The annoying jump over wrapped lines is removed
nnoremap j gj
nnoremap k gk

"mapping for the windows
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>so :so $MYVIMRC<CR>

" Exit
nnoremap <leader>q :q!<CR>

" In ex mode use <C-p> <C-n> for scroll
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" for spelling options when writing
" nnoremap <silent> <leader>s :set spell!<CR>
" set spelllang=en_gb

" after a search, this mapping removes the highlighing
nnoremap <silent> <leader>/ :nohlsearch<CR>
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

" saves the current file
nnoremap <silent> <leader>w :<C-u>w<CR>

" Paste from clipboard
nnoremap <leader>v :set paste<CR>"+p:set nopaste<CR>

" Get the count of a search string
nnoremap <leader>c <Esc>:%s///gn<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups, and completions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set utf8 as standard encoding and en_US as the standard language
set fileencoding=utf-8
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Set to auto read when a file is changed from the outside
set autoread

" Sets how many lines of history VIM has to remember and undolevels
set history=9999
set undolevels=9999

" No swaps, this is usually helpful in two cases:
" 1. Vim crashes before save                        - swap
" 2. You use two instances of vim on the same file  - swap
" 3. Protect against crash-during-write             - backups
" 4. Goback to previous version                     - git + undo

" set swapfile
" set directory^=~/.vim/swap//

" set writebackup
" set nobackup                                        " but do not persist backup after successful write
" set backupcopy=auto                                 " use rename-and-write-new method whenever safe
" set backupdir^=~/.vim/backup//

" If you use git + undo long enough, and have a durable laptop which doesn't
" explode, you can do without swaps and backups, otherwise read above
set noswapfile
set nowb
set nobackup

" Time travelling with vim
" All changes are automatically saved; All undos are logged, so we can always move
" back and forth between changes and files without worrying
set undofile
set undodir=~/.vim/undodir//
au FocusLost * silent! wa

" Enable filetype plugins
filetype on
filetype plugin on
filetype indent on

" Netrw setup
" This converts netrw to a poor man's project finder
let g:netrw_banner=0                                    " Don't show hideous banner
let g:netrw_altv=1                                      " Open splits to the right
let g:netrw_liststyle=3                                 " Tree view

" Useful to use :find as a fuzzy finder by recursing, but slows down 'gf'
" My advice would be to use a dedicated fuzzy finder instead
" set path+=**

" Use '*' for fuzzy search
set wildmenu

" Tab completion: mimics the behaviour of zsh
set wildmode=list:longest,full

" Adding omnicomplete
set ofu=syntaxcomplete#Complete

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.so,*.swp,*.zip,*/tmp/*
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ => Text, and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Be smart when using tabs ;)
set smarttab

" Migrated to editorconfig
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab "Converts tabs into space characters

" Textwrap at 120 haracters
set tw=120
set wrap

" Indentation
set autoindent "Auto indent
set smartindent "Smart indent
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ => Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Show editor mode
set showmode

" Height of the command bar
set cmdheight=1
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ => My precious
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remove trailing whitespace
" Taken from www.vi-improved.org/recommendations
nnoremap <Leader>fw :<C-U>call functions#stripwhitespace#StripTrailingWhitespace()<CR>

" Qargs populates args list with quickfix search list
" Taken from vim tips book
command! -nargs=0 -bar Qargs execute 'args' functions#qargs#QuickfixFilenames()

" Autorun Commands
"""""""""""""""""""
augroup configgroup
    autocmd!

    " Return to last edit position when opening files (You want this!)
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif

    " Additional Syntax Highlighting
    au BufEnter *.mrconfig set filetype=dosini
    au BufEnter *.git set filetype=dosini
    au BufEnter *.vcsh set filetype=dosini
    au BufEnter *.ts set filetype=typescript
    au BufEnter *.tsx set filetype=typescript
augroup END

" make list-like commands more intuitive
function! CCR()
    let cmdline = getcmdline()
    if cmdline =~ '\v\C^(ls|files|buffers)'
        " like :ls but prompts for a buffer command
        return "\<CR>:b"
    elseif cmdline =~ '\v\C/(#|nu|num|numb|numbe|number)$'
        " like :g//# but prompts for a command
        return "\<CR>:"
    elseif cmdline =~ '\v\C^(dli|il)'
        " like :dlist or :ilist but prompts for a count for :djump or :ijump
        return "\<CR>:" . cmdline[0] . "j  " . split(cmdline, " ")[1] . "\<S-Left>\<Left>"
    elseif cmdline =~ '\v\C^(cli|lli)'
        " like :clist or :llist but prompts for an error/location number
        return "\<CR>:sil " . repeat(cmdline[0], 2) . "\<Space>"
    elseif cmdline =~ '\C^old'
        " like :oldfiles but prompts for an old file to edit
        set nomore
        return "\<CR>:sil se more|e #<"
    elseif cmdline =~ '\C^changes'
        " like :changes but prompts for a change to jump to
        set nomore
        return "\<CR>:sil se more|norm! g;\<S-Left>"
    elseif cmdline =~ '\C^ju'
        " like :jumps but prompts for a position to jump to
        set nomore
        return "\<CR>:sil se more|norm! \<C-o>\<S-Left>"
    elseif cmdline =~ '\C^marks'
        " like :marks but prompts for a mark to jump to
        return "\<CR>:norm! `"
    elseif cmdline =~ '\C^undol'
        " like :undolist but prompts for a change to undo
        return "\<CR>:u "
    else
        return "\<CR>"
    endif
endfunction
cnoremap <expr> <CR> CCR()
"}}}

if has('vim_starting')
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[6 q"
    " ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_EI .= "\e[2 q"
    " 置換モード時に非点滅の下線タイプのカーソル
    let &t_SR .= "\e[4 q"
endif
