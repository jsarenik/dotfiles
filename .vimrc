call pathogen#infect()
syntax enable
filetype plugin indent on
set background=dark
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smartindent

set fileencodings=utf-8 guifont=8x13bold encoding=utf-8
filetype plugin on
syntax on
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
