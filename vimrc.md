# create .vimrc
```bash
vim ~/.vimrc
```

```bash
set nu
set relativenumber
set ai
set cursorline
set bg=light
set tabstop=4
set shiftwidth=4
set mouse=a
set ruler
set backspace=2
set expandtab
set hlsearch
set incsearch

inoremap ( ()<ESC>i
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
inoremap [ []<ESC>i
inoremap {<CR> {<CR>}<ESC>ko<TAB>
inoremap {{ {}<ESC>i

filetype indent on

hi LineNr cterm=bold ctermfg=DarkGrey ctermbg=NONE
hi CursorLineNr cterm=bold ctermfg=Green ctermbg=NONE
```
