" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2015 Mar 24
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

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq


" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  autocmd InsertLeave * se cul  " highlight current line
  autocmd InsertEnter * se nocul    " highlight current line

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

if &term == "xterm-256color"
	set t_Co=256
endif

if &term == "screen"
	set t_Co=256
endif

set nocompatible              " be iMproved  
filetype off                  " required!  

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" 可以通过以下四种方式指定插件的来源  
" a) 指定Github中vim-scripts仓库中的插件，直接指定插件名称即可，插件明中的空格使用“-”代替。  
" Bundle 'L9'  

                                 
" b) 指定Github中其他用户仓库的插件，使用“用户名/插件名称”的方式指定  
" Bundle 'tpope/vim-fugitive'  
" Bundle 'Lokaltog/vim-easymotion'  
" Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}  
" Bundle 'tpope/vim-rails.git'  

" c) 指定非Github的Git仓库的插件，需要使用git地址 
" Bundle 'git://git.wincent.com/command-t.git'  

" d) 指定本地Git仓库中的插件  
" Bundle 'file:///Users/gmarik/path/to/plugin'  

filetype plugin indent on "required!


" Colorscheme
Plugin 'morhetz/gruvbox'
" Plugin 'altercation/vim-colors-solarized'

Bundle 'bling/vim-airline'

" Add file explorer
Plugin 'scrooloose/nerdtree'

" Add git plugin
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" add comment plugin
Plugin 'tpope/vim-commentary'

" file finding plugin
Plugin 'kien/ctrlp.vim'

" run command directly
Bundle 'christoomey/vim-run-interactive'

call vundle#end()            " required
filetype plugin indent on    " required


" ================== configuration ====================
" ---- misc ----
" set nobackup
"set backupdir=~/tmp,/tmp
set nobackup
set nowritebackup
set noswapfile

" set for vimdiff
set laststatus=2 "show the status line
set statusline=%-10.3n  "buffer number

" share clipboard
set clipboard+=unnamed

set autoindent
set cindent

set tabstop=4
set softtabstop=4
set shiftwidth=4

set ignorecase
set incsearch
set gdefault

" ---- key map ----
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

let mapleader = ","

map <silent> <leader>1 :diffget 1<CR> :diffupdate<CR>
map <silent> <leader>2 :diffget 2<CR> :diffupdate<CR>
map <silent> <leader>3 :diffget 3<CR> :diffupdate<CR>
map <silent> <leader>4 :diffget 4<CR> :diffupdate<CR>

map <leader>f :NERDTreeToggle<CR>
map <leader>b :CtrlPBuffer<CR>

nnoremap <leader>ri :RunInInteractiveShell<space>

inoremap fd <Esc>

" ---- display related ----
set shortmess=atI    " remove display of donation
set nu              " display line number
set go=             " no icon

set background=dark
colorscheme gruvbox
" colorscheme solarized

set laststatus=2
set wildmode=longest,list,full
set wildmenu

set showcmd		" display incomplete commands

set foldenable      " allowed fold
set foldmethod=manual   " fold manually

se cul " highlight current line


" ---- font ----
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8


" ---- config plugin ----
"  --- NERDTree ---
let NERDTreeShowBookmarks=1
"  --- NERDTree GIT ---
let g:NERDTreeIndicatorMapCustom = {
			\ "Modified"  : "✹",
			\ "Staged"    : "✚",
			\ "Untracked" : "✭",
			\ "Renamed"   : "➜",
			\ "Unmerged"  : "═",
			\ "Deleted"   : "✖",
			\ "Dirty"     : "✗",
			\ "Clean"     : "✔︎",
			\ "Unknown"   : "?"
			\ }
