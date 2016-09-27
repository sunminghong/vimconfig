###macvim 配置说明档

1. 复制.vim 配置文件
	git clone git@github.com:sunminghong/vimconfig.git ~/vimconfig  

	cp ~/vimconfig/dotvimrc ~/.vimrc  
	cp -rf ~/vimconfig/dotvim  ~/.vim  	
	rm -rf ~/vimconfig  
	
2. 安装vundle
	git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle  

3. open macvim 安装插件  
	:BuddleInstall  


4. 中文输入法问题：
我用的是搜狗输入法，但在编辑模式中输入中文时，常常会触发MacVim的命令，原因是输入法没有完全截获按键；
解决方法:在命令行输入以下命令,
	defaults write org.vim.MacVim MMUseInlineIm 0

5. 在终端启动mvim

macvim.app包内容里有一个mvim文件，将其拷贝到
	$sudo cp -f mvim /usr/bin/

这里在终端通过mvim指令即可运行或编辑文件，编辑文件每次都是新建窗口，让他支持tab可以编辑这个mvim文件，首行加上
	tabs=true

然后最后一个if 块替换成:

	if [ "$gui" ]; then
	  if $tabs && [[ `$binary --serverlist` = "VIM" ]]; then
		exec "$binary" -g $opts --remote-tab-silent ${1:+"$@"}
	  else
		exec "$binary" -g $opts ${1:+"$@"}
	  fi
	else
	  exec "$binary" $opts ${1:+"$@"}
	fi

	**记住:在终端下运行mvim时,后面必须跟上文件名(可以是打算新建的文件名)**

6. 配置ctags

	a.download ctags (use google to search)
	b.configure && make && make install
	c. :BuddleInstall

7. 配置golang 的 ctags
	go get https://github.com/jstemmer/gotags
	go build gotags
	cp gotags /usr/local/bin

8. 配置golang的completion
	*用<tab>键可以显示自动补全菜单,用<j>,<k>可以上线浏览补全菜单.*

	go get github.com/bradfitz/goimports
	go get code.google.com/p/rog-go/exp/cmd/godef
	go get github.com/nsf/gocode

	brew install coreutils
	ln -s /usr/local/bin/greadlink /usr/local/bin/readlinko

**由于macvim 是不执行.bashrc 的,所以需要将gocode/godef/goimports copy /usr/local/bin 或者 将go bin 路径添加到 /etc/paths 中**
	/Users/XXX/works/GitHub/golang/bin

**如果发现go文件保存,总是自动检查文件语法错误和格式化,那么可以将vimconfig/dotvim/bundle/vim-gocode/ftplugin/go/的以下文件覆盖 ~/.vim下的同路径文件**

一些快捷键如下:

	gd		跳转到光标所在函数定义处(会另开窗口打开文件,有godef提供)
	<tab>	自动补全菜单
	<j>,<k> 对自动完成菜单上下浏览,回车选择当前项


That's ok !

