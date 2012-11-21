set nocompatible  " Use Vim settings, rather then Vi settings
set nobackup
set nowritebackup
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
filetype off
syntax off
runtime! autoload/pathogen.vim
if exists('g:loaded_pathogen')
  call pathogen#runtime_prepend_subdirectories(expand('~/.vim/bundle'))
endif

syntax on
filetype plugin indent on

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
syntax enable
filetype plugin indent on


augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab
set tabpagemax=30

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Local config
if filereadable(".vimrc.local")
  source .vimrc.local
endif

" Use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor
endif

let hr = str2nr(strftime('%H'))
:colorscheme eclipse
set t_Co=16
"let g:solarized_termcolors=16

" Numbers
set number
set numberwidth=5

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Cucumber navigation commands
autocmd User Rails Rnavcommand step features/step_definitions -glob=**/* -suffix=_steps.rb
autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes
" :Cuc my text (no quotes) -> runs cucumber scenarios containing "my text"
command! -nargs=+ Cuc :!ack --no-heading --no-break <q-args> | cut -d':' -f1,2 | xargs bundle exec cucumber --no-color

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Leader shortcuts for Rails commands
map <Leader>m :Rmodel 
map <Leader>c :Rcontroller 
map <Leader>v :Rview 
map <Leader>u :Runittest 
map <Leader>f :Rfunctionaltest 
map <Leader>tm :RTmodel 
map <Leader>tc :RTcontroller 
map <Leader>tv :RTview 
map <Leader>tu :RTunittest 
map <Leader>tf :RTfunctionaltest 
map <Leader>sm :RSmodel 
map <Leader>sc :RScontroller 
map <Leader>sv :RSview 
map <Leader>su :RSunittest 
map <Leader>sf :RSfunctionaltest 
"
" " Hide search highlighting
" map <Leader>h :set invhls <CR>
"
" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
"
" Opens a tab edit command with the path of the currently edited file filled
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>
"
" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
"
" " Duplicate a selection
" " Visual mode: D
" vmap D y'>p
"
" Press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap P p :call setreg('"', getreg('0')) <CR>
"
" For Haml
au! BufRead,BufNewFile *.haml         setfiletype haml
"

imap <C-L> <Space>=><Space>

 " Edit routes
command! Rroutes :e config/routes.rb
command! Rschema :e db/schema.rb

nmap <silent> <A-Up> :wincmd i<CR>
nmap <silent> <A-Down> :wincmd k<CR>
nmap <silent> <A-Left> :wincmd j<CR>
nmap <silent> <A-Right> :wincmd l<CR>
" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

