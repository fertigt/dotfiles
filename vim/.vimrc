syntax on
colorscheme onedark

" switch to 4 spaces per tab
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" set line numbers
set nu
set relativenumber
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

" do not copy line numbers when copy&pasting with mouse
se mouse+=a

" improve search via /
set nohlsearch
set incsearch

" no swapfile
set noswapfile
set nobackup

set scrolloff=8
set signcolumn=yes

" trim trailing whitespaces when saving files
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup FT
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END