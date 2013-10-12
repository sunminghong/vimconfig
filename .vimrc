"设置颜色主题
colorscheme torte
"colorscheme busybee

if has("gui_running")
    set go=aAce              " 去掉难看的工具栏和滑动条
    set guifont=Monaco:h14   " 设置默认字体为monaco
    set showtabline=2        " 开启自带的tab栏
    set columns=84          " 设置宽
    set lines=46             " 设置长
endif

"字体设置
"set guifont=Arial_monospaced_for_SAP:h16
let s:font_tchinese='MingLiU:h12:cDEFAULT'
let s:font_japanese='MS_Gothic:h12:cDEFAULT'
let s:font_korean='GulimChe:h12:cDEFAULT'
"设置透明度
"set transparency=10
"不兼容vi模式
set nocompatible

filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
"
Bundle 'thoughtbot/vim-rspec'
Bundle 'ack.vim'
Bundle 'comments.vim'
"Bundle 'authorinfo.vim'
Bundle 'ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
"Bundle 'rspec.vim'
Bundle 'honza/vim-snippets'
Bundle 'ervandew/supertab'
"Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-bundler'
"Bundle 'kchmck/vim-coffee-script'
Bundle 'flazz/vim-colorschemes'
"Bundle 'tpope/vim-fugitive'
"Bundle 'tpope/vim-haml'
"Bundle 'tpope/vim-rails'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'pangloss/vim-javascript'
Bundle 'jelera/vim-javascript-syntax'
"Bundle 'briancollins/vim-jst'
Bundle 'plasticboy/vim-markdown'
Bundle 'Lokaltog/vim-powerline'
"Bundle 'vim-ruby/vim-ruby'
"Bundle 'slim-template/vim-slim'
""Bundle 'sudo.vim'
Bundle 'xml.vim'
Bundle 'ZenCoding.vim'

set rtp+=/usr/local/go/misc/vim


filetype plugin indent on

"显示行号
set number
"按照C语法自动缩进
set cindent
"设置缩进长度
"详见http://dddspace.com/2010/03/vim-indentation-and-space-config.html
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab
"显示括号对应
set showmatch
"实时显示搜索结果
set incsearch
"编码设置
set encoding=utf-8
"set fileencodings=utf-8,gb2312,ucs-bom,utf-16,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileencodings=ucs-bom,utf-8,chinese,latin1
"set fencs=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936  
set fileformats=unix,mac,dos
set autoindent
set smartindent
set showcmd

set nobackup			"取消备份
set hlsearch			"设置搜索结果高亮
set incsearch			"设置搜索的同时高亮

"忽略大小写查找
set ic

""auto completed
""RUBY
"let g:rubycomplete_buffer_loading = 1
"let g:rubycomplete_classes_in_global = 1
"let g:rubycomplete_rails = 1
"
""RUBY plugin
"autocmd FileType ruby compiler ruby
"
"autocmd vimenter * if !argc() | NERDTree | endif
"autocmd VimEnter * NER



" 设定文件浏览器目录为当前目录  
set bsdir=buffer  

" set 折叠
set foldmethod=indent
" 打开文件默认不折叠
set foldlevelstart=99

let g:vim_markdown_folding_disabled = 0


"  映射NERDTree插件
":map <leader>n :NERDTree<CR>  
"let loaded_nerd_tree = 1
let NERDTreeQuitOnOpen = 1
let NERDChristmasTree=1
let g:NERDTreeWinSize = 18 


" 把 CTRL-S 映射为 保存,因为这个操作做得太习惯了  
imap <C-S> <C-C>:w<CR>  

"set zen coding
 let g:user_zen_settings = {
  \  'php' : {
  \    'extends' : 'html',
  \    'filters' : 'c',
  \  },
  \  'xml' : {
  \    'extends' : 'html',
  \  },
  \  'haml' : {
  \    'extends' : 'html',
  \  },
  \  'erb' : {
  \    'extends' : 'html',
  \  },
  \}
"set CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 2
"use in  edit
imap <C-A> <C-C><c-p>



set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.jpg,*.png,*.gif,*.jpeg,.DS_Store  " MacOSX/Linux
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'

"语法高亮
syntax on

autocmd! BufNewFile,BufRead *.{md,mkd,mkdn,mark*} set filetype=markdown "加入MarkDown语法
"scss,sass
au BufRead,BufNewFile *.scss set filetype=scss
au BufRead,BufNewFile *.sass set filetype=scss

" skeleton file
" 自动使用新文件模板
autocmd BufNewFile test*.py 0r ~/.vim/skeleton/test.py
autocmd BufNewFile alltests.py 0r ~/.vim/skeleton/alltests.py
autocmd BufNewFile *.py 0r ~/.vim/skeleton/skeleton.py

""ctags
"set tags+=~/gitdb/rails/tags

"auto completed
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0


" Enable omni completion.
autocmd FileType python setlocal et sta sw=4 sts=4			"将python 文件的tab键用空格代替
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.python = '[^. *\t]\.\w*\|\h\w*::'


" code search
let g:ackprg = 'ag --nogroup --nocolor --column'

"set powerline
set laststatus=2 
set t_Co=256
let g:Powerline_cache_enabled = 1

"minitest
set completefunc=syntaxcomplete#Complete

"process past
set pastetoggle=<F2>
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>


let g:vimrc_author="sunminghong"
let g:vimrc_email="allen.fantasy@gmail.com"
let g:vimrc_homepage="http://weibo.com/5d13"

nmap <F4> :AuthorInfoDetect<cr>

function! GetFileList(...)
    if exists('a:1')
        let path = a:1
    else
        let path = glob("%:h")
    endif
    if exists('a:2')
        let ext = a:2
    else
        let ext = "as"
    endif
    let trueList = []
    " 获取子目录中的文件列表
    let fileList = split(glob(path."/**/*.".ext), "\<NL>")
    for afile in fileList
        if isdirectory(afile)
        " 排除目录
            continue    
        end
        call add(trueList, afile)
    endfor
    return trueList
endfunction
 
" 输出buffer列表到当前缓冲区
function! EchoBaddList(...)
    let baddList = call("GetFileList", a:000)
    for afile in baddList
        execute 'normal obadd '.afile
    endfor
endfunction
 
" 将path中的文件直接加入buffer列表
function! BaddList(...)
    let baddList = call("GetFileList", a:000)
    for afile in baddList
        execute 'badd '.afile
    endfor
endfunctio

set autochdir       "自动切换工作目录，以当前打开的文件所在目录为准

map <F7> :NERDTreeToggle<CR>
imap <F7> <ESC>:NERDTreeToggle<CR>
map <c-F7> :NERDTree<cr>

map <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
