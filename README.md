macvim .vimrc file manage

1.
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

mkdir ~/vimconfig
cd ~/vimconfig
git clone git@github.com:sunminghong/vimconfig.git ./

2.
cp .vimrc ~/
cp -r ./vim ~/

3.open macvim
:BuddleInstall


4.问题

中文输入法：
我用的是QQ五笔，但在编辑模式中输入中文时，常常会触发MacVim的命令，原因是输是输入法没有完全截获按键；
解决方法:在命令行输入以下命令,
defaults write org.vim.MacVim MMUseInlineIm 0

5.在终端启动mvim

下载后有一个mvim文件，将其拷贝到
$sudo cp -f mvim /usr/bin/

这里在终端通过mvim指令即可运行或编辑文件，编辑文件每次都是新建窗口，让他支持tab可以编辑这个mvim文件，首行加上
tabs=true

然后最后一个if 块替换成
if [ "$gui" ]; then
  if $tabs && [[ `$binary --serverlist` = "VIM" ]]; then
    exec "$binary" -g $opts --remote-tab-silent ${1:+"$@"}
  else
    exec "$binary" -g $opts ${1:+"$@"}
  fi
else
  exec "$binary" $opts ${1:+"$@"}
fi

6.配置ctags
a.download ctags (use google to search)
b.configure && make && make install
c. :BuddleInstall

6.2 配置golang 的 ctags
a. go get https://github.com/jstemmer/gotags
b. go build gotags
c. cp gotags /usr/local/bin

6.3 配置golang的completion



$ brew install coreutils
$ ln -s /usr/local/bin/greadlink /usr/local/bin/readlinko
** Vundle install : https://github.com/Blackrush/vim-gocode**

**记住:在终端下运行mvim时,后面必须跟上文件名(可以随意的一个文件名)**

That's ok !

