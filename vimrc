
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2017 Sep 20
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" Settings from Haskell Vim guide
" (http://www.stephendiehl.com/posts/vim_2016.html)
syntax on
filetype plugin indent on

set nocompatible
set number
set nowrap
set showmode
set tw=80
set smartcase
set smarttab
set smartindent
set autoindent
set softtabstop=2
set shiftwidth=2
set expandtab
set incsearch
set mouse=a
set history=1000
set clipboard=unnamedplus,autoselect

set completeopt=menuone,menu,longest

set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
set wildmode=longest,list,full
set wildmenu
set completeopt+=longest

set t_Co=256

set cmdheight=1

" My custom options

" Leader
let mapleader = ","

" Update time
set updatetime=250

" Turn on numbers and toggle them
" set nu
nmap <leader>nu :set nu!<cr>

" Use filetype plugin
" filetype plugin on
 
" Make alt key work
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

set timeout ttimeoutlen=50

" Quickfix window
nnoremap <leader>q :copen<cr>
nnoremap <leader>qw :ccl<cr>

" Copy/paste to/from clipboard
vmap <c-c> y:call system("xclip -i -selection clipboard", getreg("\""))<cr>:call system("xclip -i", getreg("\""))<cr>
nmap <c-m-v> :call setreg("\"",system("xclip -o -selection clipboard"))<cr>p")")")"))

" Turn on spellcheck
map <F6> :set spell! spelllang=en_us<cr>

" Bad spelling in red
hi SpellBad ctermfg=Red

" Turn off search highlight
map <F7> :noh<cr>

" Lightline
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }
set noshowmode

" Yankstack
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

" Ctrl-j/k deletes blank line below/above, and Alt-j/k inserts.
nnoremap <silent><c-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><c-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><a-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><a-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" Syntastic
" map <Leader>s :SyntasticToggleMode<CR>
" 
set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" 
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" 
" Fugitive
set statusline+=%{fugitive#statusline()}

" Tabs
map <leader><leader>tn :tabnew<cr>
map <leader><leader>to :tabonly<cr>
map <leader><leader>tc :tabclose<cr>
map <leader><leader>tm :tabmove 

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader><leader>te :tabedit <c-r>=expand("%:p:h")<cr>

" Use ag with ack.vim
let g:ackprg = 'ag --nogroup --nocolor --column'

" Ctrlp fuzzy file finder
nmap <leader><leader>o :CtrlP<cr>

" Open nerdtree
map <leader>o :NERDTreeToggle<CR>

" Use deoplete
let g:deoplete#enable_at_startup = 1

" Tabularize
let g:haskell_tabular = 1

"" Haskell
map <leader>a= :Tabularize /=<CR>
map <leader>a; :Tabularize /::<CR>
map <leader>a- :Tabularize /-><CR>
"" Align first non-whitespace after semicolon
map <leader>a: :Tabularize /:\zs<CR>

" ghc-mod
map <silent> <leader>gw :GhcModTypeInsert<CR>
map <silent> <leader>gs :GhcModSplitFunCase<CR>
map <silent> <leader>gq :GhcModType<CR>
map <silent> <leader>ge :GhcModTypeClear<CR>
"" Auto check and lint
map <F4> :GhcModCheck<cr>
map <F5> :GhcModLint<cr>

" supertab
let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

if has("gui_running")
  imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
else " no gui
  if has("unix")
    inoremap <Nul> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
  endif
endif

" Disable omni-completion
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" Ale
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'haskell': ['brittany'],
\}

map <leader>f :ALEFix<cr>

"" Always have gutter open
let g:ale_sign_column_always = 1

"" Highights
let g:ale_set_highlights = 0
highlight ALEWarning ctermfg=Red

""Quickfix
" Write this in your vimrc file
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 1

"" Lightline  status
let g:lightline.component_expand = {
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \ }

let g:lightline.active = { 'right': [
      \              [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype'],
      \              ['linter_errors', 'linter_warnings', 'linter_ok' ]] }

" Hoogle
map <leader>h :Hoogle 
