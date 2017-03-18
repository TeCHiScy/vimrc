source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
source $VIMRUNTIME/vimrc_nerdtree.vim  
behave mswin

set fileencodings=utf-8,gbk,gb2312

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set number
set history=1000                " Undo History = 1000
" set guifont=Consolas:h11

colorscheme tomorrow

if has("gui_running")
    au GUIEnter * simalt ~x     " Maximize STARTUP
    set guioptions-=m           " Hide Menu
    set guioptions-=T           " Hide Toolbar
    "set guioptions-=L          " Hide LEFT Scrollbar
    "set guioptions-=r          " Hide RIGHT Scrollbar
    "set guioptions-=b          " Hide Statusbar
    "set showtabline=0          " Hide Tabbar
endif

set writebackup
set cursorline
set autoindent
set nobackup                    " DONOT USE BACKUP
set noundofile                  " DONOT USE UNDO
set noswapfile                  " DONOT USE SWAP

" NERDTree Plugin  
let NERDTreeWinPos = "left"             " NERDTree Position
let NERDTreeWinSize = 31                " NERDTree Size
nmap <F2> <ESC>:NERDTreeToggle<RETURN>  " Toggle NERDTree
" autocmd VimEnter * NERDTree           " Open NERDTree STARTUP

" TagList Plugin
nmap <F3> :Tlist<RETURN>
let Tlist_Use_Right_Window = 1          " TagList Position

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h') . '/' : '%%'    " MAP %% -> Work Directory

" Latex Vim
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

