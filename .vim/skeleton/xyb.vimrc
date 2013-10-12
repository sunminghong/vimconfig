" ~/.vimrc
" Last modified: 2004年09月21日 星期二 16时08分24秒 [debian]
" 解彦博的 vim 配置文件

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set autoindent          " always set autoindenting on
if has("vms")
  set nobackup          " do not keep a backup file, use versions instead
else
  set backup            " keep a backup file
  " 自动备份，我的备份大都在 ~/.backup 中，它好几次都帮了我的大忙 :)
  set backupdir=./.backup,~/.backup,.,/tmp
endif
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set incsearch           " do incremental searching

" Don't use Ex mode, use Q for formatting
" 排版用的
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" 我常用的文本编码 GBK
set encoding=euc-cn
"set encoding=utf-8

" DO NOT BELL!
" 不要用声音烦我！
set visualbell

" 用鼠标画文本表格用的
:map <F1> :call ToggleSketch()<CR>

"  树形文本的展开、收缩
if version >= 600
  " Reduce folding
  map <F2> zr
  map <S-F2> zR
  " Increase folding
  map <F3> zm
  map <S-F3> zM
endif

" Do not show help in file-explorer
let explDetailedHelp=0
" Open a file explorer
" 我喜欢用F4键打开一个文件浏览窗口
if has("vertsplit")
  nnoremap <silent> <F4> :call FileExplOpen()<CR>
  if !exists("*FileExplOpen")
    fun FileExplOpen()
      if @% == ""
        20vsp .
      else
        exe "20vsp " . expand("%:p:h")
      endif
    endfun
  endif
endif

" 插入系统日期
map <F5> :r !date +\%c<CR>

" 函数，修改文件头部的最后修改时间，就象这个文件的头部一样
function! LastMod()
  if line("$") > 5
    let l = 5
  else
    let l = line("$")
  endif
  exe "1," . l . "s/[Ll]ast [Mm]odified: .*/Last modified: " . strftime("%c") . " [" . hostname() . "]/e"
endfunction

" 手工更新文件最后修改时间
map ,L :call LastMod()<CR>

" Edit "Last modified"-comment in the top 5 lines of config files
" 自动更新文件修改时间
if has("autocmd")
  augroup lastmod
    autocmd!
    autocmd BufWritePre,FileWritePre * exec("normal ms")|call LastMod()|exec("normal `s")
  augroup END
endif

" Show TAB char and end space
" 我不喜欢 tab 和每行尾巴上的多余空格，如果文件里有，要记得告诉我
set listchars=tab:>-,trail:~
set list
syntax match Trail " +$"
highlight def link Trail Todo

" python auto-complete code
" Typing the following (in insert mode):
"   os.lis<Ctrl-n>
" will expand to:
"   os.listdir(
" Python 自动补全功能，只需要反覆按 Ctrl-N 就行了
if has("autocmd")
  autocmd FileType python set complete+=k~/.vim/tools/pydiction
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " 自动检测文件类型并加载相应的设置
  filetype plugin indent on

  " For all text files set 'textwidth' to 71 characters.
  autocmd FileType text setlocal textwidth=71

  " zope dtml
  autocmd BufNewFile,BufRead *.dtml setf dtml

  " python, not use <tab>
  " Python 文件的一般设置，比如不要 tab 等
  autocmd FileType python setlocal et | setlocal sta | setlocal sw=4
  " Python Unittest 的一些设置
  " 可以让我们在编写 Python 代码及 unittest 测试时不需要离开 vim
  " 键入 :make 或者点击 gvim 工具条上的 make 按钮就自动执行测试用例
  autocmd FileType python compiler pyunit | setlocal makeprg=python\ %
  autocmd FileType python setlocal makeprg=python\ ./alltests.py
  autocmd BufNewFile,BufRead test*.py setlocal makeprg=python\ %
  " skeleton file
  " 自动使用新文件模板
  autocmd BufNewFile test*.py 0r ~/.vim/skeleton/test.py
  autocmd BufNewFile alltests.py 0r ~/.vim/skeleton/alltests.py
  autocmd BufNewFile *.py 0r ~/.vim/skeleton/skeleton.py

  " shell script
  autocmd fileType sh setlocal sw=4 | setlocal sta

  " RedHat spec file
  autocmd BufNewFile,BufReadPost *.spec setf spec

  " Brainfuck file
  autocmd BufNewFile,BufReadPost *.b setf brainfuck

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " 记住上次的编辑位置
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

endif " has("autocmd")
