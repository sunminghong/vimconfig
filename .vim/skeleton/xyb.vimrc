" ~/.vimrc
" Last modified: 2004��09��21�� ���ڶ� 16ʱ08��24�� [debian]
" ���岩�� vim �����ļ�

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
  " �Զ����ݣ��ҵı��ݴ��� ~/.backup �У����ü��ζ������ҵĴ�æ :)
  set backupdir=./.backup,~/.backup,.,/tmp
endif
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set incsearch           " do incremental searching

" Don't use Ex mode, use Q for formatting
" �Ű��õ�
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" �ҳ��õ��ı����� GBK
set encoding=euc-cn
"set encoding=utf-8

" DO NOT BELL!
" ��Ҫ���������ң�
set visualbell

" ����껭�ı�����õ�
:map <F1> :call ToggleSketch()<CR>

"  �����ı���չ��������
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
" ��ϲ����F4����һ���ļ��������
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

" ����ϵͳ����
map <F5> :r !date +\%c<CR>

" �������޸��ļ�ͷ��������޸�ʱ�䣬��������ļ���ͷ��һ��
function! LastMod()
  if line("$") > 5
    let l = 5
  else
    let l = line("$")
  endif
  exe "1," . l . "s/[Ll]ast [Mm]odified: .*/Last modified: " . strftime("%c") . " [" . hostname() . "]/e"
endfunction

" �ֹ������ļ�����޸�ʱ��
map ,L :call LastMod()<CR>

" Edit "Last modified"-comment in the top 5 lines of config files
" �Զ������ļ��޸�ʱ��
if has("autocmd")
  augroup lastmod
    autocmd!
    autocmd BufWritePre,FileWritePre * exec("normal ms")|call LastMod()|exec("normal `s")
  augroup END
endif

" Show TAB char and end space
" �Ҳ�ϲ�� tab ��ÿ��β���ϵĶ���ո�����ļ����У�Ҫ�ǵø�����
set listchars=tab:>-,trail:~
set list
syntax match Trail " +$"
highlight def link Trail Todo

" python auto-complete code
" Typing the following (in insert mode):
"   os.lis<Ctrl-n>
" will expand to:
"   os.listdir(
" Python �Զ���ȫ���ܣ�ֻ��Ҫ������ Ctrl-N ������
if has("autocmd")
  autocmd FileType python set complete+=k~/.vim/tools/pydiction
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " �Զ�����ļ����Ͳ�������Ӧ������
  filetype plugin indent on

  " For all text files set 'textwidth' to 71 characters.
  autocmd FileType text setlocal textwidth=71

  " zope dtml
  autocmd BufNewFile,BufRead *.dtml setf dtml

  " python, not use <tab>
  " Python �ļ���һ�����ã����粻Ҫ tab ��
  autocmd FileType python setlocal et | setlocal sta | setlocal sw=4
  " Python Unittest ��һЩ����
  " �����������ڱ�д Python ���뼰 unittest ����ʱ����Ҫ�뿪 vim
  " ���� :make ���ߵ�� gvim �������ϵ� make ��ť���Զ�ִ�в�������
  autocmd FileType python compiler pyunit | setlocal makeprg=python\ %
  autocmd FileType python setlocal makeprg=python\ ./alltests.py
  autocmd BufNewFile,BufRead test*.py setlocal makeprg=python\ %
  " skeleton file
  " �Զ�ʹ�����ļ�ģ��
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
  " ��ס�ϴεı༭λ��
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

endif " has("autocmd")
