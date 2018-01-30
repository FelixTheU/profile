"********************************************************
"                   一般性配置                          *
"********************************************************
"设置背景色
set background=dark

"附上粘贴时胡乱缩进
set paste

"关闭vim一致性原则
set nocompatible

"显示行号
set number

"设置在编辑过程中右下角显示光标的行列信息
set ruler

"在状态栏显示正在输入的命令
set showcmd

"设置历史记录条数
set history=1000

"设置取消备份 禁止临时文件的生成
set nobackup
set noswapfile

"设置匹配模式
set showmatch

"设置C/C++方式自动对齐
set autoindent
set cindent

"开启语法高亮功能
syntax enable
syntax on

"指定配色方案为256色
set t_Co=256

"设置搜索时忽略大小写
set ignorecase

"高亮行尾的空格
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t\+\|\t\+\zs \+/

"设置ds按键为去除行尾空格
map ds :%s/\s\+$//g<CR>

set noswapfile                          "不生成.swp文件
set bg=dark                             "黑色背景
set completeopt=menu                    "关闭草稿
set paste                               "粘贴时 禁止自动缩进
set ruler                               "右下角显示光标当前位置
set scrolloff=10                        "光标到上下缓冲区边距
set nobackup                            "禁止生成临时文件
set nocindent                           "不使用C风格缩进
set noautoindent                        "不使用自动缩进
set shiftwidth=4                        "自动缩进字符宽度
set ts=4                                "tab键宽度
set expandtab                           "将tab符转为空格
%retab!                                 "对于已保存的文件,执行expandtab
set ignorecase                          "搜索时 忽略大小写
syntax on                               "语法高亮
set hls                                 "搜索高亮
set bg=dark                             "字体加亮
set nocompatible                        "去除兼容vi
set backspace=indent,eol,start			"允许使用退格键
set fileencodings=utf-8,GB18030			"打开文件 支持的字符集

"vim 属性设置
map q    :q<CR>
map w    :w<CR>
map make :! clear; make clean; make<CR>
map er   :%s/^#.*$//g<CR>
map sp   :g/^\s*$/d<CR>
 
autocmd BufEnter *.i set filetype=c

